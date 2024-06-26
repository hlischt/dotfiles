#!/bin/sh
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# set the XDG Base Directory Specification variables
# and create the directories if they don't exist
XDG_CONFIG_HOME="${HOME}/.config"
XDG_CACHE_HOME="${HOME}/.cache"
XDG_DATA_HOME="${HOME}/.local/share"
XDG_STATE_HOME="${HOME}/.local/state"
export XDG_CONFIG_HOME
export XDG_CACHE_HOME
export XDG_DATA_HOME
export XDG_STATE_HOME
mkdir -p "$XDG_CONFIG_HOME" "$XDG_CACHE_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME"

# Set xinitrc inside $XDG_CONFIG_HOME
XINITRC="${XDG_CONFIG_HOME}/xinit/xinitrc"
export XINITRC

# History and misc. files
LESSHISTFILE="$XDG_STATE_HOME/lesshst"
LESSHISTSIZE=1000
export LESSHISTFILE
export LESSHISTSIZE
SQLITE_HISTORY="$XDG_STATE_HOME/sqlite_history"
export SQLITE_HISTORY
INPUTRC="$XDG_CONFIG_HOME/inputrc"
export INPUTRC

# Set Java's directory to Debian's default symlinked directory
JAVA_HOME='/usr/lib/jvm/default-java'
export JAVA_HOME

# Set Go's directory in ~/.local/share
GOPATH="${XDG_DATA_HOME}/go"
GOBIN="${GOPATH}/bin"
export GOPATH
export GOBIN

# Set .NET's directory and opt-out from telemetry
DOTNET_ROOT="${XDG_DATA_HOME}/dotnet"
DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_ROOT
export DOTNET_CLI_TELEMETRY_OPTOUT

# Python startup file, moves .python_history to XDG_STATE_HOME
PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"
export PYTHONSTARTUP

# Rustup and Cargo directories in ~/.local/share
CARGO_HOME="${XDG_DATA_HOME}/cargo"
RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export CARGO_HOME
export RUSTUP_HOME

# pkg-config path to .pc files, for linking C programs
if [ "$(uname -s)" = "Linux" ] ; then
	PKG_CONFIG_PATH="/usr/lib/$(uname -m)-linux-gnu/pkgconfig:${PKG_CONFIG_PATH}"
fi
PKG_CONFIG_PATH="${HOME}/.local/lib/pkgconfig:${PKG_CONFIG_PATH}"
export PKG_CONFIG_PATH

# if running bash
if [ -n "$BASH_VERSION" ]; then
	BASHCONFIGDIR="${XDG_CONFIG_HOME}/bash"
	export BASHCONFIGDIR
	# include .bashrc if it exists
	if [ -f "$BASHCONFIGDIR/bashrc" ]; then
		. "$BASHCONFIGDIR/bashrc"
	fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
	PATH="${HOME}/.local/bin:${PATH}"
fi

if [ -d "${DOTNET_ROOT}" ]; then
	PATH="${DOTNET_ROOT}:${DOTNET_ROOT}/tools:${PATH}"
fi

if [ -d "${GOBIN}" ]; then
	PATH="${GOBIN}:${PATH}"
fi

if [ -d "$HOME/bin" ] ; then
	PATH="$HOME/bin:${PATH}"
fi

# Automatic startx when logged to TTY 1
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]
then
	# exec on a login shell fails if startx doesn't exist, logging you out
	command -v startx > /dev/null && exec startx
fi
