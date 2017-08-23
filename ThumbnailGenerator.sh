#!/bin/bash
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

basefolder="/home/marcelo/photo/"

for i in $(find * -iname '*.jpg');
do

        if [ `dirname $i` != "." ]
        then
                dirpath="${i%/*}"
                dir_arr=(`echo $dirpath | tr "/" "\n"`)
                path=""
                for x in "${dir_arr[@]}"
                do
                        if [ -z "$path" ]
                        then
                                path=$x
                                mkdir -p $basefolder$path
                        else
                                path=$path"/"$x
                                mkdir -p $basefolder$path
                        fi
                done
                ext="."${i##*.}
                output=${i/$ext/}
                if [ ! -f $basefolder$output ] || [ $i -nt $basefolder$output ]
                then
                        echo $i
                        convert $i -auto-orient -resize 145x145 -quality 90 $basefolder${output}_thumbnail.jpg
                        convert $i -auto-orient -resize 480x360 -quality 90 $basefolder${output}_normal.jpg
                fi



        else
                ext="."${i##*.}
                output=${i/$ext/}
                if [ ! -f $basefolder$output ] || [ $i -nt $basefolder$output ]
                then
                        echo $i
                        convert $i -auto-orient -resize 145x145 -quality 90 $basefolder${output}_thumbnail.jpg
                        convert $i -auto-orient -resize 480x360 -quality 90 $basefolder${output}_normal.jpg
                fi

        fi
done


