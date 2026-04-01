"===============================================================================
" Vim-Plug Configuration
" Author Franky Martinez <frankymartz@gmail.com>
"
" vim:set ft=vim et sw=2 ts=2 tw=80:
"===============================================================================

let data_dir = stdpath('data') . '/site'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.nvim/bundle')

" Plug : Config ============================================================ {{{

let plugForMarkdown = { 'for': [ 'markdown', 'md' ] }
let plugForJavaScriptTypeScript = { 'for': [
    \ 'javascript',
    \ 'javascript.jsx',
    \ 'es6',
    \ 'typescript',
    \ 'ts',
    \ 'tsx',
  \ ]
\ }

" }}}

" Plug : List ============================================================== {{{

" Window
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive' |
  \ Plug 'mhinz/vim-startify' |
  \ Plug 'junegunn/gv.vim', { 'on': 'GV' }
Plug 'mhinz/vim-signify'
Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'wesQ3/vim-windowswap'

" General
Plug 'kshenoy/vim-signature'
Plug 'yggdroot/indentline', { 'on': 'IndentLinesToggle' }
Plug 'direnv/direnv.vim'
Plug 'tpope/vim-obsession'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " needed for previews
  Plug 'junegunn/fzf.vim'

Plug 'dbakker/vim-projectroot'
Plug 'Valloric/ListToggle'

" COC Intellisense
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
  Plug 'liuchengxu/vista.vim'   " TagBar Alternative
  Plug 'antoinemadec/coc-fzf'

" Editing
Plug 'mileszs/ack.vim'
Plug 'easymotion/vim-easymotion'
Plug 'bkad/CamelCaseMotion'
Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }
Plug 'tpope/vim-repeat'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
Plug 'mg979/vim-visual-multi'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-characterize'
Plug 'brooth/far.vim'
Plug 'matze/vim-move'
Plug 'wellle/targets.vim'
Plug 'reedes/vim-textobj-sentence'
Plug 'vim-scripts/LargeFile'
Plug 'mtth/scratch.vim', {
  \ 'on': [
    \ 'Scratch',
    \ 'ScratchInsert',
    \ 'ScratchSelection',
    \ 'ScratchPreview'
  \ ]
\ }

" Filetype
Plug 'editorconfig/editorconfig-vim'
Plug 'chrisbra/vim-diff-enhanced'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-dotenv', { 'for': ['env', 'Procfile'] }
Plug 'mechatroner/rainbow_csv', { 'for': ['csv'] }

" Snippets
Plug 'honza/vim-snippets'
Plug 'epilande/vim-es2015-snippets', plugForJavaScriptTypeScript
Plug 'epilande/vim-react-snippets', plugForJavaScriptTypeScript

" >> HTML
Plug 'tpope/vim-ragtag'

" >> JavaScript
Plug 'heavenshell/vim-jsdoc', plugForJavaScriptTypeScript

" >> Markdown
Plug 'junegunn/goyo.vim', plugForMarkdown
Plug 'ajorgensen/vim-markdown-toc', plugForMarkdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & npm install'  }

" >> GoLang
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' }
Plug 'sebdah/vim-delve', { 'for': 'go' }

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Color and Font
Plug 'lifepillar/vim-solarized8'
Plug 'base16-project/base16-vim'
Plug 'mhartington/oceanic-next'
Plug 'rose-pine/neovim', { 'as': 'rose-pine' }



" Devicons MUST be loaded last
Plug 'preservim/nerdtree' |
  \ Plug 'Xuyuanp/nerdtree-git-plugin' |
  \ Plug 'ryanoasis/vim-devicons' |

Plug 'ivalkeen/nerdtree-execute'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" ========================================================================== }}}

call plug#end()
