#!/usr/bin/env bash

source "$HOME/.config/color/colors.sh"
source "$HOME/.config/sketchybar/plugins/popup.sh"

WEATHER_CONFIG="$HOME/.config/sketchybar/plugins/weather_config.json"
WEATHER_USER_AGENT="SketchyBar Weather (tobin@localhost)"

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
        *"Mostly Cloudy"* | *"Cloudy"* | *"Partly Cloudy"*)
            icon_result="􀇃"
            ;;
        *"Rain"*)
            icon_result="􀇆"
            ;;
        *"Slight Chance Rain Showers"* | *"Chance Rain Showers"*)
            icon_result="􀇄"
            ;;
        *"Slight Chance Light Snow"* | *"Chance Light Snow"* | *"Snow Likely"*)
            icon_result="􀇌"
            ;;
        *"Snow Showers"* | *"Snow Showers Likely"* | *"Chance Snow Showers"* | *"Heavy Snow"* | *"Snow and Patchy Blowing Snow"*)
            icon_result="􀇄"
            ;;
        *"Patchy Fog"* | *"Areas Of Fog"* | *"Widespread Fog"*)
            icon_result="􀇊"
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
    sketchybar --remove '/weather.details.\.*/'

    weather_details=(
        label="$forecast"
        label.padding_left=80
        click_script="sketchybar --set $NAME popup.drawing=off"
        position=popup.weather.temp
        drawing=on
    )

    COUNTER=0

    sketchybar --clone weather.details."$COUNTER" weather.details
    sketchybar --set weather.details."$COUNTER" "${weather_details[@]}"

    echo "$weather" | jq -r '.properties.periods[] | @base64' | while read -r period; do
        COUNTER=$((COUNTER + 1))

        if [ "$COUNTER" -lt 4 ]; then
            decoded_period=$(echo "$period" | base64 --decode)
            period_name=$(echo "$period" | base64 --decode | jq -r '.name')
            detailed_forecast=$(echo "$decoded_period" | jq -r '.detailedForecast')
            temperature=$(echo "$decoded_period" | jq -r '.temperature')
            temperature_unit=$(echo "$decoded_period" | jq -r '.temperatureUnit')

            weather_period=(
                icon="$period_name - $temperature $temperature_unit"
                icon.color="$BLUE"
                label="$sentence"
                label.drawing=on
                click_script="sketchybar --set $NAME popup.drawing=off"
                drawing=on
            )

            item=weather.details."$COUNTER"
            sketchybar --add item "$item" popup.weather.temp
            sketchybar --set "$item" "${weather_period[@]}"

            SUBCOUNTER=0
            echo "$detailed_forecast" | grep -o -E '\b[^.!?]*[.!?]' | while read -r sentence; do

                SUBCOUNTER=$((SUBCOUNTER + 1))
                weather_period=(
                    label="$sentence"
                    label.drawing=on
                    click_script="sketchybar --set $NAME popup.drawing=off"
                    drawing=on
                )

                item=weather.details."$COUNTER"."$SUBCOUNTER"
                sketchybar --add item "$item" popup.weather.temp
                sketchybar --set "$item" "${weather_period[@]}"
            done

            sketchybar --add item weather.details.newline."$COUNTER" popup.weather.temp
        fi
    done
}

update() {
    url=$(forecast_url) || exit 0
    weather=$(weather_request "$url") || exit 0
    temp=$(echo "$weather" | jq -r '.properties.periods[0].temperature')
    forecast=$(echo "$weather" | jq -r '.properties.periods[0].shortForecast')
    time=$(echo "$weather" | jq -r '.properties.periods[0].isDaytime')
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
