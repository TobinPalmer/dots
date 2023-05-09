SPACE_INDEX=$(yabai -m query --spaces | jq '.[] | select(."has-focus"==true).index')
DISPLAY_NUMBER=$(yabai -m query --spaces | jq '.[] | select(."has-focus"==true).display')
DISPLAY_INDEX_RANGE=$(yabai -m query --spaces | jq '.[] | select(."display"==1).index')
DISPLAY_FIRST_NUMBER=$(printf %.1s "$DISPLAY_INDEX_RANGE")
DISPLAY_LAST_NUMBER=$(echo ${DISPLAY_INDEX_RANGE:0-1})

if [[ $SPACE_INDEX -eq $DISPLAY_LAST_NUMBER ]]; then
  RIGHT_SPACE_INDEX=$DISPLAY_FIRST_NUMBER
else
  RIGHT_SPACE_INDEX=$(($SPACE_INDEX + 1))
fi

LOWEST_DISPLAYED_SPACE_INDEX=$(yabai -m query --spaces | jq '.[] | select(."visible"==1).index' | sort -n | head -n 1)

yabai -m space --move $RIGHT_SPACE_INDEX

sh ~/.config/yabai/create_spaces.sh


