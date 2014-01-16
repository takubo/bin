#!/bin/sh
# vim:set sw=2 :

cmd_name=`basename $0`; ichar=${cmd_name:0:1}; ochar=${cmd_name:2:1}

case ${ichar} in
  b) ibase=2 ;;
  o) ibase=8 ;;
  d) ibase=10 ;;
  h) ibase=16 ;;
  x) ibase=16 ;;
  *) echo "invalid ibase."; exit ;;
esac

case ${ochar} in
  b) obase=2 ;;
  o) obase=8 ;;
  d) obase=10 ;;
  h) obase=16 ;;
  x) obase=16 ;;
  *) echo "invalid obase."; exit ;;
esac

num=`echo $* | tr 'abcdef \t' 'ABCDEF;;' | tr -d _`

echo "obase=${obase}; ibase=${ibase}; ${num}" | bc | tr 'ABCDEF' 'abcdef'
