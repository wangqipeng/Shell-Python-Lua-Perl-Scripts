#! /bin/sh
#delete the lines in the file that have the same numbers
#
#./delete_the_same_numbers_line.sh  files

IFS='     
		'

for f in "$@"
do
    cat $f | 
	    awk -F"\t" '{
            count[$1]++
		    if (count[$1] == 1) print $0
			if (count[$1] > 1) print $1 ": "  count[$1] > "tmp.txt"
			}' 
done
