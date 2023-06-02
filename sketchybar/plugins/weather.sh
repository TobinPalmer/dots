#!/usr/bin/env bash

source "$HOME/.config/color/colors.sh"

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
        *"Snow"* | *"Heavy Snow"* | *"Snow Showers"*)
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
        *"Drizzle"* | *"Mostly Sunny"*)
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
        label="$forecast $popup_weather"
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
    # Bar
    url=$(jq -r '.weathergov | "\(.url)\(.location)/\(.format)"' ~/.config/sketchybar/plugins/weather_config.json)
    weather=$(curl -s "$url")
    temp=$(echo "$weather" | jq -r '.properties.periods[0].temperature')
    forecast=$(echo "$weather" | jq -r '.properties.periods[0].shortForecast')
    time=$(echo "$weather" | jq -r '.properties.periods[0].isDaytime')
    icon=$(weather_icon_map "$time" "$forecast")

    # popup
    url=$(jq -r '.wttr | "\(.url)\(.location)?\(.format)"' ~/.config/sketchybar/plugins/weather_config.json)
    popup_weather=$(curl -s "$url" | sed 's/  */ /g')

    render_bar
    render_popup

    if [ "$COUNT" -ne "$PREV_COUNT" ] 2>/dev/null || [ "$SENDER" = "forced" ]; then
        sketchybar --animate tanh 15 --set "$NAME" label.y_offset=5 label.y_offset=0
    fi
}

popup() {
    sketchybar --set "$NAME" popup.drawing="$1"
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
