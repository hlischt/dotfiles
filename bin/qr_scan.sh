#!/bin/sh
#
# Scan QR codes by selecting a part of the screen
# and copying the result to the clipboard.

err() {
	>&2 printf "${@}"
}

prereqs() {
	for i in "${@}"
	do
		if ! command -v "${i}" > /dev/null
		then
			err 'Command not found: %s\nPlease install %s for this script to work\n' \
			    "${i}" "${i}"
			exit 1
		fi
	done
}



main() {
	prereqs zbarimg import xclip notify-send
	if text="$(import png:- | zbarimg -q -)"
	then
		notify-send -u low 'Scanned QR code successfully' "${text}"
		printf '%s' "$text" | xclip -i -selection clipboard
	else
		notify-send -u low 'Failed to scan QR code'
	fi
}

main
