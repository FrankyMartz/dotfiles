#!/usr/bin/env bash
################################################################################
# *** auto-generated by (github.com/FrankyMartz/dotfiles) ***
# FrankyMartz Flavored Bash Shell
#
# Author:   Franky Martinez <frankymartz@gmail.com>
# Version:  0.1.0
################################################################################
stty -ixon -ixoff
set -o vi

#===============================================================================
# PATH Default
#===============================================================================
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/git/bin";
export XDG_CONFIG_HOME="${HOME}/.config";

#===============================================================================
# Foundation
#===============================================================================

# shellcheck source=/dev/null
[[ -x "${HOME}/.profile" ]] && source "${HOME}/.profile"

if [[ -d "${HOME}/.iterm2" ]]; then
    PATH="${PATH}:${HOME}/.iterm2";
fi

if [[ -x "$(command -v brew)" ]]; then
    # BASH ---------------------------------------------------------------------
    if [[ -x "$(brew --prefix)/bin/bash" ]]; then
        SHELL="$(brew --prefix)/bin/bash";
        export SHELL;
    fi

    # BASH Completion ----------------------------------------------------------
    # shellcheck source=/dev/null
    [[ -f "$(brew --prefix)/etc/bash_completion" ]] && . "$(brew --prefix)/etc/bash_completion";

    # GNU --------------------------------------------------------------------------
    PATH="$(brew --prefix coreutils)/libexec/gnubin:${PATH}";
    MANPATH="$(brew --prefix coreutils)/libexec/gnuman:${MANPATH}";
    export MANPATH;

    # Docker -----------------------------------------------------------------------
    # shellcheck source=/dev/null
    [[ -s "$(brew --prefix dvm)/dvm.sh" ]] && source "$(brew --prefix dvm)/dvm.sh"
fi

# In order for gpg to find gpg-agent, gpg-agent must be running, and there must
# be an env variable pointing GPG to the gpg-agent socket. Start gpg-agent or
# set up the GPG_AGENT_INFO variable if it's already running.
# if [ -f ~/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
   # shellcheck source=/dev/null
    # source ~/.gnupg/.gpg-agent-info
    # export GPG_AGENT_INFO
# else
    # eval "$(gpg-agent --daemon ~/.gnupg/.gpg-agent-info)"
# fi

# YarnPkg ----------------------------------------------------------------------

if [[ -x "$(command -v yarn)" ]]; then
    PATH="${PATH}:${HOME}/.config/yarn/global/node_modules/.bin:$(yarn global bin)"
fi


#===============================================================================
# PROMPT LOOK
#===============================================================================
# Base16-Shell -----------------------------------------------------------------
# BASE16_SHELL="$HOME/.dotfiles/bin/base16-shell/scripts/base16-eighties.sh"
## shellcheck source=/dev/null
# [[ -s "$BASE16_SHELL" ]] && . "$BASE16_SHELL"
# Set Colors In Profile
# BASE16_SHELL="${HOME}/.dotfiles/bin/base16-shell/"
# [ -n "$PS1" ] && [ -s "${BASE16_SHELL}/profile_helper.sh" ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# BASH_POWERLINE ---------------------------------------------------------------
# shellcheck source=/dev/null
[[ -f "${HOME}/.dotfiles/bin/shell_prompt.sh" ]] && source "${HOME}/.dotfiles/bin/shell_prompt.sh";


# NEOVIM -----------------------------------------------------------------------
# export TERM='xterm-256color'
# export NVIM_TUI_ENABLE_TRUE_COLOR=1;
export EDITOR="nvim";

# FZF --------------------------------------------------------------------------
if [[ -f "${HOME}/.fzf.bash" ]]; then
    # shellcheck source=/dev/null
    source "${HOME}/.fzf.bash";
    # export FZF_DEFAULT_COMMAND='ag -g ""';
    export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""';
    export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}";
fi

# iTerm Integration ------------------------------------------------------------
# shellcheck source=/dev/null
[[ -x "${HOME}/.iterm2_shell_integration.bash" ]] && source "${HOME}/.iterm2_shell_integration.bash";

