################################################################################
# *** auto-generated by (github.com/FrankyMartz/dotfiles) ***
# .Brewfile
# Homebrew Configuration
#
# Author:   Franky Martinez <frankymartz@gmail.com>
################################################################################

#===============================================================================
# Homebrew: Start
#===============================================================================

update
upgrade

#===============================================================================
# SHELL
#===============================================================================

# SHELL: BASH ------------------------------------------------------------------
install "bash";
install "bash-completion";

# SHELL: ZSH -------------------------------------------------------------------
install "zsh";
install "zplug";
install "zsh-completion";

#===============================================================================
# GNU Core
#===============================================================================

# GNU core utilities (those that come with OS X are outdated)
install "coreutils";

# GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
install "findutils";

install "gnu-sed" --with-default-names;
install "gnu-tar" --with-default-names;
install "gnu-which" --with-default-names;

# Install more recent versions of some OS X tools
tap "homebrew/dupes";
install "homebrew/dupes/diffutils" --with-default-names;
install "homebrew/dupes/file-formula";
install "homebrew/dupes/gzip" --with-default-names;
install "homebrew/dupes/grep" --with-default-names;
install "homebrew/dupes/make" --with-default-names;
install "homebrew/dupes/less";
install "homebrew/dupes/openssh";
install "homebrew/dupes/rsync";
install "homebrew/dupes/screen";
install "homebrew/dupes/unzip";

install "wget";
install "rename";
install "rsync";
install "unzip";

#===============================================================================
# Utility
#===============================================================================

# Utility: Build ---------------------------------------------------------------
install "cmake";

# Utility: Environment ---------------------------------------------------------
install "direnv";
# install "screen";

# Utility: Security ------------------------------------------------------------
install "openssl";
install "gpg";

# Utility: Search --------------------------------------------------------------
install "fd";
install "ripgrep";
install "the_silver_searcher";
install "yank";

# Utility: Navigation ----------------------------------------------------------
install "path-extractor";
install "fpp";
install "fzf";
install "fzy";

# Utility: Git -----------------------------------------------------------------
install "git";
install "git-extras";
install "diff-so-fancy";

# Utility: Mercurial -----------------------------------------------------------
install "mercurial";

# Utility: Editor --------------------------------------------------------------
install "neovim";

# Utility: ctag ----------------------------------------------------------------
install "universal-ctags";

# Utility: Syntax Hightlight ---------------------------------------------------
install "highlight";

# Utility: IRC -----------------------------------------------------------------
# install "irssi";

#===============================================================================
# Language
#===============================================================================

# Languege: Swift --------------------------------------------------------------
install "cocoapods";

# Languege: Bash ---------------------------------------------------------------
install "checkbashisms";
install "shellcheck";

# Languege: GoLang -------------------------------------------------------------
install "go";
install "dep";

# Languege: NodeJS -------------------------------------------------------------
install "node";
install "node-build";
install "nodenv";
install "nodenv/nodenv/nodenv-default-packages";

# Languege: Python -------------------------------------------------------------
install "python";
install "pipenv";
install "pyenv";
install "pyenv-virtualenvwrapper";

# Languege: Ruby ---------------------------------------------------------------
install "ruby";
install "ruby-build";
install "rbenv";
install "rbenv-bundler";

# Languege: HTML ---------------------------------------------------------------
install "tidy-html5";

# Languege: Sass ---------------------------------------------------------------
install "libsass";

# Languege: Less ---------------------------------------------------------------
install "less";

# Languege: Lua ----------------------------------------------------------------
install "lua";

# Languege: Mono ---------------------------------------------------------------
install "mono";

#===============================================================================
# Development
# 
# NOTE: Avoid Installation
#===============================================================================

# install "selenium-server-standalone";
# install "mongodb";
# install "redis";
# install "sqlite";

#===============================================================================
# Homebrew: Finish
#===============================================================================

cleanup

