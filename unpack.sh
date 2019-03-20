#!/bin/bash

# script gives folder name and checks if the files in it 
# are archives (Gzip or Bzip). If so, script decompresses them,
# if not - just skip the file

# make sure about correct input
if [ $# -lt 1 ]
then
	echo "Usage: $0  path/to/folder ..."
	exit 1
fi

dir=$1
for file in "$dir"/*; do
        # get file's extention ('.'and anything till the end of filename)
        EXT=$(echo "$file" | grep -oE "\.[A-Za-z0-9\@\#\%\^\&\(\)\?\<\>\+\-\=\~\`\|\*\_\,\!\"\'\/\$]+$")
	echo ''
	echo "file $file, ext= $EXT"
    	case $EXT in
        	.gz) 
			tar xzvf $file
			echo "Gzip... unpacked.";;
		.tgz)
			tar xzvf $file
			echo "Gzip... unpacked.";;
		.tb2)
			tar xjvf $file
			echo "Bzip... unpacked.";;
		.bz2)
			tar xjvf $file
			echo "Bzip... unpacked.";;
		.tbz)
			tar xjvf $file
			echo "Bzip... unpacked.";;

		* ) echo "Not a Gzip/Bzip archive... Skipped.";;
	esac
               
done
