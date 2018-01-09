#!/bin/env bash
#
# Copyright (C) 2018 All Rights Reserved.
#
# Author:          Houmin Wei  <houmin.wei@outlook.com>
# Created:         Tue 09 Jan 2018 09:55:21 AM CST
# Last Modified:   Tue 09 Jan 2018 10:21:54 AM CST

# Images are taken from the "hell so easy to use (basic) API" of Unsplash, they are totally free for all use.
# The downloaded images are kept in ~/.local/share/unsplashLinux if the following switch is false.
DO_WE_ERASE_FILES=false

WORKDIR=$HOME'/.local/share/unsplashLinux/'
RANT=$(date +%s)
mkdir -p $WORKDIR
mkdir -p $WORKDIR'old'

wget -q --spider http://google.com
if [ $? -eq 0 ]; then
	echo internetIsUp
else
	exit 1
fi

if $DO_WE_ERASE_FILES
then
	rm $WORKDIR*'.jpg'
else
	mv $WORKDIR*'.jpg' $WORKDIR'old/'
fi
wget -O ${WORKDIR}${RANT}'.jpg' -q https://source.unsplash.com/1600x900/?nature
gsettings set org.gnome.desktop.background picture-uri 'file://'${WORKDIR}${RANT}'.jpg'
