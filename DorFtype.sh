#!/bin/bash
echo -n "please input absolute path about directory or file:" ; read path

if [ -e $path ]
then echo "$path is exist"
else echo "$path is not exist";exit
fi
if [ -d $path ]
then echo "$path is directory"
else echo "$path is file"
fi

