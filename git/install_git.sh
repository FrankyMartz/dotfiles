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

    local GIT="${PWD}/git"

    [[ -L ~/.gitconfig ]] || ln -bfs $GIT/gitconfig ~/.gitconfig
    [[ -L ~/.gitignore_global ]] || ln -bfs $GIT/gitignore_global ~/.gitignore_global

    dLog "${BLUE}Git Configuration...DONE"
}
__configGit
unset __configGit

