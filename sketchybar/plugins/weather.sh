#!/usr/bin/env bash

source "$HOME/.config/color/colors.sh"
source "$HOME/.config/sketchybar/plugins/popup.sh"

WEATHER_CONFIG="$HOME/.config/sketchybar/plugins/weather_config.json"
APPLE_WEATHER_HELPER="$HOME/.config/sketchybar/plugins/apple_weather.sh"
WEATHER_USER_AGENT="SketchyBar Weather (tobin@localhost)"
WEATHER_CACHE="$HOME/Library/Caches/sketchybar/weather.json"

apple_weather() {
    local latitude longitude

    latitude=$(jq -r '.weathergov.latitude' "$WEATHER_CONFIG")
    longitude=$(jq -r '.weathergov.longitude' "$WEATHER_CONFIG")

    "$APPLE_WEATHER_HELPER" "$latitude" "$longitude"
}

weather_request() {
    curl -fsSL \
        -H "Accept: application/geo+json" \
        -H "User-Agent: $WEATHER_USER_AGENT" \
        "$1"
}

forecast_url() {
    local latitude longitude points_url points_response

    latitude=$(jq -r '.weathergov.latitude' "$WEATHER_CONFIG")
    longitude=$(jq -r '.weathergov.longitude' "$WEATHER_CONFIG")
    points_url=$(jq -r '.weathergov.points_url' "$WEATHER_CONFIG")
    points_response=$(weather_request "$points_url/$latitude,$longitude") || return 1

    echo "$points_response" | jq -r '.properties.forecast'
}

