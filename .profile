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
XDG_CONFIG_HOME="${HOME}/.config"
XDG_CACHE_HOME="${HOME}/.cache"
XDG_DATA_HOME="${HOME}/.local/share"
XDG_STATE_HOME="${HOME}/.local/state"
export XDG_CONFIG_HOME
export XDG_CACHE_HOME
export XDG_DATA_HOME
export XDG_STATE_HOME

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
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]
then
	# exec on a login shell fails if startx doesn't exist, logging you out
	command -v startx > /dev/null && exec startx
fi
