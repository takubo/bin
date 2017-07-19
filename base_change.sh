#!/bin/sh
# vim:set sw=8 :

LOWER_UPPER='abcdef'

while getopts 'f:cChlLsuUz:' OPT; do
	case ${OPT} in
		[cC] ) C_STYLE=1 ;;
		f )    FROM_FILE="${OPTARG}" ;;
		h )    usage_exit ;;
		s )    FROM_FILE="/dev/stdin" ;;
		[lu] ) LOWER_UPPER='abcdef' ;;
		[LU] ) LOWER_UPPER='ABCDEF' ;;
		z )    DIGIT="${OPTARG}" ;;	# zero extension
		? )    usage_exit ;;
	esac
done
shift $(( $OPTIND - 1 ))

cmd_name=`basename $0`; ichar=${cmd_name:0:1}; ochar=${cmd_name:2:1}

case ${ichar} in
	b)   ibase=2 ;;
	o)   ibase=8 ;;
	d)   ibase=10 ;;
	h|x) ibase=16 ;;
	*)   echo "invalid input-base."; exit ;;
esac

case ${ochar} in
	b)   obase=2 ; if [ "$C_STYLE" ]; then C_STYLE="0b"; fi ;;
	o)   obase=8 ; if [ "$C_STYLE" ]; then C_STYLE="0";  fi ;;
	d)   obase=10 ;;
	h|x) obase=16; if [ "$C_STYLE" ]; then C_STYLE="0x"; fi ;;
	*)   echo "invalid output-base."; exit ;;
esac

if [ "${FROM_FILE}" = "" ] ; then
	num=`echo $* | tr 'abcdef \t' 'ABCDEF;;' | tr -d _`
	echo "obase=${obase}; ibase=${ibase}; ${num}" | bc | tr 'ABCDEF' ${LOWER_UPPER} | xargs -i printf "%${DIGIT}s\n" {} | sed 's/ /0/g; s/^/'"${C_STYLE}"'/'
else
	cat "${FROM_FILE}" |
	while read LINE ; do
		num=`echo ${LINE} | tr 'abcdef \t' 'ABCDEF;;' | tr -d _`
		echo "obase=${obase}; ibase=${ibase}; ${num}" | bc | tr 'ABCDEF' ${LOWER_UPPER} | xargs -i printf "%${DIGIT}s\n" {} | sed 's/ /0/g; s/^/'"${C_STYLE}"'/'
	done
fi

# TODO
#
# 桁指定
#	zero extension or signed extension
#
# ビット番号表示
#

usage_exit()
{
	echo "usage:" `basename $0` "[-f file] args ..." > /dev/stderr
	exit 1
}
