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

let plugCocConfig = { 'do': 'yarn install --frozen-lockfile' }
let plugNerdTreeConfig = { 'on': 'NERDTreeToggle' }
let PlugTypeForMarkdown = { 'for': [ 'markdown', 'md' ] }
let plugTypeForJavaScript = { 'for': [
    \ 'javascript',
    \ 'javascript.jsx',
    \ 'es6',
  \ ]
\ }
let plugTypeForJavaScriptBrowser = { 'for' : [
    \ 'xml',
    \ 'html',
    \ 'javascript',
    \ 'javascript.jsx',
    \ 'es6',
  \ ]
\ }
let plugTypeForTypeScript = { 'for': [
    \ 'typescript',
    \ 'ts',
    \ 'tsx',
  \ ]
\ }
let plugTypeForJavaScriptTypeScript = { 'for': [
    \ 'javascript',
    \ 'javascript.jsx',
    \ 'es6',
    \ 'typescript',
    \ 'ts',
    \ 'tsx',
  \ ]
\ }
let plugTypeForJavaScriptTypeScriptBrowser = { 'for' : [
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

" General

Plug 'tpope/vim-dispatch'
Plug 'kshenoy/vim-signature'
Plug 'easymotion/vim-easymotion'
Plug 'yggdroot/indentline', { 'on': 'IndentLinesToggle' } 
Plug 'direnv/direnv.vim'
Plug 'tpope/vim-obsession'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'dbakker/vim-projectroot'

" COC Intellisense : Indention indicates Dependency

Plug 'neoclide/coc.nvim', { 'tag': '*', 'do': './install.sh' }
Plug 'liuchengxu/vista.vim', { 'on': 'Vista' } " TagBar Alternative
Plug 'Maxattax97/coc-ccls', plugCocConfig
Plug 'Shougo/neoinclude.vim' | Plug 'jsfaint/coc-neoinclude', plugCocConfig
Plug 'iamcco/coc-angular', plugCocConfig
Plug 'iamcco/coc-svg', plugCocConfig
Plug 'iamcco/coc-vimlsp', plugCocConfig
Plug 'josa42/coc-go', plugCocConfig
Plug 'josa42/coc-lua', plugCocConfig
Plug 'josa42/coc-sh', plugCocConfig
Plug 'marlonfan/coc-phpls', plugCocConfig
Plug 'neoclide/coc-css', plugCocConfig
Plug 'neoclide/coc-emmet', plugCocConfig
Plug 'neoclide/coc-highlight', plugCocConfig
Plug 'neoclide/coc-html', plugCocConfig
Plug 'neoclide/coc-jest', plugCocConfig
Plug 'neoclide/coc-json', plugCocConfig
Plug 'neoclide/coc-python', plugCocConfig
Plug 'neoclide/coc-rls', plugCocConfig
Plug 'neoclide/coc-snippets', plugCocConfig
Plug 'neoclide/coc-tsserver', plugCocConfig
Plug 'neoclide/coc-vetur', plugCocConfig
Plug 'neoclide/coc-vimtex', plugCocConfig
Plug 'neoclide/coc-yaml', plugCocConfig
Plug 'yatli/coc-fsharp', { 'do': function('BuildCocFsharp') }

" Window
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-signify'
Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'wesQ3/vim-windowswap'
Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree', plugNerdTreeConfig
Plug 'Xuyuanp/nerdtree-git-plugin', plugNerdTreeConfig
Plug 'ivalkeen/nerdtree-execute', plugNerdTreeConfig

" Editing
Plug 'mileszs/ack.vim', { 'on': 'Ack' }
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim', { 'on': 'GV' }
Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }
Plug 'https://github.com/rhysd/committia.vim', { 'for': [ 'gitcommit' ]}
Plug 'tpope/vim-repeat'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-characterize'
Plug 'brooth/far.vim', { 'on': [ 'Far', 'F' ] }
Plug 'matze/vim-move'
Plug 'wellle/targets.vim'
Plug 'https://github.com/reedes/vim-textobj-sentence'
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
Plug 'w0rp/ale'
Plug 'tpope/vim-dotenv', { 'for': ['env', 'Procfile'] }
Plug 'vim-scripts/SyntaxComplete'
Plug 'sheerun/vim-polyglot'

" Snippets
Plug 'honza/vim-snippets'
Plug 'epilande/vim-es2015-snippets', plugTypeForJavaScriptTypeScript
Plug 'epilande/vim-react-snippets', plugTypeForJavaScriptTypeScript
Plug 'mhartington/vim-angular2-snippets', plugTypeForJavaScriptTypeScriptBrowser
Plug 'markwu/vim-laravel4-snippets', { 'for': 'php' }

" >> Apache
Plug 'vim-scripts/apachelogs.vim', { 'for': 'log' }
Plug 'vim-scripts/apachestyle', { 'for': 'log' }

" >> HTML
Plug 'tpope/vim-ragtag', plugTypeForJavaScriptBrowser

" >> CSS
Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'scss', 'less', 'stylus'] }

" JavaScript / TypeScript
Plug 'jparise/vim-graphql'
Plug 'Quramy/vim-js-pretty-template', plugTypeForJavaScriptTypeScript

" >> JavaScript
Plug 'othree/yajs.vim', plugTypeForJavaScript
Plug 'othree/es.next.syntax.vim', plugTypeForJavaScript
Plug 'heavenshell/vim-jsdoc', plugTypeForJavaScriptTypeScript
Plug 'othree/javascript-libraries-syntax.vim', plugTypeForJavaScriptTypeScript

" >> TypeScript
Plug 'HerringtonDarkholme/yats.vim', plugTypeForTypeScript
Plug 'jason0x43/vim-js-indent', plugTypeForJavaScriptTypeScript

" >> Markdown
Plug 'junegunn/goyo.vim', PlugTypeForMarkdown
Plug 'ajorgensen/vim-markdown-toc', PlugTypeForMarkdown
Plug 'euclio/vim-markdown-composer', {
  \ 'do': function('BuildComposer'),
  \ 'for': PlugTypeForMarkdown['for'],
\ }

" >> PHP
Plug 'tobyS/pdv', { 'for': 'php' }

" >> Python
Plug 'jmcantrell/vim-virtualenv'

" >> GoLang
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' }
Plug 'sebdah/vim-delve', { 'for': 'go' }

" Color and Font
Plug 'lifepillar/vim-solarized8'
" Plug 'mhartington/oceanic-next'
Plug 'chriskempson/base16-vim'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': 'NERDTreeToggle' }

" Devicons MUST be loaded last
Plug 'ryanoasis/vim-devicons'

" ========================================================================== }}}

call plug#end()
