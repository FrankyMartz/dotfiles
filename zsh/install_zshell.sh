#!/usr/bin/env bash
################################################################################
# ZShell Configuration
# Prepare ZSHELL for Awesomeness.
#
# Author:   Franky Martinez <frankymartz@gmail.com>
# Require:  ../install
################################################################################
__configZSH(){
    dLog "${BLUE}ZShell Configuration..."

    local _ZSH="${_PWD}/zsh"

    #===========================================================================
    # Symbolic Links
    #===========================================================================

    ln -fs "${_ZSH}/zshrc.zsh" "$(HOME)/.bashrc";

    dLog "${BLUE}ZShell Configuration...DONE"
}
__configZSH
unset __configZSH


