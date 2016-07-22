#!/bin/sh
# vim:set sw=8 :

usage_exit()
{
	echo "usage:" `basename $0` "[-f file] args ..." > /dev/stderr
	exit 1
}

FROM_FILE=""

while getopts f:hs OPT; do
	case ${OPT} in
		f)  FROM_FILE="${OPTARG}"
			;;
		h)  usage_exit
			;;
		s)  FROM_FILE="/dev/stdin"
			;;
		\?) usage_exit
			;;
	esac
done

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

if [ "${FROM_FILE}" = "" ] ; then
	num=`echo $* | tr 'abcdef \t' 'ABCDEF;;' | tr -d _`

	echo "obase=${obase}; ibase=${ibase}; ${num}" | bc | tr 'ABCDEF' 'abcdef'
	# echo "obase=${obase}; ibase=${ibase}; ${num}" | bc 
else
	cat "${FROM_FILE}" |
	while read LINE ; do
		num=`echo ${LINE} | tr 'abcdef \t' 'ABCDEF;;' | tr -d _`

		echo "obase=${obase}; ibase=${ibase}; ${num}" | bc | tr 'ABCDEF' 'abcdef'
	done
fi

# TODO
#
# 桁指定
#	zero extension or signed extension
#
# ビット番号表示
#
#
# ビットフィールドを解析可能に
# Pack Unpack
#
# エンディアン逆転
#
# 大文字小文字の指定	16進
#
