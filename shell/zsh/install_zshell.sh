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

    #===========================================================================
    # Symbolic Links
    #===========================================================================

    ln -fs "$${_PWD}/shell/zsh/ohmyzsh.zsh" "$(HOME)/.zshrc";

    dLog "${BLUE}ZShell Configuration...DONE"
}
__configZSH
unset __configZSH


