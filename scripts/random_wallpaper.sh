#!/bin/bash

bitmap_folder=~/repos/bitmap-walls/patterns

random_bitmap=$(ls $bitmap_folder/*.xbm | shuf -n 1)

xsetroot -bitmap "$random_bitmap" -fg "#665c54" -bg "#282828"
