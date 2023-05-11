export LOWEST_DISPLAYED_SPACE_INDEX=$(yabai -m query --spaces | jq '.[] | select(."visible"==1).index' | sort -n | head -n 1)
export CURRENT_SPACE_INDEX=$(yabai -m query --spaces | jq '.[] | select(."has-focus"==true).index')
export CURRENT_DISPLAY_NUMBER=$(yabai -m query --spaces | jq '.[] | select(."has-focus"==true).display')
export DISPLAY_INDEX_RANGE=$(yabai -m query --spaces | jq '.[] | select(."display"==1).index')
export DISPLAY_FIRST_NUMBER=$(printf %.1s "$DISPLAY_INDEX_RANGE")
export DISPLAY_LAST_NUMBER=$(echo "${DISPLAY_INDEX_RANGE:0-1}")

