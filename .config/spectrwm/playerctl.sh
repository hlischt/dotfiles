#!/bin/sh
player=spotify,audacious

pctl() {
	pstatus="$(playerctl -p "$player" -s status)"
	if [ "$?" -eq 0 ]
	then
		case "$pstatus" in
			Playing)
				playerctl -p "$player" metadata \
					  --format '♪ {{artist}} - {{title}}  |'
				;;
			Paused) playerctl -p "$player" metadata \
					  --format '⏸ {{artist}} - {{title}}  |'
				;;
		esac
	fi
}

mem_usage() {
	free | awk '/^Mem/ {
		gb = 1000000.0;
		gib = 1024.0 * 1024.0;
		printf("%.2fGiB (%.f%%)\n", $3/gib, 100 * $3/$2);
	}'
}

while :; do
	printf -- '%s  %s\n' "$(pctl)" "$(mem_usage)"
	sleep 5s
done
