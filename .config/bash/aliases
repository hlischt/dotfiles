alias cls='printf "\033c"'
alias youtube-dl='yt-dlp'
alias ytdl='yt-dlp'
alias lls='ls -GAhlg'
alias ffmpeg='ffmpeg -hide_banner'
alias vi='emacsclient -c -a emacs'
alias feh='feh -. -g 1600x900 -S mtime --start-at'
alias cal='ncal -bM'
alias rsync='rsync -avxlhhP --no-o --no-g --progress'
alias denofmt='deno fmt --ext js --options-single-quote --options-line-width 100 --options-use-tabs'

godocs() {
	for i in "$@"
	do
		go doc "$i"
	done | less
}

lt() {
	if { printf '%s' "$*" | grep -q '[][\?^$|]' ; }
	then
		locate -i --regex "$@"
	else
		locate -i "$@"
	fi
}
