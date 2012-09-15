#!/bin/sh
#
PATTERN=    
DIRECTORY=   
PROGRAM=`basename $0`
FILELIST=

usage()
{
    cat <<EOF
Usage:
       $PROGRAM [ --pattern "..." ] [ --directory "..." ]
		       [ --help ]
EOF
}

error()
{
    echo "$@" 1>&2
    usage_and_exit 1	
}

usage_and_exit()
{
    usage
	exit $1
}

search_pattern()
{
    cat $1 | grep -E "$PATTERN"
}

while [ $# -gt 0 ]
do
	case $1 in
		-p | --p |-pa | --pa | -pat | --pat)    
		       shift
		       PATTERN="$1"
		       ;;
		-d | --d | -di | --di | -dir | --dir)    
		       shift
		       DIRECTORY="$1"
               ;;
	    -h | --h | -he | --he | -hel | --hel | -help | --help)
		       usage_and_exit 0
			   ;;
		--)    shift
		       break
			   ;;
		-*)    error $0: $1: unrecognized option >&2
		       ;;
		 *)    
		       break
		       ;;
		 esac
		 shift
done

FILELIST=`find . $DIRECTORY`

for filename in $FILELIST
do
		if test -f $filename
		then
			search_pattern $filename
			if test 0 = $?
			then
			    echo $filename
			fi
		fi
done
