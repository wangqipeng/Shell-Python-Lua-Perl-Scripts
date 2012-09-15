#! /bin/sh

cat $1 |sort -t" " -k1,1 |

awk -F" " ' BEGIN {k = 1}
            {  
	        for(j = 1; j < 5; j++ k++)
                {
		       if($j != '\t')
                           array[k] = $j
 		       else 
		           array[k] = ":"
		}
		   
		for(i = k - 4; i <= k ; i++)
                {			   
			   if( array[i] == ":"){
			       array[i] = array[i - 4]		   
			   }
	        }
	        print array[k-4]" " array[k-3]" " array[k-2]" " array[k-1]
            }
'