weathergov_weather() {
    local latitude longitude url raw_weather

    latitude=$(jq -r '.weathergov.latitude' "$WEATHER_CONFIG")
    longitude=$(jq -r '.weathergov.longitude' "$WEATHER_CONFIG")
    url=$(forecast_url) || return 1
    raw_weather=$(weather_request "$url") || return 1

    jq -cn \
        --argjson latitude "$latitude" \
        --argjson longitude "$longitude" \
        --argjson raw "$raw_weather" '
        def precip($period):
            ($period.probabilityOfPrecipitation.value // 0);

        def pair_periods:
            reduce .[] as $period (
                [];
                if $period.isDaytime then
                    if length > 0 and .[-1].high == null and .[-1].low != null then
                        .[-1] |= (
                            .name = $period.name
                            | .condition = $period.shortForecast
                            | .high = $period.temperature
                            | .precipitationChance = ([.precipitationChance, precip($period)] | max)
                        )
                    else
                        . + [{
                            name: $period.name,
                            condition: $period.shortForecast,
                            high: $period.temperature,
                            low: null,
                            precipitationChance: precip($period)
                        }]
                    end
                else
                    if length > 0 and .[-1].high != null and .[-1].low == null then
                        .[-1] |= (
                            .low = $period.temperature
                            | .precipitationChance = ([.precipitationChance, precip($period)] | max)
                        )
                    else
                        . + [{
                            name: $period.name,
                            condition: $period.shortForecast,
                            high: null,
                            low: $period.temperature,
                            precipitationChance: precip($period)
                        }]
                    end
                end
            );

        {
            temperature: ($raw.properties.periods[0].temperature),
            condition: ($raw.properties.periods[0].shortForecast),
            isDaylight: ($raw.properties.periods[0].isDaytime),
            locationSource: "weathergov",
            coordinates: {
                latitude: $latitude,
                longitude: $longitude
            },
            forecast: (
                ($raw.properties.periods | .[0:8] | pair_periods)
                | map(select(.high != null and .low != null))
                | .[0:3]
            )
        }'
}

load_weather() {
    local weather_payload

    mkdir -p "$(dirname "$WEATHER_CACHE")"

    if weather_payload=$(apple_weather 2>/dev/null); then
        printf '%s\n' "$weather_payload" >"$WEATHER_CACHE"
        printf '%s\n' "$weather_payload"
        return 0
    fi

    if weather_payload=$(weathergov_weather 2>/dev/null); then
        printf '%s\n' "$weather_payload" >"$WEATHER_CACHE"
        printf '%s\n' "$weather_payload"
        return 0
    fi

    if [[ -s "$WEATHER_CACHE" ]]; then
        cat "$WEATHER_CACHE"
        return 0
    fi

    return 1
}

ascii_text() {
    LC_ALL=C printf '%s' "$1" | tr -cd '[:print:]\n'
}

function get_temp_color() {
    if [[ $1 =~ ^[0-9]$ ]]; then
        echo "$VERY_COLD"
    elif [[ $1 =~ ^[1-2][0-9] ]]; then
        echo "$VERY_COLD"
    elif [[ $1 =~ ^([3][0-9]|[4][0-5]) ]]; then
        echo "$COLD"
    elif [[ $1 =~ ^([4][6-9]|[5][0-5]) ]]; then
        echo "$COLD"
    elif [[ $1 =~ ^([5][6-9]|[6][0-5]) ]]; then
        echo "$COOL"
    elif [[ $1 =~ ^([6][6-9]|[7][0]) ]]; then
        echo "$COOL"
    elif [[ $1 =~ ^[7][1-5] ]]; then
        echo "$NICE"
    elif [[ $1 =~ ^[7][6-9] ]]; then
        echo "$NICE"
    elif [[ $1 =~ ^[8][0-5] ]]; then
        echo "$WARM"
    elif [[ $1 =~ ^([8][6-9]|[9][0]) ]]; then
        echo "$HOT"
    elif [[ $1 =~ ^[9][1-9] ]]; then
        echo "$VERY_HOT"
    elif [[ $1 =~ ^[1-9]dd ]]; then
        echo "$VERY_HOT"
    else
        echo "$VERY_HOT"
    fi
}

# False = night
# True = daytime
weather_icon_map() {
    case $@ in
        *"Clear"* | *"Mostly Clear"*)
            icon_result="􀆺"
            ;;
        *"Mostly Cloudy"* | *"Cloudy"* | *"Partly Cloudy"* | *"Haze"* | *"Smoky"*)
            icon_result="􀇃"
            ;;
        *"Rain"* | *"Drizzle"* | *"Sun Showers"*)
            icon_result="􀇆"
            ;;
        *"Slight Chance Rain Showers"* | *"Chance Rain Showers"*)
            icon_result="􀇄"
            ;;
        *"Slight Chance Light Snow"* | *"Chance Light Snow"* | *"Snow Likely"* | *"Flurries"* | *"Wintry Mix"* | *"Sleet"* | *"Freezing Rain"* | *"Freezing Drizzle"*)
            icon_result="􀇌"
            ;;
        *"Snow Showers"* | *"Snow Showers Likely"* | *"Chance Snow Showers"* | *"Heavy Snow"* | *"Snow and Patchy Blowing Snow"* | *"Blowing Snow"* | *"Blizzard"*)
            icon_result="􀇄"
            ;;
        *"Patchy Fog"* | *"Areas Of Fog"* | *"Widespread Fog"* | *"Foggy"*)
            icon_result="􀇊"
            ;;
        *"Thunderstorms"* | *"Scattered Thunderstorms"* | *"Strong Storms"* | *"Tropical Storm"* | *"Hurricane"*)
            icon_result="􀇟"
            ;;
        *"Breezy"* | *"Windy"*)
            icon_result="􀇞"
            ;;
            # Daytime
        *"Snow"* | *"Snow Showers"*)
            icon_result="􀇎"
            ;;
        *"Slight Chance Light Rain"* | *"Chance Light Rain"*)
            icon_result="􀇆"
            ;;
        *"Rain Showers Likely"* | *"Rain Showers"* | *"Chance Rain Showers"* | *"Change Showers And Thunderstroms then Mostly Sunny"* | *"Chance Showers And Thunderstorms then Mostly Sunny"*)
            icon_result="􀇆"
            ;;
        *"Mostly Sunny"* | *"Sunny"*)
            icon_result="􀆭"
            ;;
        *"Partly Sunny"* | *"Mostly Sunny"*)
            icon_result="􀇕"
            ;;
        *"Drizzle"* | *"Mostly Sunny"* | *"Showers"*)
            icon_result="􀇄"
            ;;

            # No Match
        *)
            icon_result="$@"
            ;;
    esac
    echo $icon_result
}


