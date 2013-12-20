#!/bin/bash -
#title					:watcher.sh
#description		:This script will watch a dir and touch files to trigger inotify.
#author					:Evan Frohlich
#date						:20131026
#version				:0.1
#usage					:bash watcher.sh
#notes					:Not for production usage.
#bash_version		:4.2
#==============================================================================

# dir to watch
DIR_PATH='/vagrant'


while [ 1 -eq 1 ]
do
	#Get list of files changed since last the script ran
	for MY_FILE in `find $DIR_PATH -type f -newer $DIR_PATH/scripts/lastupdate.txt`
	do
		touch $MY_FILE
	done

	if [ $(find $DIR_PATH -type f -newer $DIR_PATH/scripts/lastupdate.txt | wc -l) -gt 0 ]
	then
		touch $DIR_PATH/scripts/lastupdate.txt
	fi
	sleep 1
done
