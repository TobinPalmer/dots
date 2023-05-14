source "/Users/tobin/.config/skhd/scripts/yabai/util.sh"

# yabai -m space --create && \
#                    index="$(yabai -m query --spaces --display | jq 'map(select(."is-native-fullscreen" == false))[-1].index')" && \
#                    yabai -m window --space "${index}" && \
#                    yabai -m space --focus "${index}"
yabai -m space --create &&
yabai -m window --space last &&
yabai -m space --focus last

# wallpaper set ~/.config/wallpapers/Arch.jpg
sh ~/.config/yabai/create_spaces.sh
