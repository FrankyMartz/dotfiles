""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim-Plug Configuration
" Author Franky Martinez <frankymartz@gmail.com>
"
" vim:set ft=vim et sw=2 ts=2 tw=80:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

function! UpdateRemote(arg)
    UpdateRemotePlugins
endfunction

" YouCompleteMe {{{
function! BuildYCM(info)
    " info is a dictionary with 3 fields
    " - name:   name of plugin
    " - status: 'installed', 'updated', or 'unchanged'
    " - force:  set on PlugInstall! or PlugUpdate!
    if a:info.status == 'updated' || a:info.force
        !/usr/bin/env python3 ./install.py --all
    endif
endfunction
" }}}

" vim-markdown-composer {{{
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction
" }}}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.nvim/bundle')
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" General
Plug 'tpope/vim-dispatch'
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } | Plug 'Xuyuanp/nerdtree-git-plugin' | Plug 'ivalkeen/nerdtree-execute'
Plug 'simnalamburt/vim-mundo', { 'on':  'MundoToggle' }
Plug 'mileszs/ack.vim'
Plug 'kshenoy/vim-signature'
Plug 'easymotion/vim-easymotion'
Plug 'chrisbra/vim-diff-enhanced'
Plug 'yggdroot/indentline', { 'on': 'IndentLinesToggle' } 
Plug 'direnv/direnv.vim'
Plug 'keith/investigate.vim'

" Window
Plug 'tpope/vim-fugitive' | Plug 'junegunn/gv.vim'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'universal-ctags/ctags'
" Plug 'ludovicchabant/vim-gutentags'
Plug 'c0r73x/neotags.nvim', {'do': function('UpdateRemote')}
Plug 'majutsushi/tagbar'
Plug 'mhinz/vim-signify'
Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'edkolev/promptline.vim'
Plug 'wesQ3/vim-windowswap'

" Editing
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/matchit.zip'
Plug 'scrooloose/nerdcommenter'
Plug 'godlygeek/tabular'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-characterize'
" Plug 'cyansprite/Extract'
Plug 'brooth/far.vim', { 'on': [ 'Far', 'F' ] }
Plug 'brettanomyces/nvim-editcommand'
" Plug 'rliang/termedit.nvim'
Plug 'matze/vim-move'

" Filetype
Plug 'editorconfig/editorconfig-vim'
Plug 'w0rp/ale'
" Plug 'scrooloose/syntastic'
Plug 'tpope/vim-dotenv', { 'for': ['env', 'Procfile'] }
Plug 'sheerun/vim-polyglot'

" >> VIML
Plug 'syngan/vim-vimlint' | Plug 'ynkdir/vim-vimlparser', { 'for': ['vim', 'viml'] }

" >> Apache
Plug 'vim-scripts/apachelogs.vim', { 'for': 'log' }
Plug 'vim-scripts/apachestyle', { 'for': 'log' }

" >> HTML
Plug 'tpope/vim-ragtag', { 'for': ['html', 'xml', 'javascript.jsx'] }
" Plug  'webdesus/polymer-ide.vim', { 'do': 'npm install' }

" >> CSS
Plug 'ap/vim-css-color'
Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'scss', 'less', 'stylus'] }
Plug 'gcorne/vim-sass-lint', { 'for': ['sass', 'scss'] }

" JavaScript / TypeScript
Plug 'Quramy/vim-js-pretty-template', { 'for': ['javascript', 'javascript.jsx', 'es6', 'typescript', 'ts', 'tsx'] }

" >> JavaScript
Plug 'othree/yajs.vim', { 'for': ['javascript', 'javascript.jsx', 'es6'] }
Plug 'othree/es.next.syntax.vim', { 'for': ['javascript', 'javascript.jsx', 'es6'] }
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx', 'es6', 'typescript', 'ts', 'tsx', 'coffeescript', 'coffee'] }
" Plug 'hushicai/tagbar-javascript.vim', { 'for': ['javascript', 'javascript.jsx', 'es6'] }
Plug 'marijnh/tern_for_vim', { 'do': 'npm install', 'for': ['javascript', 'javascript.jsx', 'es6'] }
Plug 'heavenshell/vim-jsdoc', { 'for': ['javascript', 'javascript.jsx', 'es6'] }
Plug 'epilande/vim-es2015-snippets', { 'for': [ 'javascript', 'javascript.jsx', 'es6' ] }
Plug 'epilande/vim-react-snippets', { 'for': [ 'javascript', 'javascript.jsx', 'es6' ] }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'javascript.jsx', 'es6'] }
" Plug 'facebook/vim-flow', { 'for': ['javascript', 'javascript.jsx', 'es6'] }
" Plug 'angelozerr/tern-lint', { 'for': ['javascript', 'javascript.jsx', 'es6'] }
" Plug 'neoclide/vim-jsx-improve', { 'for': ['javascript', 'javascript.jsx', 'es6'] }

" >> TypeScript
Plug 'HerringtonDarkholme/yats.vim', { 'for': ['typescript', 'ts', 'tsx'] }
Plug 'jason0x43/vim-js-indent', { 'for': ['typescript', 'ts', 'tsx'] }

" >> Markdown
Plug 'junegunn/goyo.vim', { 'for': ['markdown', 'md'] }
" Plug 'junegunn/limelight.vim', { 'for': ['markdown', 'md'] }
Plug 'ajorgensen/vim-markdown-toc', { 'for': ['markdown', 'md'] }
" Plug 'shime/vim-livedown', { 'for': ['markdown', 'md'] }
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer'), 'for': ['markdown', 'md'] }

" >> PHP
" Plug 'shawncplus/phpcomplete.vim', { 'for': 'php' }
Plug 'tobyS/pdv', { 'for': 'php' }
Plug 'markwu/vim-laravel4-snippets', { 'for': 'php' }

" >> Python
Plug 'jmcantrell/vim-virtualenv'

" >> GoLang
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' }
Plug 'sebdah/vim-delve', { 'for': 'go' }

" Color and Font
" Plug 'chriskempson/base16-vim'
Plug 'lifepillar/vim-solarized8'
Plug 'mhartington/oceanic-next'
" Plug 'morhetz/gruvbox'
" Plug 'arcticicestudio/nord-vim'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Devicons MUST be loaded last
Plug 'ryanoasis/vim-devicons'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#end()
