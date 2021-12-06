#!/bin/sh
# Plays the first episode from a random series

regex='.*/[^/]*\([^0-9/S]0\{1,\}1\|E0\{1,\}1\)[^0-9/][^/]*\(mkv\|mp4\|avi\)'
ep="$(find . -type f -regex "$regex" | shuf | head -n1)"
mpv -- "$ep"
