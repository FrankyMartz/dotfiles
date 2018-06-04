#!/usr/bin/env bash
################################################################################
# Base System Configuration
# Prepare Apple Mac with essentials.
#
# Author:   Franky Martinez <frankymartz@gmail.com>
# Version:  0.1.0
# Require:  ../install
################################################################################

__configBase(){
    dLog "${BLUE}Base Configuration..."

    _brewfile="${_PWD}/Brewfile.sh";

    declare -a _npm_packages;
    mapfile -t _npm_packages < "${_PWD}/src/default-packages"

    #---------------------------------------------------------------------------
    # Install: Base Shell Configuration
    #---------------------------------------------------------------------------

    ln -fs "${_BASH}/bashrc.sh" "$(HOME)/.bashrc";

    #---------------------------------------------------------------------------
    # Install: Homebrew
    #---------------------------------------------------------------------------
    if [[ -x $(which brew) ]]; then
        dLog "${GREEN}==> Installing Homebrew...";
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
        dLog "${GREEN}==> Installing Homebrew...DONE";

        if [[ -x $(which brew) ]]; then
            if [[ -r "${_brewfile}" ]]; then
                dLog "${GREEN}==> Installing Homebrew Packages...";
                /usr/bin/env brew bundle "${_brewfile}";
                dLog "${GREEN}==> Installing Homebrew Packages...DONE";
            fi

            dLog "${GREEN}==> Homebrew Cleanup...";
            /usr/bin/env brew cleanup;
            dLog "${GREEN}==> Homebrew Cleanup...DONE";
        fi
    fi

    #---------------------------------------------------------------------------
    # Install: NPM
    #---------------------------------------------------------------------------
    if [[ -x $(which npm) && "${#_npm_packages[@]}" -eq 0 ]]; then
        dLog "${GREEN}==> Installing NPM Packages...";
        /bin/env npm install --global "${_npm_packages[@]}";
        dLog "${GREEN}==> Installing NPM Packages...DONE";
    fi

    #---------------------------------------------------------------------------
    # Install: Nodenv
    #---------------------------------------------------------------------------
    if [[ -x "${which nodenv}" && "${#_npm_packages[@]}" -eq 0  ]]; then
        dLog "${GREEN}==> Nodenv (default-packages)...";
        local NODENV_DEFAULT;
        NODENV_DEFAULT="$(/usr/bin/env nodenv root)/default-packages";
        [[ -L "${NODENV_DEFAULT}" ]] || ln -fs "${_PWD}/default-packages" "${NODENV_DEFAULT}";
        dLog "${GREEN}==> Nodenv (default-packages)...DONE";
    fi

    #---------------------------------------------------------------------------
    # Install: FZF
    #---------------------------------------------------------------------------
    if [[ -x "${HOME}/.fzf/install" ]]; then
        dLog "${GREEN}==> Installing FZF...";
        # shellcheck source=/dev/null
        source "${HOME}/.fzf/install";
        dLog "${GREEN}==> Installing FZF...DONE";
    fi

    #---------------------------------------------------------------------------
    # Install: GoLang Packages
    #---------------------------------------------------------------------------
    if [[ -x $(which go) ]]; then
        dLog "${GREEN}==> Installing GoLang Tools...";
        /usr/bin/env go get "golang.org/x/tools/cmd/vet";
        /usr/bin/env go get "golang.org/x/tools/cmd/godoc";
        dLog "${GREEN}==> Installing GoLang Tools...DONE";
    fi

    dLog "${BLUE}Base Configuration...DONE"
}
__configBase
unset __configBase

