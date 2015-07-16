SWAPINFO="/usr/sbin/swapinfo"
PS="/usr/bin/ps"
AWK="/usr/bin/awk"
GREP="/usr/bin/grep"
SORT="/usr/bin/sort"
TAIL="/usr/bin/tail"


MYPAT="$1"
Availability=0
export UNIX95=1
VAR=$($SWAPINFO -ta | $GREP memory | $AWK ' { print $2 } ')
MYCPU=` $PS -efo pcpu,vsz,args | $GREP -v COMMAND | $GREP -v awk | $GREP "$MYPAT" | $SORT -k 1 | $TAIL -1 | $AWK -v var=$VAR -v pattern="$MYPAT" ' { print $1 } '`
echo $MYCPU
