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
if [[ ! -x $(command -v nvim) ]]; then
    error "Neovim not available. (Install or Add to \$PATH)"
fi

__configNVIM(){
    dLog "${BLUE}Configuring Neovim..."
    local _NEOVIM="${_PWD}/nvim"
    #===========================================================================
    # Symbolic Links
    #===========================================================================
    [[ -L ~/.nvim ]] || ln -fs "$_NEOVIM" ~/.nvim
    mkdir -p "${XDG_CONFIG_HOME:=$HOME/.config}"
    [[ -L "${XDG_CONFIG_HOME}/nvim" ]] || ln -s "$_NEOVIM" "${XDG_CONFIG_HOME}/nvim"

    #===========================================================================
    # Neovim Plugins
    #===========================================================================
    local BUNDLE="${_NEOVIM}/bundle"
    if [[ ! -d "${BUNDLE}" ]]; then
        # Plugins --------------------------------------------------------------
        dLog "${GREEN}==> Installing Neovim Plugins..."
        /usr/bin/env pip install neovim
        /usr/bin/env nvim +PlugInstall +qall
        dLog "${GREEN}==> Installing Neovim Plugins...DONE"

    else
        dLog "${GREEN}==> Updating Neovim Plugins..."
        /usr/bin/env pip install -U neovim
        /usr/bin/env nvim +PlugUpdate +qall
        dLog "${GREEN}==> Updating Neovim Plugins...DONE"
    fi

    #---------------------------------------------------------------------------
    dLog "${BLUE}Configuring Neovim...DONE"
}

__configNVIM
unset __configNVIM
