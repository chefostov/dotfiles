#!/bin/bash

# Declare an associative array to save the layouts
declare -A layouts

# Variable to keep track of the previous window
prev_window=""
prev_layout=""

while true; do
  # Get the currently active window
  WIN_ID=$(xdotool getwindowfocus 2>/dev/null)

  if [ -n "$WIN_ID" ]; then
    # If the active window is different from the previous one
    if [ "$WIN_ID" != "$prev_window" ]; then
      # Save the current layout for the previous window
      if [ -n "$prev_window" ]; then
        CURRENT_LAYOUT=$(setxkbmap -query | grep layout | awk '{print $2}')
        layouts["$prev_window"]=$CURRENT_LAYOUT
      fi

      # Restore the saved layout for the current window
      if [ -n "${layouts[$WIN_ID]}" ]; then
        if [ "$prev_layout" != "${layouts[$WIN_ID]}" ]; then
          setxkbmap ${layouts[$WIN_ID]}
          prev_layout=${layouts[$WIN_ID]}
        fi
      else
        # If no saved layout, set to default (e.g., US)
        if [ "$prev_layout" != "us" ]; then
          setxkbmap us
          prev_layout="us"
        fi
      fi

      # Update the previous window
      prev_window=$WIN_ID
    fi
  fi

  # Check the active window every second
  sleep 1
done
