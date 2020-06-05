#!/usr/bin/env bash
################################################################################
# *** auto-generated by (github.com/FrankyMartz/dotfiles) ***
# Shell Alias
#
# Author:   Franky Martinez <frankymartz@gmail.com>
################################################################################

#===============================================================================
# ALIASES
#===============================================================================

# alias less='less --RAW-CONTROL-CHARS';
function __GET_LESS_THEME () {
    local _ITERM_PROFILE_LIGHT="Light";
    if [[ "$ITERM_PROFILE" == "$_ITERM_PROFILE_LIGHT" ]]; then
        echo "solarized-light";
    else
        echo "solarized-dark";
    fi
}
LESSOPEN="| $(command -v highlight) %s --out-format xterm256 --line-numbers --quiet --force --style $(__GET_LESS_THEME)";
export LESSOPEN
# export LESS=" -R";
alias less='less -m -N -g -i -J --line-numbers --underline-special';
alias more='less';

alias g='git';

# Use "highlight" in place of "cat"
alias cat="$(command -v highlight) $1 --out-format xterm256 --line-numbers --quiet --force --style $(__GET_LESS_THEME)";

alias la='ls -lAFh --color --group-directories-first'; # color-mode
alias lad='ls -dlAh --color */'; # color-mode
alias irc='screen -t 1 irssi';

alias chrome='open -a Google\ Chrome'; 
alias chrome-canary='open -a Google\ Chrome\ Canary'; 
alias chrome-cors="open -a Google\ Chrome --args --disable-web-security --user-data-dir";
alias chrome-vscode="open -a Google\ Chrome --remote-debugging-port=9222"

alias nvdiff='nvim -d';
alias pe='path-extractor';
alias PP='git st | pe | fzf -m | xargs git add && clear && printf "\e[3J" && git st';
# alias pass-keygen="openssl rand -base64";
function genpw () {
    local LENGTH=25
    if [ -n "$1" ] && [ "$1" -gt 1 ]; then
        LENGTH=$1
    fi
    local NUMBYTES
    NUMBYTES=$(echo "$LENGTH" | awk '{print int($1*1.16)+1}')
    openssl rand -base64 "$NUMBYTES" | tr -d "=+/" | cut -c 1-"$LENGTH"
}

#===============================================================================
# Bind
#===============================================================================
# bind '"CC": "| pe | fzf | pbcopy && clear &&  pbpaste || xargs echo"'
