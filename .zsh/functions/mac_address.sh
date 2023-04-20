generate_mac_address () {
    sudo /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport en0 -z
    ADDRESS=$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//')
    echo "Changing Mac Address to $ADDRESS"
    sudo ifconfig en0 ether "$ADDRESS"
}
