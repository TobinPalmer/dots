batchRename() {
    \lsbrew install unpkg | nvim "+%s/.*/\=\"mv -i \".submatch(0).\" \".substitute(submatch(0), \"\", \"\", \"g\")/g"
}
