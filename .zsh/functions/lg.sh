lg() {
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
        cd "$(cat $LAZYGIT_NEW_DIR_FILE)" || exit
        rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}
