#!/bin/bash
#echo "Hello World"
t=0 #disc number

for i in FFOST/*; do
	echo $i
	b=`ls -1 "$i"/| wc -l`
	t=$((t+1))
	echo "disc number $t"
	#echo $b
	track=0 #track number
	for file in "$i"/*; do
		#b=`ls -1 | wc -l`
		a=`echo $file | sed -e "s@FFOST\/Disc $t\/[0-9][0-9]@@"`
		c=`echo $file`
		track=$((track+1))
		eyeD3 --remove-all "$c"
		#echo $a
		#echo $b
		eyeD3 --to-v2.3 -A "Final Fantasy XIII OST" -t "$a" -n "$track" "$c"
	done
	
done 