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
        go
        node
        python
    )

    local brew_tools=(
        caddy
        checkbashisms
        cmake
        ctags
        diff-so-fancy
        dnsmasq
        docker
        docker-compose
        docker-machine
        fzf
        git
        git-lfs
        glide
        gpg
        htop-osx
        irssi
        libsass
        mercurial
        neovim
        node
        node-build
        nodenv
        nodenv/nodenv/nodenv-default-packages
        openssl
        path-extractor
        pyenv
        pyenv-virtualenvwrapper
        python
        rbenv
        rbenv-bundler
        rename
        ruby-build
        shellcheck
        the_silver_searcher
        tidy-html5
        wget
        yank
    )

    declare -a npm_packages;
    mapfile -t npm_packages < "${_PWD}/default-packages"

    if [[ ! -x $(which brew) ]]; then
        #-----------------------------------------------------------------------
        # Install: Homebrew
        #-----------------------------------------------------------------------
        dLog "${GREEN}==> Installing Homebrew..."
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
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
        /usr/bin/env brew install homebrew/dupes/rsync

        dLog "${GREEN}==> Installing GNU Tools...DONE"


        #-----------------------------------------------------------------------
        # Install: Programming Languages
        #-----------------------------------------------------------------------
        dLog "${GREEN}==> Installing Languages..."
        /usr/bin/env brew install "${brew_langs[@]}"
        dLog "${GREEN}==> Installing Languages...DONE"


        #-----------------------------------------------------------------------
        # Install: CLI Tools
        #-----------------------------------------------------------------------
        dLog "${GREEN}==> Installing CLI Tools..."
        /usr/bin/env brew install "${brew_tools[@]}"
        dLog "${GREEN}==> Installing CLI Tools...DONE"

        #-----------------------------------------------------------------------
        # Install: FZF
        #-----------------------------------------------------------------------
        dLog "${GREEN}==> Installing FZF..."
        # shellcheck source=/dev/null
        [[ -x ~/.fzf/install ]] || . ~/.fzf/install
        dLog "${GREEN}==> Installing FZF...DONE"

        #-----------------------------------------------------------------------
        # Clean Up Homebrew
        #-----------------------------------------------------------------------
        dLog "${GREEN}==> Homebrew Cleanup..."
        /usr/bin/env brew cleanup
        dLog "${GREEN}==> Homebrew Cleanup...DONE"

        #-----------------------------------------------------------------------
        # Install: Nodenv
        #-----------------------------------------------------------------------
        dLog "${GREEN}==> Nodenv (default-packages)..."
        local NODENV_DEFAULT;
        NODENV_DEFAULT="$(/usr/bin/env nodenv root)/default-packages";
        [[ -L "${NODENV_DEFAULT}" ]] || ln -fs "${_PWD}/default-packages" "${NODENV_DEFAULT}"
        dLog "${GREEN}==> Nodenv (default-packages)...DONE"

        #-----------------------------------------------------------------------
        # Install: NPM Packages
        #-----------------------------------------------------------------------
        dLog "${GREEN}==> Installing NPM Packages..."
        /usr/bin/env npm install --global "${npm_packages[@]}"
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
        /usr/bin/env brew upgrade --all
        dLog "${GREEN}==> Updating Homebrew Packages...DONE"

        #-----------------------------------------------------------------------
        # Update: NPM
        #-----------------------------------------------------------------------
        dLog "${GREEN}==> Updating NPM Packages..."
        /usr/bin/env npm update -g
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
        /usr/bin/env pip freeze --local | grep -v '^\-e' | cut -d = -f 1 | grep -v 'vbox' | while IFS="" read -r package 
        do
            /usr/bin/env pip install -U "$package" || dLog "${package} ${RED}[FAIL]: $0"
        done
        dLog "${GREEN}==> Updating Python pip...DONE"
    fi

    dLog "${BLUE}Base Configuration...DONE"
}
__configBase
unset __configBase

