#!/bin/bash

# Shows the last played song in cmus

# Check if cmus is running
if ! pgrep -x "cmus" > /dev/null
then
    echo "cmus is not running"
    exit 1
fi

# Get the last played song
last_song=$(cmus-remote -Q 2>/dev/null | grep "tag title" | tail -n 5 | cut -d " " -f 3-)

# Check if the last song is empty
if [ -z "$last_song" ]
then
    echo "No song is currently playing"
else
    echo "Last played song: $last_song"
fi

exit 0
