#! /bin/sh
#a simple script used to count the lines of .h .c .cc .cpp files in 
#the specified path
#
#./count_lines -d [directory]  deirectory 
PATTERN=    
DIRECTORY=   
PROGRAM=`basename $0`
FILELIST=
TMP_FILE=/tmp/count_lines.$$..tmp
usage()
{
    cat <<EOF
Usage:
       $PROGRAM [ --directory "..." ]
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

count_lines()
{
    cat $1 | wc -l 1>> $TMP_FILE
	#| awk  '{ N += $1 } END { print N }'
	#sed -n '/ auth(const struct/p' $1
}



echo "Lines account program is runing:"

while [ $# -gt 0 ]
do
	case $1 in
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


echo "Now, i get the directory: $DIRECTORY"
echo "Now, i get the file list which will be counted"
FILE_LIST=`find  $DIRECTORY`
echo "we have already get the file list, but we only need the .c .cc .cpp and .h files"
echo
echo "i'm going to get .c .cc .cpp .h"

for file in $FILE_LIST
do
		if test -d $file
		then
		    continue
	    else
			#echo $file | sed -n '/*.\.(cpp|h)$/p' 
			#echo $file | awk '/*.\.(c|cc|cpp|h)$/{print}' >&1
			echo $file | grep -E '*.\.(c|cc|cpp|h)$' > /dev/null
			if test $? == 0
			then
                FILE_LIST_CH="$FILE_LIST_CH $file"
		    fi
		fi
done

echo
echo "i have get the files, begin to count"

for filename in $FILE_LIST_CH
do
		if test -f $filename
		then
			count_lines $filename
		fi 
done

echo
echo "OK, the total lines is"
awk '{ N += $1 } END { print N }' $TMP_FILE

rm -f $TMP_FILE
echo
echo "Lines account program exit, see u!:-)"
