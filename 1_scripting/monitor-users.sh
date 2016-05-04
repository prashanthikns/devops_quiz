#!/bin/bash

declare -r DEF_CRIT=10
declare -r DEF_WARN=5

cnt=$(who | wc -l)

while getopts ":w:c:u:" optname
  do 
	case "$optname" in
	  "w")
		warning=$OPTARG
		;;
	  "c")
		critical=$OPTARG
		;;
	  "u")
		name=$OPTARG
	    ;;
	esac		
done

warning=${warning:=$DEF_WARN}
critical=${critical:=$DEF_CRIT}

if [ -n "$name" ]; then
	cnt=$(who -u | grep $name | cut -d' ' -f1 | wc -l)
fi

if [ $cnt -gt $warning ] ; then
	echo "WARNING reached: $cnt users"
	exit 1
fi
if [ $cnt -gt $critical ]; then
	echo " CRITICAL reached: $cnt users"
	exit 2
fi
echo " User Count OK:/ $cnt users"
exit 0
