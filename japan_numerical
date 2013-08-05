#!/usr/bin/awk -f

BEGIN {
    numeral[0]  = ""
    numeral[1]  = "万(まん)"
    numeral[2]  = "億(おく)"
    numeral[3]  = "兆(ちょう)"
    numeral[4]  = "京(けい、きょう)"
    numeral[5]  = "垓(がい)"
    numeral[6]  = "※(じょ, ※はノギヘンに予)"
    numeral[7]  = "穣(じょう)"
    numeral[8]  = "溝(こう)"
    numeral[9]  = "澗(かん)"
    numeral[10] = "正(せい)"
    numeral[11] = "載(さい)"
    numeral[12] = "極(ごく)"
    numeral[13] = "恒河沙(ごうがしゃ)"
    numeral[14] = "阿僧祇(あそうぎ)"
    numeral[15] = "那由他(なゆた)"
    numeral[16] = "不可思議(ふかしぎ)"
    numeral[17] = "無量大数(むりょうたいすう)"
}

#/^¥s*(-¥s*)?([0-9]+(( |,)?[0-9])?)+¥s*$/ {
/^( |¥t)*(-( |¥t)*)?([0-9]+(( |,)?[0-9])?)+( |¥t)*$/ {
	if (/-/) {
		minus = "-"
	} else {
		minus = ""
	}

	#gsub(/¥s|-|,/, "")
	gsub(/ |¥t|-|,/, "")

	ans = ""

	len = length($0)
	div = int(len / 4)
	mod = int(len % 4)

	if ( mod ) {
		ans = substr($0, 1, mod) numeral[div]
		$0 = substr($0, mod + 1, len)
	}

	for (i = div; i > 0; i--) {
		ans = ans substr($0, 1, 4) numeral[i - 1]
		$0 = substr($0, 5, len)
	}

	print minus ans
}
