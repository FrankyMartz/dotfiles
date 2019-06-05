""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim-Plug Configuration
" Author Franky Martinez <frankymartz@gmail.com>
"
" vim:set ft=vim et sw=2 ts=2 tw=80:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-markdown-composer {{{
    function! BuildComposer(info)
        if a:info.status !=? 'unchanged' || a:info.force
            if has('nvim')
                !/usr/bin/env cargo build --release
            else
                !/usr/bin/env cargo build --release --no-default-features --features json-rpc
            endif
        endif
    endfunction
" }}}

" coc-fsharp {{{
    function! BuildCocFsharp(info)
        if executable('dotnet') && (a:info.status ==? 'installed'|| a:info.status ==? 'updated' || a:info.force)
            !/usr/bin/env npm install
            !/usr/bin/env dotnet build -C Release
        endif
    endfunction
" }}}

let installYarnFrozenLockFile = 'yarn install --frozen-lockfile'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.nvim/bundle')
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

" COC Intellisense
Plug 'neoclide/coc.nvim', { 'tag': '*', 'do': './install.sh' }
Plug 'liuchengxu/vista.vim', { 'on': 'Vista' } " View and Search LSP Symbols - TagBar Alternative

" COC Intellisense - Completion
Plug 'Maxattax97/coc-ccls', {'do': installYarnFrozenLockFile}
Plug 'Shougo/neoinclude.vim' | Plug 'jsfaint/coc-neoinclude'
Plug 'iamcco/coc-angular', {'do': installYarnFrozenLockFile}
Plug 'iamcco/coc-svg', {'do': installYarnFrozenLockFile}
Plug 'iamcco/coc-vimlsp', {'do': installYarnFrozenLockFile}
Plug 'josa42/coc-go', {'do': installYarnFrozenLockFile}
Plug 'josa42/coc-lua', {'do': installYarnFrozenLockFile}
Plug 'josa42/coc-sh', {'do': installYarnFrozenLockFile}
Plug 'marlonfan/coc-phpls', {'do': installYarnFrozenLockFile}
Plug 'neoclide/coc-css', {'do': installYarnFrozenLockFile}
Plug 'neoclide/coc-emmet', {'do': installYarnFrozenLockFile}
Plug 'neoclide/coc-highlight', {'do': installYarnFrozenLockFile}
Plug 'neoclide/coc-html', {'do': installYarnFrozenLockFile}
Plug 'neoclide/coc-jest', {'do': installYarnFrozenLockFile}
Plug 'neoclide/coc-json', {'do': installYarnFrozenLockFile}
Plug 'neoclide/coc-python', {'do': installYarnFrozenLockFile}
Plug 'neoclide/coc-rls', {'do': installYarnFrozenLockFile}
Plug 'neoclide/coc-snippets', {'do': installYarnFrozenLockFile}
Plug 'neoclide/coc-tsserver', {'do': installYarnFrozenLockFile}
Plug 'neoclide/coc-vetur', {'do': installYarnFrozenLockFile}
Plug 'neoclide/coc-vimtex', {'do': installYarnFrozenLockFile}
Plug 'neoclide/coc-yaml', {'do': installYarnFrozenLockFile}
Plug 'yatli/coc-fsharp', {'do': function('BuildCocFsharp')}

" Window
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-signify'
Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'wesQ3/vim-windowswap'
Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } | Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' } | Plug 'ivalkeen/nerdtree-execute', { 'on': 'NERDTreeToggle' }

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
Plug 'mtth/scratch.vim', { 'on': [ 'Scratch', 'ScratchInsert', 'ScratchSelection', 'ScratchPreview' ] }
Plug 'vim-scripts/LargeFile'

" Filetype
Plug 'editorconfig/editorconfig-vim'
Plug 'chrisbra/vim-diff-enhanced'
Plug 'w0rp/ale'
Plug 'tpope/vim-dotenv', { 'for': ['env', 'Procfile'] }
Plug 'vim-scripts/SyntaxComplete'
Plug 'sheerun/vim-polyglot'

" Snippets
Plug 'honza/vim-snippets'
Plug 'epilande/vim-es2015-snippets', { 'for': [ 'javascript', 'javascript.jsx', 'es6' ] }
Plug 'epilande/vim-react-snippets', { 'for': [ 'javascript', 'javascript.jsx', 'es6' ] }
Plug 'mhartington/vim-angular2-snippets', { 'for': ['html', 'typeScript', 'ts', 'tsx'] }
Plug 'markwu/vim-laravel4-snippets', { 'for': 'php' }

" >> Apache
Plug 'vim-scripts/apachelogs.vim', { 'for': 'log' }
Plug 'vim-scripts/apachestyle', { 'for': 'log' }

" >> HTML
Plug 'tpope/vim-ragtag', { 'for': ['html', 'xml', 'javascript.jsx'] }

" >> CSS
Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'scss', 'less', 'stylus'] }

" JavaScript / TypeScript
Plug 'jparise/vim-graphql'
Plug 'Quramy/vim-js-pretty-template', { 'for': ['javascript', 'javascript.jsx', 'es6', 'typescript', 'ts', 'tsx'] }

" >> JavaScript
Plug 'othree/yajs.vim', { 'for': ['javascript', 'javascript.jsx', 'es6'] }
Plug 'othree/es.next.syntax.vim', { 'for': ['javascript', 'javascript.jsx', 'es6'] }
Plug 'heavenshell/vim-jsdoc', { 'for': ['javascript', 'javascript.jsx', 'es6', 'typescript', 'ts', 'tsx'] }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'javascript.jsx', 'es6', 'typescript', 'ts', 'tsx'] }
Plug 'Galooshi/vim-import-js', {'for': ['javascript', 'javascript.jsx', 'es6', 'typescript', 'ts', 'tsx']}

" >> TypeScript
Plug 'HerringtonDarkholme/yats.vim', { 'for': ['typescript', 'ts', 'tsx'] }
Plug 'jason0x43/vim-js-indent', { 'for': ['javascript', 'javascript.jsx', 'es6', 'typescript', 'ts', 'tsx'] }

" >> Markdown
Plug 'junegunn/goyo.vim', { 'for': ['markdown', 'md'] }
Plug 'ajorgensen/vim-markdown-toc', { 'for': ['markdown', 'md'] }
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer'), 'for': ['markdown', 'md'] }

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#end()
