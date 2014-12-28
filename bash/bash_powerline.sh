#!/usr/bin/env bash
################################################################################
# riobard/bash-powerline
# Powerline-style Bash prompt in pure Bash script
#
# Author:   Riobard Zhan <me@riobard.com>
# Modified:   Franky Martinez <frankymartz@gmail.com>
# Version:  0.1.0
################################################################################
__powerline() {

    # Unicode symbols
    #readonly PS_SYMBOL_DARWIN=''
    readonly PS_SYMBOL_DARWIN='⚡︎'
    readonly PS_SYMBOL_LINUX='$'
    readonly PS_SYMBOL_OTHER='%'
    readonly GIT_BRANCH_SYMBOL='⑂ '
    readonly GIT_BRANCH_CHANGED_SYMBOL='+'
    readonly GIT_NEED_PUSH_SYMBOL='⇡'
    readonly GIT_NEED_PULL_SYMBOL='⇣'

    # Colors
    readonly FG_BLACK="\[$(tput setaf 0)\]"
    readonly FG_RED="\[$(tput setaf 1)\]"
    readonly FG_GREEN="\[$(tput setaf 2)\]"
    readonly FG_YELLOW="\[$(tput setaf 3)\]"
    readonly FG_BLUE="\[$(tput setaf 4)\]"
    readonly FG_MAGENTA="\[$(tput setaf 5)\]"
    readonly FG_CYAN="\[$(tput setaf 6)\]"
    readonly FG_WHITE="\[$(tput setaf 7)\]"
    readonly FG_BLACK_BRIGHT="\[$(tput setaf 8)\]"
    readonly FG_RED_BRIGHT="\[$(tput setaf 9)\]"
    readonly FG_GREEN_BRIGHT="\[$(tput setaf 10)\]"
    readonly FG_YELLOW_BRIGHT="\[$(tput setaf 11)\]"
    readonly FG_BLUE_BRIGHT="\[$(tput setaf 12)\]"
    readonly FG_MAGENTA_BRIGHT="\[$(tput setaf 13)\]"
    readonly FG_CYAN_BRIGHT="\[$(tput setaf 14)\]"
    readonly FG_WHITE_BRIGHT="\[$(tput setaf 15)\]"

    readonly BG_BLACK="\[$(tput setab 0)\]"
    readonly BG_RED="\[$(tput setab 1)\]"
    readonly BG_GREEN="\[$(tput setab 2)\]"
    readonly BG_YELLOW="\[$(tput setab 3)\]"
    readonly BG_BLUE="\[$(tput setab 4)\]"
    readonly BG_MAGENTA="\[$(tput setab 5)\]"
    readonly BG_CYAN="\[$(tput setab 6)\]"
    readonly BG_WHITE="\[$(tput setab 7)\]"
    readonly BG_BLACK_BRIGHT="\[$(tput setab 8)\]"
    readonly BG_RED_BRIGHT="\[$(tput setab 9)\]"
    readonly BG_GREEN_BRIGHT="\[$(tput setab 10)\]"
    readonly BG_YELLOW_BRIGHT="\[$(tput setab 11)\]"
    readonly BG_BLUE_BRIGHT="\[$(tput setab 12)\]"
    readonly BG_MAGENTA_BRIGHT="\[$(tput setab 13)\]"
    readonly BG_CYAN_BRIGHT="\[$(tput setab 14)\]"
    readonly BG_WHITE_BRIGHT="\[$(tput setab 15)\]"

    readonly DIM="\[$(tput dim)\]"
    readonly REVERSE="\[$(tput rev)\]"
    readonly RESET="\[$(tput sgr0)\]"
    readonly BOLD="\[$(tput bold)\]"

    # what OS?
    case "$(uname)" in
        Darwin)
            readonly PS_SYMBOL=$PS_SYMBOL_DARWIN
            ;;
        Linux)
            readonly PS_SYMBOL=$PS_SYMBOL_LINUX
            ;;
        *)
            readonly PS_SYMBOL=$PS_SYMBOL_OTHER
    esac

    __git_info() {
        [ -x "$(which git)" ] || return    # git not found

        # get current branch name or short SHA1 hash for detached head
        local branch="$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --always 2>/dev/null)"
        [ -n "$branch" ] || return  # git branch not found

        local marks

        # branch is modified?
        [ -n "$(git status --porcelain)" ] && marks+=" $GIT_BRANCH_CHANGED_SYMBOL"

        # how many commits local branch is ahead/behind of remote?
        local stat="$(git status --porcelain --branch | grep '^##' | grep -o '\[.\+\]$')"
        local aheadN="$(echo $stat | grep -o 'ahead \d\+' | grep -o '\d\+')"
        local behindN="$(echo $stat | grep -o 'behind \d\+' | grep -o '\d\+')"
        [ -n "$aheadN" ] && marks+=" $GIT_NEED_PUSH_SYMBOL$aheadN"
        [ -n "$behindN" ] && marks+=" $GIT_NEED_PULL_SYMBOL$behindN"

        # print the git branch segment without a trailing newline
        printf " $GIT_BRANCH_SYMBOL$branch$marks "
    }

    ps1() {
        # Check the exit code of the previous command and display different
        # colors in the prompt accordingly.
        if [ $? -eq 0 ]; then
            local BG_EXIT="$BG_GREEN"
        else
            local BG_EXIT="$BG_RED"
        fi
        PS1="$BG_MAGENTA$FG_BLACK \w $RESET"
        PS1+="$BG_BLUE$FG_BLACK$(__git_info)$RESET"
        PS1+="$BG_EXIT$FG_BLACK $PS_SYMBOL $RESET "
    }

    PROMPT_COMMAND=ps1
}

__powerline
unset __powerline
