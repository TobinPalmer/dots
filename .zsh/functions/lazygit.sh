lazygit() {
    git add .
    git commit -a -S -m "$1"
    git push
}
