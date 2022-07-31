#!/bin/bash
#branch development

TMP_FILE=`mktemp`

#AS block list
list_as='as_fck.src'

echo "aut-num;org;org-name;descr"
echo "================="

while read as_obj
do

	whois "$as_obj"  > "$TMP_FILE"
	descr=`cat "$TMP_FILE" | grep -A 5 'aut-num'|  awk -F ':' '{ if ($1 == "descr") {print $2} }' | head -n 1 | sed 's/^ *//g'`
	org_name=`cat "$TMP_FILE" | grep 'org-name' | awk -F ':' '{print $2}' | sed 's/^ *//g' `
	org=`cat "$TMP_FILE" | awk -F ':' '{ if ($1 == "org") {print $2} }' | sed 's/^ *//g'`

	echo "$as_obj;$org;$org_name;$descr"
	echo  "======END========"

done < $list_as
