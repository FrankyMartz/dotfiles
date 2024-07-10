#!/usr/bin/env bash
################################################################################
# *** auto-generated by (github.com/FrankyMartz/dotfiles) ***
# Common Bash Config
#
# Author:   Franky Martinez <frankymartz@gmail.com>
################################################################################

# if [[ $0 -e 'bash' ]]; then
#   export BASH_ENV="${HOME}/.dotfiles/shell/env.sh"
# fi

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
#
#
typeset FZF_DEFAULT_COMMAND=$(cat <<-END
  rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null ||
  fd --type f --hidden --follow --exclude .git
END
);
export FZF_DEFAULT_COMMAND;
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


