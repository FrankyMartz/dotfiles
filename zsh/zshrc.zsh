#!/usr/bin/env zsh
################################################################################
# *** auto-generated by (github.com/FrankyMartz/dotfiles) ***
# FrankyMartz Flavored ZSH
#
# Author:   Franky Martinez <frankymartz@gmail.com>
################################################################################

bindkey -v

precmd() { RPROMPT="" }

DOTFILE_DIR="${HOME}/.dotfiles"

#===============================================================================
# COMMON
#===============================================================================

export LANG=en_US.UTF-8

# shellcheck source=/dev/null
[[ -f "${HOME}/.fzf.zsh" ]] && source "${HOME}/.fzf.zsh";

[[ -f "${HOME}/.bashrc" ]] && source "${HOME}/.bashrc";


# iTerm Integration ------------------------------------------------------------
# shellcheck source=/dev/null
[[ -x "${HOME}/.iterm2_shell_integration.zsh" ]] && source "${HOME}/.iterm2_shell_integration.zsh";

#===============================================================================
# Foundation
#===============================================================================

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt appendhistory autocd extendedglob nomatch notify
unsetopt beep

#===============================================================================
# PLUGINS
#===============================================================================

# HOTFIX: https://github.com/zsh-users/antigen/issues/593
# autoload -U is-at-least
# source "${HOME}/.dotfiles/zsh/zsh_plugins.sh"

export BOOKMARKS_FILE="${DOTFILE_DIR}/bin/zsh_cd_bookmarks";

# Package: AutoSuggestion ------------------------------------------------------

ZSH_AUTOSUGGEST_USE_ASYNC=true;

# SpaceShip-Prompt -------------------------------------------------------------

# SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SUFFIX=" "; # 
SPACESHIP_CHAR_SYMBOL=""; #       

# SPACESHIP_VI_MODE_SHOW=true;
SPACESHIP_VI_MODE_PREFIX=" "; # [ 
# SPACESHIP_VI_MODE_SUFFIX=" "; # ] 
SPACESHIP_VI_MODE_INSERT="卑"; #  卑    
SPACESHIP_VI_MODE_NORMAL="喝"; #  喝        
SPACESHIP_VI_MODE_COLOR="cyan";


SPACESHIP_GIT_SYMBOL=" ";
SPACESHIP_GIT_STATUS_UNTRACKED=""; # ◎ ◉  
SPACESHIP_GIT_STATUS_ADDED="●"; #  ● ✚
SPACESHIP_GIT_STATUS_MODIFIED="○"; # ○  
SPACESHIP_GIT_STATUS_RENAMED="➡"; #    
SPACESHIP_GIT_STATUS_DELETED="";
SPACESHIP_GIT_STATUS_STASHED="";
SPACESHIP_GIT_STATUS_UNMERGED=" "; #  劣
SPACESHIP_GIT_STATUS_AHEAD="⬆";
SPACESHIP_GIT_STATUS_BEHIND="⬇";
SPACESHIP_GIT_STATUS_DIVERGED=" "; #  咽

spaceship_vi_mode_enable

#===============================================================================
# Alias
#===============================================================================

source "${DOTFILE_DIR}/alias.sh";

#===============================================================================
# DOTENV LOAD
#===============================================================================

eval "$(direnv hook zsh)"
