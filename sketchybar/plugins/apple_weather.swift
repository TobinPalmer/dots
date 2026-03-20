import CoreLocation
import Foundation
import WeatherKit

struct Coordinates: Codable {
    let latitude: Double
    let longitude: Double
}

struct ForecastDay: Codable {
    let name: String
    let condition: String
    let high: Int
    let low: Int
    let precipitationChance: Int
}

struct WeatherPayload: Codable {
    let temperature: Int
    let condition: String
    let isDaylight: Bool
    let locationSource: String
    let coordinates: Coordinates
    let forecast: [ForecastDay]
}

enum AppleWeatherError: Error {
    case invalidArguments
}

final class CurrentLocationProvider: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    private let semaphore = DispatchSemaphore(value: 0)
    private var coordinate: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }

    func currentLocation(timeout: TimeInterval) -> CLLocationCoordinate2D? {
        let status = manager.authorizationStatus

        if status == .authorizedAlways {
            if let cached = manager.location?.coordinate {
                return cached
            }

            manager.requestLocation()

            if semaphore.wait(timeout: .now() + timeout) == .success {
                return coordinate
            }

            return nil
        }

        if status == .notDetermined {
            manager.requestAlwaysAuthorization()
        }

        return nil
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        coordinate = locations.last?.coordinate
        semaphore.signal()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        semaphore.signal()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedAlways {
            manager.requestLocation()
        } else if manager.authorizationStatus == .denied || manager.authorizationStatus == .restricted {
            semaphore.signal()
        }
    }
}

func fahrenheit(_ measurement: Measurement<UnitTemperature>) -> Int {
    Int(measurement.converted(to: .fahrenheit).value.rounded())
}

func formatCondition(_ condition: WeatherCondition) -> String {
    let raw = String(describing: condition)
    var words: [String] = []
    var current = ""

    for character in raw {
        if character.isUppercase, !current.isEmpty {
            words.append(current)
            current = String(character)
        } else {
            current.append(character)
        }
    }

    if !current.isEmpty {
        words.append(current)
    }

    return words.joined(separator: " ")
}

func displayName(for date: Date, calendar: Calendar, formatter: DateFormatter) -> String {
    if calendar.isDateInToday(date) {
        return "Today"
    }

    if calendar.isDateInTomorrow(date) {
        return "Tomorrow"
    }

    return formatter.string(from: date)
}

func fetchWeather(
    latitude: Double,
    longitude: Double,
    locationSource: String
) async throws -> WeatherPayload {
    let service = WeatherService.shared
    let location = CLLocation(latitude: latitude, longitude: longitude)
    let weather = try await service.weather(for: location)
    let calendar = Calendar.autoupdatingCurrent
    let formatter = DateFormatter()
    formatter.locale = Locale.autoupdatingCurrent
    formatter.setLocalizedDateFormatFromTemplate("EEE")

    let forecast = weather.dailyForecast.forecast.prefix(3).map { day in
        ForecastDay(
            name: displayName(for: day.date, calendar: calendar, formatter: formatter),
            condition: formatCondition(day.condition),
            high: fahrenheit(day.highTemperature),
            low: fahrenheit(day.lowTemperature),
            precipitationChance: Int((day.precipitationChance * 100).rounded())
        )
    }

    return WeatherPayload(
        temperature: fahrenheit(weather.currentWeather.temperature),
        condition: formatCondition(weather.currentWeather.condition),
        isDaylight: weather.currentWeather.isDaylight,
        locationSource: locationSource,
        coordinates: Coordinates(latitude: latitude, longitude: longitude),
        forecast: forecast
    )
}

func parseArguments() throws -> (Double, Double) {
    guard CommandLine.arguments.count >= 3,
          let latitude = Double(CommandLine.arguments[1]),
          let longitude = Double(CommandLine.arguments[2]) else {
        throw AppleWeatherError.invalidArguments
    }

    return (latitude, longitude)
}

let semaphore = DispatchSemaphore(value: 0)
var exitCode: Int32 = 0

Task {
    defer { semaphore.signal() }

    do {
        let (fallbackLatitude, fallbackLongitude) = try parseArguments()
        let currentCoordinate = CurrentLocationProvider().currentLocation(timeout: 0.75)
        let latitude = currentCoordinate?.latitude ?? fallbackLatitude
        let longitude = currentCoordinate?.longitude ?? fallbackLongitude
        let source = currentCoordinate == nil ? "fallback" : "current"
        let payload = try await fetchWeather(
            latitude: latitude,
            longitude: longitude,
            locationSource: source
        )
        let encoder = JSONEncoder()
        let data = try encoder.encode(payload)

        if let json = String(data: data, encoding: .utf8) {
            print(json)
        } else {
            exitCode = 1
        }
    } catch {
        exitCode = 1
    }
}

semaphore.wait()
exit(exitCode)
