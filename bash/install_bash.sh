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

    local _BASH="${_PWD}/bash"
    #===========================================================================
    # Symbolic Links
    #===========================================================================

    [[ -L ~/.bash_profile ]] || ln -fs "${_BASH}/bash_profile.sh" "$(HOME)/.bash_profile"

    #===========================================================================
    # Base16-Shell
    #===========================================================================
    local BASE16SHELL="${_BIN}/base16-shell"
    if [[ ! -d $BASE16SHELL ]]; then
        dLog "${BLUE}Installing Base16-Shell..."
        /usr/bin/env git clone "https://github.com/chriskempson/base16-shell.git" "$BASE16SHELL"
        dLog "${BLUE}Installing Base16-Shell...DONE"
        /usr/bin/env git clone "https://github.com/ryanoasis/nerd-fonts.git"
    else
        dLog "${BLUE}Updating Base16-Shell..."
        echo "${BASE16SHELL}"
        cd "${BASE16SHELL}" || error "30:install_bash.sh" "Unable to CD into ${BASE16SHELL}"
        /usr/bin/env git pull origin
        cd "$_PWD" || error "32:install_bash.sh" "Unable to CD into ${_PWD}"
        dLog "${BLUE}Updating Base16-Shell...DONE"
    fi
    local NERDFONTS="${_BIN}/nerd-fonts"
    if [[ ! -d $NERDFONTS ]]; then
        dLog "${BLUE}Installing Nerd-Fonts..."
        /usr/bin/env git clone "https://github.com/ryanoasis/nerd-fonts.git" "$NERDFONTS"
        dLog "${BLUE}Installing Nerd-Fonts...DONE"
    else
        dLog "${BLUE}Updating Nerd-Fonts..."
        echo "${NERDFONTS}"
        cd "${NERDFONTS}" || error "45:install_bash.sh" "Unable to CD into ${NERDFONTS}"
        /usr/bin/env git pull origin
        cd "$_PWD" || error "47:install_bash.sh" "Unable to CD into ${_PWD}"
        dLog "${BLUE}Updating Nerd-Fonts...DONE"
    fi

    dLog "${BLUE}Bash Shell Configuration...DONE"
}
__configBASH
unset __configBASH
