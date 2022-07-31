#!/bin/bash
#branch development

TMP_FILE=`mktemp`

list_as='as_fck.src'

echo "aut-num;org;descr"
echo "================="

while read as_obj
do

	whois "$as_obj"  > "$TMP_FILE"
	descr=`cat "$TMP_FILE" | grep -A 5 'aut-num'|  awk -F ':' '{ if ($1 == "descr") {print $2} }' | head -n 1 | sed 's/^ *//g'`
	org=`cat "$TMP_FILE" | awk -F ':' '{ if ($1 == "org") {print $2} }' | sed 's/^ *//g'`

	echo "$as_obj;$org;$descr"

done < $list_as
