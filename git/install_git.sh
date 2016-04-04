#!/usr/bin/env bash
################################################################################
# Git Configuration
# Configure Git for General Usage
#
# Author:   Franky Martinez <frankymartz@gmail.com>
# Version:  0.1.0
# Require:  ../install
################################################################################
__configGit(){
    dLog "${BLUE}Git Configuration..."

    local _GIT="${_PWD}/git"

    [[ -L ~/.gitconfig ]] || ln -bfs "${_GIT}/gitconfig" "${HOME}/.gitconfig"
    [[ -L ~/.gitignore_global ]] || ln -bfs "${_GIT}/gitignore_global" "${HOME}/.gitignore_global"

    dLog "${BLUE}Git Configuration...DONE"
}
__configGit
unset __configGit

