#!/bin/sh

inic="$(printf "\n" | dmenu)"

rifle "$(locate -i "$inic" | dmenu -i -l 5 -p "${inic}")"
