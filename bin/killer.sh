#!/bin/sh

# Extremely hacky time-management script.
# Intended for people who lack the willpower to stop using a program
# after a time limit, but have enough to not press Ctrl-C while running this.
# In other words, designed for me.

# I run this on a cygwin environment, but it shouldn't be hard to adapt it
# to a real UNIX-like environment, using kill and notify-send or whatever.

# UPDATE: I (kinda hastily) ported this to Linux.

send_message() {
	if uname -o | grep -qi 'windows\|cygwin\|msys'
	then
		msg /W /time:180 "$USER" "$@"
	else
		notify-send -u critical "$(basename "$0")" "$@"
	fi
}

if [ "$#" -le 1 ]
then
	>&2 printf 'Usage: %s [%s] %s process_name.exe\n' \
		"$0" '-t' 'TIME'
	>&2 printf 'With the switch -t, TIME is a string parsable by sleep(1).\n'
	>&2 printf 'Without the switch, TIME is a string parsable by date(1).\n'
	>&2 printf '\nExamples:\n\t%s 20:00 firefox.exe\n' "$0"
	>&2 printf '\t%s "Tomorrow 00:30" firefox.exe\n' "$0"
	>&2 printf '\t%s -t 1h30m firefox.exe\n' "$0"
	exit 1
fi

if [ "$1" = '-t' ]
then
	usesleep=1
	shift
fi

tasktime="$1"
taskname="$2"
min_number=5
tl_fail_msg='No tasks are running which match the specified criteria.'

if [ "$usesleep" = 1 ]
then
	sleep "$tasktime"
else
	sleep "$(($(date -d "$tasktime" '+%s') - $(date '+%s')))"s
fi

send_message "$taskname will be stopped in $min_number minutes."

for i in $(seq 1 1 "$min_number")
do
	sleep 1m
	# if ( tasklist /fi "imagename eq $taskname" | grep -q "$tl_fail_msg" )
	pgrep "$taskname"
	if [ "$?" -ne 0 ]
	then
		echo "$taskname is not running."
		exit 0
	fi
done

# taskkill /im "$taskname"
kill -s SIGTERM "$taskname"
