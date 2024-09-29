#!/bin/bash

# Take a screenshot of a selected window or the entire screen and save it to the ~/pic/screenshots directory
# The screenshot is saved in the PNG format with the current date and time + window title as the filename
# The script uses the scrot utility to take the screenshot
# The script also uses the xdotool utility to get the window title

# Directory to save the screenshots
screenshot_dir=~/pic/screenshots

# Create the directory if it doesn't exist
mkdir -p "$screenshot_dir"

# Get the current date and time
current_date=$(date +"%Y-%m-%d_%H-%M-%S")

# Function to take a screenshot of a selected window
screenshot_window() {
    # Select a window using xdotool
    window_id=$(xdotool selectwindow)

    # Get the window title using xdotool
    window_title=$(xdotool getwindowname "$window_id")

    # Replace any special characters in the window title with underscores
    window_title=$(echo "$window_title" | sed 's/[^a-zA-Z0-9]/_/g')

    # Wait for the specified number of seconds if provided
    if [ -n "$1" ]; then
        sleep "$1"
    fi

    # Take the screenshot of the selected window using scrot
    scrot -u -b "$screenshot_dir/${current_date}_window_${window_title}.png"

    # Notify the user that the screenshot has been saved successfully using bash printf
    printf "Screenshot saved to: %s\n" "$screenshot_dir/${current_date}_window_${window_title}.png"
}

# Function to take a screenshot of the entire screen
screenshot_fullscreen() {
    # Wait for the specified number of seconds if provided
    if [ -n "$1" ]; then
        sleep "$1"
    fi

    # Take the screenshot of the entire screen using scrot
    scrot "$screenshot_dir/${current_date}_fullscreen.png"

    # Notify the user that the screenshot has been saved successfully using bash printf
    printf "Screenshot saved to: %s\n" "$screenshot_dir/${current_date}_fullscreen.png"
}

# Check the arguments
case $# in
    0)
        # No arguments, take a screenshot of a selected window
        screenshot_window
        ;;
    1)
        if [[ $1 =~ ^[0-9]+$ ]]; then
            # Argument is a number, take a screenshot of a selected window and wait for the specified seconds
            screenshot_window "$1"
        elif [ "$1" == "d" ]; then
            # Argument is "d", take a screenshot of the entire screen
            screenshot_fullscreen
        else
            echo "Invalid argument"
            echo "Usage: $0 [delay] [d]"
            exit 1
        fi
        ;;
    2)
        if [[ $1 =~ ^[0-9]+$ ]] && [ "$2" == "d" ]; then
            # Arguments are a number and "d", wait for the specified seconds and take a screenshot of the entire screen
            screenshot_fullscreen "$1"
        else
            echo "Invalid arguments"
            echo "Usage: $0 [delay] [d]"
            exit 1
        fi
        ;;
    *)
        echo "Invalid number of arguments"
        echo "Usage: $0 [delay] [d]"
        exit 1
        ;;
esac
