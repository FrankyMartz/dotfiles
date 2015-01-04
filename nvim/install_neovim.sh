#!/usr/bin/env bash
################################################################################
# Neovim Auto Configuration
# Prepare Apple Mac with Vim goodness
#
# Author:   Franky Martinez <frankymartz@gmail.com>
# Version:  0.1.0
# Require:  ../install
#           ../src/utils.sh
################################################################################

# Check Neovim installed and exists
if [[ ! -x $(which nvim) ]]; then
    error "Neovim not available. (Install or Add to \$PATH)"
fi

__configNVIM(){
    dLog "${BLUE}Configuring Neovim..."
    local NEOVIM="${PWD}/nvim"
    #===========================================================================
    # Symbolic Links
    #===========================================================================
    [[ -L ~/.nvim ]] || ln -bfs ${NEOVIM}/.nvim ~/.nvim
    [[ -L ~/.nvimrc ]] || ln -bfs ${NEOVIM}/.nvimrc ~/.nvimrc

    #===========================================================================
    # Neovim Plugins
    #===========================================================================
    local BUNDLE="${NEOVIM}/bundle"
    if [[ ! -d "${BUNDLE}" ]]; then
        # Vundle ---------------------------------------------------------------
        dLog "${GREEN}==> Installing Neovim Vundle..."
        mkdir $BUNDLE
        git clone https://github.com/gmarik/Vundle.vim.git $BUNDLE/vundle
        dLog "${GREEN}==> Installing Neovim Vundle...DONE"

        # Plugins --------------------------------------------------------------
        dLog "${GREEN}==> Installing Neovim Plugins..."
        nvim +PluginInstall +qall
        dLog "${GREEN}==> Installing Neovim Plugins...DONE"

        # TernJS ---------------------------------------------------------------
        dLog "${GREEN}==> Installing TernJS..."
        cd ${BUNDLE}/tern_for_vim
        npm install
        cd $PWD
        dLog "${GREEN}==> Installing TernJS...DONE"

        # YCM ------------------------------------------------------------------
        dLog "${GREEN}==> Compiling YouCompleteMe..."
        cd $BUNDLE/YouCompleteMe
        source install.sh
        cd $PWD
        dLog "${GREEN}==> Compiling YouCompleteMe...DONE"

    else
        dLog "${GREEN}==> Updating Neovim Plugins..."
        nvim +PluginUpdate +qall
        dLog "${GREEN}==> Updating Neovim Plugins...DONE"
    fi

    #---------------------------------------------------------------------------
    dLog "${BLUE}Configuring Neovim...DONE"
}

__configNVIM
unset __configNVIM