# GNUpg ------------------------------------------------------------------------
PATH="/usr/local/opt/gnupg/libexec/gpgbin:${PATH}"


#===============================================================================
# IRC
#===============================================================================
export IRCNICK="frankymartz";
export IRCNAME="No Konami Code.";
export IRCSERVER="http://chat.freenode.net";


#===============================================================================
# ALIASES
#===============================================================================
alias less='less --RAW-CONTROL-CHARS'
alias ll='ls -FAlhG --color --group-directories-first'; # color-mode
alias irc='screen -t 1 irssi';
alias chrome-cors='open -a Google\ Chrome --args --disable-web-security --user-data-dir';
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias chrome-canary='/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary'

alias pe='path-extractor';
alias PP='git st | pe | fzf -m | xargs git add && clear && printf "\e[3J" && git st';
alias pass-keygen="openssl rand -base64"


#===============================================================================
# Bind
#===============================================================================
# bind '"CC": "| pe | fzf | pbcopy && clear &&  pbpaste || xargs echo"'


#===============================================================================
# LANGUAGES
#===============================================================================

# Google Cloud SDK -------------------------------------------------------------
# Update PATH for the Google Cloud SDK.
# shellcheck source=/dev/null
# [[ -x "${HOME}/google-cloud-sdk/path.bash.inc" ]] && source "${HOME}/google-cloud-sdk/path.bash.inc"
# Enable gcloud Shell Command Completion
# shellcheck source=/dev/null
# [[ -x "${HOME}/google-cloud-sdk/completion.bash.inc" ]] && source "${HOME}/google-cloud-sdk/completion.bash.inc"

# PYTHON -----------------------------------------------------------------------
PATH="/usr/local/opt/python/libexec/bin:${PATH}"
export PYTHONPATH="${HOME}/.dotfiles/bin/python";
# Auto-Complete
if [[ -x "$(command -v pyenv)" ]]; then
    export PYENV_ROOT="/usr/local/var/pyenv";
    export PYTHON_CONFIGURE_OPTS="--enable-shared"
    eval "$(pyenv init -)";
fi

# Setup Python Virtual Environment
if [[ -x "$(command -v pyenv-virtualenv-init)" ]]; then
    eval "$(pyenv virtualenv-init -)";
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
fi

# GO-LANG ----------------------------------------------------------------------
export GOROOT="/usr/local/opt/go/libexec";
export GOPATH="${HOME}/go";
# export GOPATH="${HOME}/go:${HOME}/go_appengine/gopath";
PATH="${PATH}:${GOROOT}/bin:${GOPATH}/bin";
# PATH="${PATH}:${HOME}/go_appengine";

# RBENV ------------------------------------------------------------------------
## Use Homebrew's directories rather than ~/.rbenv add to your profile
export RBENV_ROOT="/usr/local/var/rbenv"
export PATH="${RBENV_ROOT}/bin:${PATH}"

## Enable shims and autocompletion add to your profile
[[ -x "$(command -v rbenv)" ]] && eval "$(rbenv init -)";

if [[ -x "$(command -v ruby)" && -x "$(command -v gem)" ]]; then
    PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin:${PATH}";
fi

# PHP --------------------------------------------------------------------------
#PATH="${PATH}:${HOME}/.composer/vendor/bin"

# Nodeenv ----------------------------------------------------------------------
export NODENV_ROOT="/usr/local/var/nodenv"
[[ -x "$(command -v nodenv)" ]] && eval "$(nodenv init -)"
# Include NPM Package Develop Directory
export PATH=$PATH:~/npm/bin

#===============================================================================
# DOTENV LOAD
#===============================================================================

if [[ -e "$HOME/.dotfiles/.env" ]]; then
    # shellcheck disable=SC2163
    while read -r line ; do
        export "$line";
    done < "$HOME/.dotfiles/.env"
fi

eval "$(direnv hook bash)"
