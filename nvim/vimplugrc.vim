"===============================================================================
" Vim-Plug Configuration
" Author Franky Martinez <frankymartz@gmail.com>
"
" vim:set ft=vim et sw=2 ts=2 tw=80:
"===============================================================================

call plug#begin('~/.nvim/bundle')

" Plug : Helper ============================================================ {{{

" Helper : vim-markdown-composer

function! BuildComposer(info)
  if a:info.status !=? 'unchanged' || a:info.force
    if has('nvim')
      !/usr/bin/env cargo build --release
    else
      !/usr/bin/env cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction

" Helper : coc-fsharp

function! BuildCocFsharp(info)
  let shouldBuildCocFsharp = executable('dotnet') && (
    \ a:info.status ==? 'installed'||
    \ a:info.status ==? 'updated' ||
    \ a:info.force
  \)
  if shouldBuildCocFsharp
    !/usr/bin/env npm install
    !/usr/bin/env dotnet build -C Release
  endif
endfunction

"  }}}

" Plug : Config ============================================================ {{{

let plugNerdTreeConfig = { 'on': 'NERDTreeToggle' }
let plugForMarkdown = { 'for': [ 'markdown', 'md' ] }
let plugForJavaScript = { 'for': [
    \ 'javascript',
    \ 'javascript.jsx',
    \ 'es6',
  \ ]
\ }
let plugForJavaScriptBrowser = { 'for' : [
    \ 'xml',
    \ 'html',
    \ 'javascript',
    \ 'javascript.jsx',
    \ 'es6',
  \ ]
\ }
let plugForTypeScript = { 'for': [
    \ 'typescript',
    \ 'ts',
    \ 'tsx',
  \ ]
\ }
let plugForJavaScriptTypeScript = { 'for': [
    \ 'javascript',
    \ 'javascript.jsx',
    \ 'es6',
    \ 'typescript',
    \ 'ts',
    \ 'tsx',
  \ ]
\ }
let plugForJavaScriptTypeScriptBrowser = { 'for' : [
    \ 'xml',
    \ 'html',
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
Plug 'tpope/vim-fugitive'
  Plug 'mhinz/vim-startify'
  Plug 'junegunn/gv.vim', { 'on': 'GV' }
Plug 'scrooloose/nerdtree', plugNerdTreeConfig
  Plug 'Xuyuanp/nerdtree-git-plugin', plugNerdTreeConfig
  Plug 'ivalkeen/nerdtree-execute', plugNerdTreeConfig
Plug 'mhinz/vim-signify'
Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'wesQ3/vim-windowswap'

" General
Plug 'kshenoy/vim-signature'
Plug 'yggdroot/indentline', { 'on': 'IndentLinesToggle' }
Plug 'direnv/direnv.vim'
Plug 'tpope/vim-obsession'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'dbakker/vim-projectroot'

" COC Intellisense : Indention indicates Dependency
Plug 'liuchengxu/vista.vim'   " TagBar Alternative
Plug 'Shougo/neoinclude.vim'
Plug 'jsfaint/coc-neoinclude'
Plug 'neoclide/coc.nvim', { 'do': 'yarn install --frozen-lockfile' }

" Editing
Plug 'mileszs/ack.vim'
Plug 'easymotion/vim-easymotion'
Plug 'bkad/CamelCaseMotion'
Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }
Plug 'rhysd/committia.vim', { 'for': [ 'gitcommit' ]}
Plug 'tpope/vim-repeat'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
Plug 'terryma/vim-multiple-cursors'
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
Plug 'sheerun/vim-polyglot'
" Plug 'mechatroner/rainbow_csv', { 'for': ['csv'] }

" Snippets
Plug 'honza/vim-snippets'
Plug 'epilande/vim-es2015-snippets', plugForJavaScriptTypeScript
Plug 'epilande/vim-react-snippets', plugForJavaScriptTypeScript
Plug 'mhartington/vim-angular2-snippets', plugForJavaScriptTypeScriptBrowser
Plug 'markwu/vim-laravel4-snippets', { 'for': 'php' }

" >> Apache
Plug 'vim-scripts/apachelogs.vim', { 'for': 'log' }
Plug 'vim-scripts/apachestyle', { 'for': 'log' }

" >> HTML
Plug 'tpope/vim-ragtag', plugForJavaScriptBrowser

" >> CSS
Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'scss', 'less', 'stylus'] }

" JavaScript / TypeScript
Plug 'jparise/vim-graphql', { 'for': ['gql', 'graphql'] }

" >> JavaScript
Plug 'heavenshell/vim-jsdoc', plugForJavaScriptTypeScript
" Plug 'Quramy/vim-js-pretty-template', plugForJavaScript

" >> Markdown
Plug 'junegunn/goyo.vim', plugForMarkdown
Plug 'ajorgensen/vim-markdown-toc', plugForMarkdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & npm install'  }

" >> PHP
Plug 'tobyS/pdv', { 'for': 'php' }

" >> GoLang
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' }
Plug 'sebdah/vim-delve', { 'for': 'go' }

" Color and Font
Plug 'lifepillar/vim-solarized8'
Plug 'chriskempson/base16-vim'
" Plug 'icymind/NeoSolarized'

Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': 'NERDTreeToggle' }


" Devicons MUST be loaded last
Plug 'ryanoasis/vim-devicons'

" ========================================================================== }}}

call plug#end()
