#!/bin/bash

# Check if Firefox is running
if ! ps aux | grep "firefox" > /dev/null; then
    echo "Firefox is not running. Starting Firefox..."
    nohup env DISPLAY=:0 /usr/bin/firefox > /dev/null 2>&1 &
    sleep 2  # Give Firefox time to start up
fi

# Open a new tab in Firefox
export DISPLAY=:0
/usr/bin/firefox --new-tab "$@" --raise-window > /dev/null 2>&1 &
