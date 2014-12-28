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

    if [[ ! -L "~/.gitconfig" ]]; then
        ln -bfs $PWD/git/gitconfig ~/.gitconfig
    fi
    
    if [[ ! -L "~/.gitignore_global" ]]; then
        ln -bfs $PWD/git/gitignore_global ~/.gitignore_global
    fi

    dLog "${BLUE}Git Configuration...DONE"
}
__configGit
unset __configGit

