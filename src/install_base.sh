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
    )

    local brew_tools=(
        rbenv
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

        #-----------------------------------------------------------------------
        # Install: GoLang Packages
        #-----------------------------------------------------------------------
        dLog "${GREEN}==> Installing GoLang Tools..."
        go get golang.org/x/tools/cmd/vet
        go get golang.org/x/tools/cmd/godoc
        dLog "${GREEN}==> Installing GoLang Tools...DONE"

    else
        #-----------------------------------------------------------------------
        # Update: Homebrew
        #-----------------------------------------------------------------------
        dLog "${GREEN}==> Updating Homebrew Packages..."
        brew update
        brew upgrade
        dLog "${GREEN}==> Updating Homebrew Packages...DONE"

        #-----------------------------------------------------------------------
        # Update: NPM
        #-----------------------------------------------------------------------
        dLog "${GREEN}==> Updating NPM Packages..."
        npm update -g $(ls `npm root -g` | grep -v "npm")
        dLog "${GREEN}==> Updating NPM Packages...DONE"

        #-----------------------------------------------------------------------
        # Update: Ruby Gems
        #-----------------------------------------------------------------------
        dLog "${GREEN}==> Updating Ruby Gems..."
        gem update
        dLog "${GREEN}==> Updating Ruby Gems...DONE"

        #-----------------------------------------------------------------------
        # Update: Python pip
        #-----------------------------------------------------------------------
        dLog "${GREEN}==> Updating Python pip..."
        pip install -U $(pip freeze --local | grep -v '^\-e' | cut -d = -f 1 | grep -v 'vbox')
        dLog "${GREEN}==> Updating Python pip...DONE"
    fi

    dLog "${BLUE}Base Configuration...DONE"
}
__configBase
unset __configBase

