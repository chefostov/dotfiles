#!/bin/bash

# Проверяваме дали picom е стартиран
if pgrep -x "picom" > /dev/null
then
    echo "Picom вече работи. Спирам го..."
    pkill picom
else
    echo "Picom не е стартиран. Стартирам го..."
    picom --experimental-backends --backend glx --daemon &
fi
