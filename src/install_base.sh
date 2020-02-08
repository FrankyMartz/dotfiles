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

    [[ -L "${XDG_CONFIG_HOME}/default-packages" ]] && ln -s "./default-packages" "${XDG_CONFIG_HOME}/default-packages"
    ln -fs "${_BASH}/bashrc.sh" "${HOME}/.bashrc";
    ln -fs "${_PWD}/asdfrc.sh" "${HOME}/.asdfrc"

    #---------------------------------------------------------------------------
    # Install: Homebrew
    #---------------------------------------------------------------------------
    if [[ ! -x $(command -v brew) ]]; then
      dLog "${GREEN}==> Installing Homebrew...";
      /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
      dLog "${GREEN}==> Installing Homebrew...DONE";
    fi

    if [[ -x $(command -v brew) ]]; then
      if [[ -r "${_brewfile}" ]]; then
        dLog "${GREEN}==> Installing Homebrew Packages...";
        /usr/bin/env brew bundle "${_brewfile}";
        dLog "${GREEN}==> Installing Homebrew Packages...DONE";
      fi

      dLog "${GREEN}==> Homebrew Cleanup...";
      /usr/bin/env brew cleanup;
      dLog "${GREEN}==> Homebrew Cleanup...DONE";
    fi

    #---------------------------------------------------------------------------
    # Install: NPM
    #---------------------------------------------------------------------------
    if [[ -x $(command -v npm) && "${#_npm_packages[@]}" -eq 0 ]]; then
        dLog "${GREEN}==> Installing NPM Packages...";
        /bin/env npm install --global "${_npm_packages[@]}";
        dLog "${GREEN}==> Installing NPM Packages...DONE";
    fi

    #---------------------------------------------------------------------------
    # Install: Nodenv
    #---------------------------------------------------------------------------
    if [[ -x $(command -v nodenv) && "${#_npm_packages[@]}" -eq 0  ]]; then
        dLog "${GREEN}==> Nodenv (default-packages)...";
        local DEFAULT_PACKAGES;
        DEFAULT_PACKAGES="${XDG_CONFIG_HOME}/nodenv/default-packages";
        [[ -L "${DEFAULT_PACKAGES}" ]] && ln -fs "${_PWD}/src/default-packages" "${DEFAULT_PACKAGES}"

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
    if [[ -x $(command -v go) ]]; then
        dLog "${GREEN}==> Installing GoLang Tools...";
        /usr/bin/env go get "golang.org/x/tools/cmd/vet";
        /usr/bin/env go get "golang.org/x/tools/cmd/godoc";
        dLog "${GREEN}==> Installing GoLang Tools...DONE";
    fi

    dLog "${BLUE}Base Configuration...DONE"
}
__configBase
unset __configBase