render_bar() {
    temp_color=$(get_temp_color $temp)
    sketchybar --set weather.icon icon="$icon"
    sketchybar --set weather.temp label="$temp""°"
    sketchybar --set weather.temp label.color="$temp_color"
}


render_popup() {
    sketchybar --remove '/weather\.details\..*/' >/dev/null 2>&1

    today_high=$(echo "$weather" | jq -r '.forecast[0].high')
    today_low=$(echo "$weather" | jq -r '.forecast[0].low')
    popup_summary=$(ascii_text "$forecast")

    weather_details=(
        label="$popup_summary | H $today_high | L $today_low"
        label.padding_left=80
        click_script="sketchybar --set $NAME popup.drawing=off"
        position=popup.weather.temp
        drawing=on
    )

    COUNTER=0

    sketchybar --clone weather.details."$COUNTER" weather.details
    sketchybar --set weather.details."$COUNTER" "${weather_details[@]}"

    echo "$weather" | jq -cr '.forecast[]' | while read -r period; do
        COUNTER=$((COUNTER + 1))

        if [ "$COUNTER" -lt 4 ]; then
            period_name=$(jq -r '.name' <<<"$period")
            condition=$(jq -r '.condition' <<<"$period")
            high=$(jq -r '.high' <<<"$period")
            low=$(jq -r '.low' <<<"$period")
            precipitation_chance=$(jq -r '.precipitationChance' <<<"$period")

            period_name=$(ascii_text "$period_name")
            condition=$(ascii_text "$condition")

            line="$condition"

            if [ "$precipitation_chance" -gt 0 ] 2>/dev/null; then
                line="$line | Rain $precipitation_chance%"
            fi

            weather_period=(
                icon="$period_name"
                icon.color="$BLUE"
                label="$line"
                label.drawing=on
                click_script="sketchybar --set $NAME popup.drawing=off"
                drawing=on
            )

            item=weather.details."$COUNTER"
            sketchybar --add item "$item" popup.weather.temp
            sketchybar --set "$item" "${weather_period[@]}"

            high_period=(
                icon="H"
                icon.color="$RED"
                label="$high"
                label.drawing=on
                click_script="sketchybar --set $NAME popup.drawing=off"
                drawing=on
            )

            item=weather.details."$COUNTER".high
            sketchybar --add item "$item" popup.weather.temp
            sketchybar --set "$item" "${high_period[@]}"

            low_period=(
                icon="L"
                icon.color="$BLUE"
                label="$low"
                label.drawing=on
                click_script="sketchybar --set $NAME popup.drawing=off"
                drawing=on
            )

            item=weather.details."$COUNTER".low
            sketchybar --add item "$item" popup.weather.temp
            sketchybar --set "$item" "${low_period[@]}"

            sketchybar --add item weather.details.newline."$COUNTER" popup.weather.temp
        fi
    done
}

update() {
    weather=$(load_weather) || exit 0
    temp=$(echo "$weather" | jq -r '.temperature')
    forecast=$(echo "$weather" | jq -r '.condition')
    time=$(echo "$weather" | jq -r '.isDaylight')
    icon=$(weather_icon_map "$time" "$forecast")

    render_bar
    render_popup

    if [ "$COUNT" -ne "$PREV_COUNT" ] 2>/dev/null || [ "$SENDER" = "forced" ]; then
        sketchybar --animate tanh 15 --set "$NAME" label.y_offset=5 label.y_offset=0
    fi
}

popup() {
    case "$1" in
        on) open_popup_exclusive "$NAME" ;;
        toggle) toggle_popup_exclusive "$NAME" ;;
        *) sketchybar --set "$NAME" popup.drawing="$1" ;;
    esac
}

case "$SENDER" in
    "routine" | "forced")
        update
        ;;
    "mouse.entered")
        popup on
        ;;
    "mouse.exited" | "mouse.exited.global")
        popup off
        ;;
    "mouse.clicked")
        popup toggle
        ;;
esac
