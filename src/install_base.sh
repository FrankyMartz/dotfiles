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

    local brew_langs=(
        python
        node
        go
        rbenv
    )

    local brew_tools=(
        git
        mercurial
        wget
        rename
        ctags
        htop-osx
        irssi
        cmake
        flow
    )

    local npm_packages=(
        browser-sync
        browserify
        csslint
        gulp
        js-yaml
        jshint
        jsonlint
        jsxhint
        jsctags
        node-inspector
        react-tools
        stylus
        trash
        svgo
        webpack
    )

    if [[ ! -x $(which brew) ]]; then
        #-----------------------------------------------------------------------
        # Install: Homebrew
        #-----------------------------------------------------------------------
        dLog "${GREEN}==> Installing Homebrew..."
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        dLog "${GREEN}==> Installing Homebrew...DONE"


        #-----------------------------------------------------------------------
        # Install: GNU Tools
        #-----------------------------------------------------------------------
        dLog "${GREEN}==> Installing GNU Tools..."

        #Install GNU core utilities (those that come with OS X are outdated)
        brew install coreutils

        # Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
        brew install findutils

        # Install Bash 4
        brew install bash
        brew install bash-completion

        # Install more recent versions of some OS X tools
        brew tap homebrew/dupes
        brew install homebrew/dupes/grep

        dLog "${GREEN}==> Installing GNU Tools...DONE"


        #-----------------------------------------------------------------------
        # Install: Programming Languages
        #-----------------------------------------------------------------------
        dLog "${GREEN}==> Installing Languages..."
        brew install ${brew_langs[*]}
        dLog "${GREEN}==> Installing Languages...DONE"


        #-----------------------------------------------------------------------
        # Install: CLI Tools
        #-----------------------------------------------------------------------
        dLog "${GREEN}==> Installing CLI Tools..."
        brew install ${brew_tools[*]}
        dLog "${GREEN}==> Installing CLI Tools...DONE"


        #-----------------------------------------------------------------------
        # Install: Neovim
        #-----------------------------------------------------------------------
        dLog "${GREEN}==> Installing Neovim..."
        brew tap neovim/homebrew-neovim
        brew install --HEAD neovim
        dLog "${GREEN}==> Installing Neovim...DONE"

        #-----------------------------------------------------------------------
        # Clean Up Homebrew
        #-----------------------------------------------------------------------
        dLog "${GREEN}==> Homebrew Cleanup..."
        brew cleanup
        dLog "${GREEN}==> Homebrew Cleanup...DONE"

        #-----------------------------------------------------------------------
        # Install: NPM Packages
        #-----------------------------------------------------------------------
        dLog "${GREEN}==> Installing NPM Packages..."
        npm install --global ${npm_packages[*]}
        dLog "${GREEN}==> Installing NPM Packages...DONE"

    else
        #-----------------------------------------------------------------------
        # Update
        #-----------------------------------------------------------------------
        dLog "${GREEN}==> Updating Homebrew Packages..."
        brew update
        dLog "${GREEN}==> Updating Homebrew Packages...DONE"

    fi

    dLog "${BLUE}Base Configuration...DONE"
}
__configBase
unset __configBase

