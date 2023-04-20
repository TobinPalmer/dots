tere() {
    local result=$(command tere "$@")
    [ -n "$result" ] && cd -- "$result"
}

ask() { python3 /Users/tobin/Documents/Code/Python/chatgpt-wrapper/main.py "$1" }
TA() { find "$1" -type d -exec SetFile -d "`date +%m/%d/%Y\ %H:%M:%S`" {} + }
currGrep() { grep -r --exclude-dir='node_modules' --exclude-dir='.git' --exclude-dir='dist'  "$1" . }
term() { open -a Terminal "$1" }
warp() { open -a "warp" "$1" }
FC() { cd ~/Documents/Code/"$1" }
