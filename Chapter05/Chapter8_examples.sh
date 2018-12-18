#!/bin/bash

seq -- $(seq 1 1 5)

[ 0 = 1 ] && echo “a” || ([0==2] && echo b || echo c)
[ -f /myconfig ] && read_params /myconfig


testcase() {
for VAR; do
case “${VAR}” in
	‘’) echo “empty”;;
	a) echo “a”;;
	b) echo “b”;;
	c) echo “c”;;
	*) echo “not a, b, c”;;
esac
done
}
testcase ‘’ foo a bar b c d


ls /
ls / >/dev/null
ls /foobar 2>/dev/null
ls / /foobar >stdout_and_stderr.log 2>&1
ls / /foobar >stdout.log 2>stderr.log
ls / /foobar 2>&1 >/dev/null

cat <stdout.log | grep lines

grep keyword > keys.log


cat <<EOF >options.conf
option=true
option2=false
option3=cat
EOF


