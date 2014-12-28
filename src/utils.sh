#!/usr/bin/env bash
################################################################################
# Bash Script Utilies
# Helper Functions & Globals. Make Bash Scripting Easy-ish.
#
# Author:   Franky Martinez <frankymartz@gmail.com>
# Version:  0.1.0
################################################################################
#-------------------------------------------------------------------------------
# Colors
#-------------------------------------------------------------------------------
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
NORMAL=$(tput sgr0)

#-------------------------------------------------------------------------------
# Logging
#-------------------------------------------------------------------------------
dLog() {
    # Debug Log
    # $1 = message
    # $2 = Color
    echo "${*}${NORMAL}"
}

cLog(){
    # Check Log
    # params:
    # $1 = message with carriage return
    # $2 = add newline
    echo -ne "\r${MAGENTA}${1}${NORMAL}"
    if [[ ${2:-0} -eq 1 ]]; then
        echo -ne "\n"
    fi
}

pLog(){
    # Progress Log
    # example usage:
    # progress 30G 9G 30
    # 30G [================>.................................] 30% (9G)

    # params:
    # $1 = total value (e.g.: source size)
    # $2 = current value (e.g.: destination size)
    # $3 = percent completed
    [[ -z $1 || -z $2 || -z $3 ]] && exit  # on empty param...

    local percent=$3
    local completed=$(( $percent / 2 ))
    local remaining=$(( 50 - $completed ))

    echo -ne "\r${GREEN}${2} ${YELLOW}["
    printf "%0.s•" `seq $completed`
    echo -n ">"
    [[ $remaining != 0 ]] && printf "%0.s." `seq $remaining`
    echo -n "] ${GREEN}${percent}% ${BLUE}($1)${NORMAL}"
    if [[ ${3} -eq 100 ]]; then
        echo -ne "\n"
    fi
}

error() {
    local parent_lineno="$1"
    local message="$2"
    local code="${3:-1}"
    if [[ -n "$message" ]]; then
        dLog "${RED}Error: LN-> ${parent_lineno}; ${message}"
    else
        dLog "${RED}Error: LN-> ${parent_lineno}"
    fi
    exit "${code}"
}

