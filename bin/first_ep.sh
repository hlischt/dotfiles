#!/bin/sh
# Plays the first episode from a random series

ep="$(find . -type f -regex '.*/[^/]*\([^0-9/S]0+1\|E0+1\)[^0-9/][^/]*\(mkv\|mp4\|avi\)' | shuf | head -n1)"
mpv -- "$ep"
