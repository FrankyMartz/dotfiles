#!/usr/bin/env bash
################################################################################
# *** auto-generated by (github.com/FrankyMartz/dotfiles) ***
# Common Bash Config
#
# Author:   Franky Martinez <frankymartz@gmail.com>
################################################################################

export LANG=en_US.UTF-8

#===============================================================================
# PATH Default
#===============================================================================

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/git/bin";
export XDG_CONFIG_HOME="${HOME}/.config";
export XDG_DATA_HOME="${HOME}/.config/nvim"

#===============================================================================
# Foundation
#===============================================================================

if [[ -d "${HOME}/.iterm2" ]]; then
    export PATH="${PATH}:${HOME}/.iterm2";
fi

if [[ -x "$(command -v brew)" ]]; then
  # GNU ------------------------------------------------------------------------
  export PATH="/usr/local/opt/coreutils/libexec/gnubin:${PATH}";
  export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:${MANPATH}";
  export PATH="/usr/local/opt/curl/bin:${PATH}"
fi

#===============================================================================
# GPG
#===============================================================================

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
GPG_TTY="$(tty)"
export GPG_TTY

#===============================================================================
# NEOVIM
#===============================================================================

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

#===============================================================================
# FZF
#===============================================================================

# export FZF_DEFAULT_COMMAND='(git ls-tree -r --name-only HEAD || fd --type f --hidden --follow --exclude .git)';
# export FZF_DEFAULT_COMMAND=$(cat <<-END
  # git ls-tree -r --name-only HEAD || 
  # rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null ||
  # fd --type f --hidden --follow --exclude .git
# END
# );
FZF_DEFAULT_COMMAND=$(cat <<-END
  rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null ||
  fd --type f --hidden --follow --exclude .git
END
);
export FZF_DEFAULT_COMMAND
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}";
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'";

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.

if [[ -x "$(command -v fd)" ]]; then
  _fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
  }

  # Use fd to generate the list for directory completion
  _fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
  }
fi

#===============================================================================
# GNUpg
#===============================================================================
export PATH="/usr/local/opt/gnupg/libexec/gpgbin:${PATH}"

#===============================================================================
# IRC
#===============================================================================
export IRCNICK="frankymartz";
export IRCNAME="No Konami Code.";
export IRCSERVER="http://chat.freenode.net";

#===============================================================================
# OpenSSL
#===============================================================================

export PATH="/usr/local/opt/openssl/bin:${PATH}"

#===============================================================================
# Tools
#===============================================================================

export PATH="/usr/local/mysql/bin/:${PATH}"
#===============================================================================
# LANGUAGES
#===============================================================================

# C++ --------------------------------------------------------------------------

export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"

# PYTHON -----------------------------------------------------------------------

# Observe Python Tools
# export PATH="/usr/local/opt/python@2/bin:${PATH}"
export PYTHONPATH="${HOME}/.dotfiles/bin/python";

# PYENV
if [[ -x "$(command -v pyenv)" ]]; then
  # export PYENV_ROOT="$(brew --prefix pyenv)";
  # export PATH="${PYENV_ROOT}/bin:${PATH}"
  export PYTHON_CONFIGURE_OPTS="--enable-shared"
  eval "$(pyenv init -)";
fi

# GO-LANG ----------------------------------------------------------------------

export GOROOT="/usr/local/opt/go/libexec";
export GOPATH="${HOME}/go";
# export GOPATH="${HOME}/go:${HOME}/go_appengine/gopath";
export PATH="${PATH}:${GOROOT}/bin:${GOPATH}/bin";
# PATH="${PATH}:${HOME}/go_appengine";

# RUBY -------------------------------------------------------------------------

## Use Homebrew Ruby
export PATH="/usr/local/opt/ruby/bin:${PATH}"

if [[ -x "$(command -v ruby)" && -x "$(command -v gem)" ]]; then
  PATH="$(gem environment gemdir)/bin:${PATH}"
  export PATH
fi

# PHP --------------------------------------------------------------------------

#PATH="${PATH}:${HOME}/.composer/vendor/bin"

# NodeJS -----------------------------------------------------------------------

# export PATH="/Users/frankymartz/npm/bin:${PATH}"
export NODE_BUILD_DEFINITIONS="/usr/local/opt/node-build-update-defs/share/node-build"
export NODENV_ROOT="/usr/local/var/nodenv"
[[ -x "$(command -v nodenv)" ]] && eval "$(nodenv init -)"

# Mono -------------------------------------------------------------------------

export MONO_GAC_PREFIX="/usr/local"
export GTAGSLABEL="pygment"

# Rust -------------------------------------------------------------------------

export PATH="${HOME}/.cargo/bin:${PATH}"

# ASDF -------------------------------------------------------------------------

# source "$(brew --prefix asdf)/asdf.sh"
# source "$(brew --prefix asdf)/etc/bash_completion.d/asdf.bash"


# .NET Core SDK Tools ----------------------------------------------------------
export PATH="${PATH}:/Users/frankymartz/.dotnet/tools"
