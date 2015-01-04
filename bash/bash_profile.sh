################################################################################
# *** auto-generated by (github.com/FrankyMartz/dotfiles) ***
# FrankyMartz Flavored Bash Shell
#
# Author:   Franky Martinez <frankymartz@gmail.com>
# Version:  0.1.0
################################################################################
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin

#===============================================================================
# General
#===============================================================================
export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
export TERM='xterm-256color'


#===============================================================================
# PROMPT LOOK
#===============================================================================

# Base16-Shell -----------------------------------------------------------------
BASE16_SHELL="$HOME/.dotfiles/bin/base16-shell/base16-eighties.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# BASH_POWERLINE ---------------------------------------------------------------
source "$HOME/.dotfiles/bash/bash_powerline.sh"

#===============================================================================
# IRC
#===============================================================================
export IRCNICK='frankymartz'
export IRCNAME='No Konami Code.'
export IRCSERVER=http://chat.freenode.net


#===============================================================================
# ALIASES
#===============================================================================
alias ll='ls -FalhG --color' # color-mode
alias vim='mvim -v'
alias vi='mvim -v'
alias irc='screen -t 1 irssi'


#===============================================================================
# BASH COMPLETION
#===============================================================================
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi


#===============================================================================
# LANGUAGES
#===============================================================================

# PYTHON -----------------------------------------------------------------------
export PYTHONPATH=~/.dotfiles/bin/python

# GO-LANG ----------------------------------------------------------------------
export GOROOT=/usr/local/opt/go/libexec/
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# RBENV ------------------------------------------------------------------------
## Use Homebrew's directories rather than ~/.rbenv add to your profile
export RBENV_ROOT=/usr/local/var/rbenv

## Enable shims and autocompletion add to your profile
if which rbenv > /dev/null; then
	eval "$(rbenv init -)";
fi

# PHP --------------------------------------------------------------------------
export PATH=$PATH:~/.composer/vendor/bin

