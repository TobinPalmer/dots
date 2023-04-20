# nnn theme
### Attribute codes:
00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed
### Text color codes:
30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white 38=custom
### Background color codes:
40=black 41=red 42=green 43=yellow 44=blue 45=magenta 46=cyan 47=white 48=custom
### Color mode
02=RGB 05=16-bit

BLK="0B" CHR="0B" DIR="04" EXE="06" REG="00" HARDLINK="06" SYMLINK="06" MISSING="00" ORPHAN="09" FIFO="06" SOCK="0B" OTHER="06"

export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
export NNN_USE_EDITOR=1
export NNN_PLUG='f:fzf;o:fzopen;p:mocq;d:diffs;t:nmount;v:imgview'
export NNN_TMPFILE="/tmp/nnn"
export NNN_BMS="c:~/.config/;C:~/Documents/Code/;d:~/Downloads/;w:~/Documents/Code/Web/;T:~/Documents/Code/Web/Ts/"
export NNN_OPTS="H"
