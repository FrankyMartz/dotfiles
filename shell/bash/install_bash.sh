#!/usr/bin/env bash
################################################################################
# Bash Configuration
# Prepare Bash Shell for Awesomeness.
#
# Author:   Franky Martinez <frankymartz@gmail.com>
# Require:  ../install
################################################################################
__configBASH(){
    dLog "${BLUE}Bash Shell Configuration..."

    local _BASH="${_PWD}/bash"

    #===========================================================================
    # Symbolic Links
    #===========================================================================

    ln -fs "${_BASH}/bash_profile.sh" "$(HOME)/.bash_profile";

    #===========================================================================
    # RELOAD BASH PROFILE
    #===========================================================================

    source "$(HOME)/.bash_profile";

    #===========================================================================
    # Base16-Shell
    #===========================================================================

    local NERDFONTS="${_BIN}/nerd-fonts"
    if [[ ! -d $NERDFONTS ]]; then
        dLog "${BLUE}Installing Nerd-Fonts..."
        /usr/bin/env git clone "https://github.com/ryanoasis/nerd-fonts.git" "${NERDFONTS}"
        dLog "${BLUE}Installing Nerd-Fonts...DONE"
    fi

    local SENSIBLE="${_BIN}/sensible"
    if [[ ! -d $SENSIBLE ]]; then
        dLog "${BLUE}Installing Sensible..."
        /usr/bin/env git clone "https://github.com/mrzool/bash-sensible.git" "${SENSIBLE}"
        dLog "${BLUE}Installing Sensible...DONE"
    fi

    dLog "${BLUE}Bash Shell Configuration...DONE"
}
__configBASH
unset __configBASH

