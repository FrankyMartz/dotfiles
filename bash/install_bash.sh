#!/usr/bin/env bash
################################################################################
# Bash Configuration
# Prepare Bash Shell for Awesomeness.
#
# Author:   Franky Martinez <frankymartz@gmail.com>
# Version:  0.1.0
# Require:  ../install
################################################################################
__configBASH(){
    dLog "${BLUE}Bash Shell Configuration..."

    local BASH="${PWD}/bash"
    #===========================================================================
    # Symbolic Links
    #===========================================================================
    ln -bfs ${BASH}/bash_profile.sh ~/.bash_profile


    #===========================================================================
    # Base16-Shell
    #===========================================================================
    local BASE16SHELL="${BIN}/base16-shell"
    if [[ ! -d "${BASE16SHELL}" ]]; then
        dLog "${BLUE}Installing Base16-Shell..."
        if [[ ! -d "${BASE16SHELL}/.git" ]]; then
            rm -Rf $BASE16SHELL
        fi
        git clone https://github.com/chriskempson/base16-shell.git $BASE16SHELL
        dLog "${BLUE}Installing Base16-Shell...DONE"
    else
        dLog "${BLUE}Updating Base16-Shell..."
        cd $BASE16SHELL
        git pull origin
        cd $PWD
        dLog "${BLUE}Updating Base16-Shell...DONE"
    fi


    dLog "${BLUE}Bash Shell Configuration...DONE"
}
__configBASH
unset __configBASH
