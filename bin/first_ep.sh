#!/bin/sh
# Plays the first episode from a random series
# Busybox's find worked well without the regextype flag
# Guess it's a GNU quirk

regex='.*/[^/]*\([^0-9/S]0\{1,\}1\|E0\{1,\}1\)[^0-9/][^/]*\(mkv\|mp4\|avi\)'
ep="$(find "$1" -type f -regextype grep -regex "$regex" | shuf | head -n1)"
mpv -- "$ep"
