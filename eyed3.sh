#!/bin/bash

#remove hyphens
for i in MUSICFOLDER/*; do
	echo $i
	for file in "$i"/*; do
		a=`echo $file | sed -e 's/-/ /g'` #substitute all hyphens with a space, globally		
		mv "$file" "$a"
	done
done 

#upper case
for i in MUSICFOLDER/*; do
	echo $i
	for file in "$i"/*; do
		b=`echo $file | sed -r 's/\<./\U&/g'` #replace the first letter with an uppercase of each word
		mv "$file" "$b"
	done
done 

t=0 #disc number

#fill in ID3 tags
#-A = album
#-t = track name
#-n = track number
for i in MUSICFOLDER/*; do
	#echo $i #meant to show the disc number
	c=`ls -1 "$i"/| wc -l` #b is equal to the word count of the list of music files inside each disc folder
	t=$((t+1)) #Increment disc number
	track=0 #track number
	for file in "$i"/*; do
		a=`echo $file | sed -e "s@MUSICFOLDER\/Disc $t\/[0-9][0-9]@@"`  #substitute the file path "MUSICFOLDER/Disc $t/[0-9][0-9]" with empty space
		d=`echo $file` #keep original path to file
		track=$((track+1))
		
		eyeD3 --remove-all "$d" #remove all information in the current song
		
		#replace information with variables from above where "Album Name" is set by user, -t is the title, -n is the track number, d is the file path
		eyeD3 --to-v2.3 -A "Album Name" -t "$a" -n "$track" "$d"
	done
	
done 