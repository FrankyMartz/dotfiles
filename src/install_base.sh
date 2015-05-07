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
        rbenv-bundler
        nvm
        git
        mercurial
        wget
        the_silver_searcher
        rename
        ctags
        htop-osx
        irssi
        cmake
        flow
        shellcheck
    )

    local npm_packages=(
        bower
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
        bower
    )

    if [[ ! -x $(which brew) ]]; then
        #-----------------------------------------------------------------------
        # Install: Homebrew
        #-----------------------------------------------------------------------
        dLog "${GREEN}==> Installing Homebrew..."
        #/usr/bin/env ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        dLog "${GREEN}==> Installing Homebrew...DONE"


        #-----------------------------------------------------------------------
        # Install: GNU Tools
        #-----------------------------------------------------------------------
        dLog "${GREEN}==> Installing GNU Tools..."

        #Install GNU core utilities (those that come with OS X are outdated)
        /usr/bin/env brew install coreutils

        # Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
        /usr/bin/env brew install findutils

        # Install Bash 4
        /usr/bin/env brew install bash
        /usr/bin/env brew install bash-completion

        # Install more recent versions of some OS X tools
        /usr/bin/env brew tap homebrew/dupes
        /usr/bin/env brew install homebrew/dupes/grep

        dLog "${GREEN}==> Installing GNU Tools...DONE"


        #-----------------------------------------------------------------------
        # Install: Programming Languages
        #-----------------------------------------------------------------------
        dLog "${GREEN}==> Installing Languages..."
        /usr/bin/env brew install ${brew_langs[*]}
        dLog "${GREEN}==> Installing Languages...DONE"


        #-----------------------------------------------------------------------
        # Install: CLI Tools
        #-----------------------------------------------------------------------
        dLog "${GREEN}==> Installing CLI Tools..."
        /usr/bin/env brew install ${brew_tools[*]}
        dLog "${GREEN}==> Installing CLI Tools...DONE"


        #-----------------------------------------------------------------------
        # Install: Neovim
        #-----------------------------------------------------------------------
        dLog "${GREEN}==> Installing Neovim..."
        /usr/bin/env brew tap neovim/homebrew-neovim
        /usr/bin/env brew install --HEAD neovim
        dLog "${GREEN}==> Installing Neovim...DONE"

        #-----------------------------------------------------------------------
        # Clean Up Homebrew
        #-----------------------------------------------------------------------
        dLog "${GREEN}==> Homebrew Cleanup..."
        /usr/bin/env brew cleanup
        dLog "${GREEN}==> Homebrew Cleanup...DONE"

        #-----------------------------------------------------------------------
        # Install: NPM Packages
        #-----------------------------------------------------------------------
        dLog "${GREEN}==> Installing NPM Packages..."
        /usr/bin/env npm install --global ${npm_packages[*]}
        dLog "${GREEN}==> Installing NPM Packages...DONE"

        #-----------------------------------------------------------------------
        # Install: GoLang Packages
        #-----------------------------------------------------------------------
        dLog "${GREEN}==> Installing GoLang Tools..."
        /usr/bin/env go get golang.org/x/tools/cmd/vet
        /usr/bin/env go get golang.org/x/tools/cmd/godoc
        dLog "${GREEN}==> Installing GoLang Tools...DONE"

    else
        #-----------------------------------------------------------------------
        # Update: Homebrew
        #-----------------------------------------------------------------------
        dLog "${GREEN}==> Updating Homebrew Packages..."
        /usr/bin/env brew update
        /usr/bin/env brew upgrade
        dLog "${GREEN}==> Updating Homebrew Packages...DONE"

        #-----------------------------------------------------------------------
        # Update: NPM
        #-----------------------------------------------------------------------
        dLog "${GREEN}==> Updating NPM Packages..."
        /usr/bin/env npm update -g $(ls `npm root -g` | grep -v "npm")
        dLog "${GREEN}==> Updating NPM Packages...DONE"

        #-----------------------------------------------------------------------
        # Update: Ruby Gems
        #-----------------------------------------------------------------------
        dLog "${GREEN}==> Updating Ruby Gems..."
        /usr/bin/env gem update
        dLog "${GREEN}==> Updating Ruby Gems...DONE"

        #-----------------------------------------------------------------------
        # Update: Python pip
        #-----------------------------------------------------------------------
        dLog "${GREEN}==> Updating Python pip..."
        /usr/bin/env pip install -U $(pip freeze --local | grep -v '^\-e' | cut -d = -f 1 | grep -v 'vbox')
        dLog "${GREEN}==> Updating Python pip...DONE"
    fi

    dLog "${BLUE}Base Configuration...DONE"
}
__configBase
unset __configBase

