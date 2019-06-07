"===============================================================================
" Maintainer Franky Martinez <frankymartz@gmail.com>
" Version 0.1.1
" Note
" To start nvim without using this .nvimrc file, use:
"     nvim -u NORC
"
" To start nvim without loading any .nvimrc or plugins, use:
"     nvim -u NONE
"
" Sections
" => General
" => File and Backup
" => Text, Tab and Indent
" => Helper Functions
" => Mapping
" => Search
" => FileType
" => Window
" => Vundle
" => Color and Font
" => Vundle:Configuration
" => Color Scheme
"
"===============================================================================
"=> General {{{
"-------------------------------------------------------------------------------
set encoding=utf-8
scriptencoding=utf-8
let &shell='/usr/local/bin/zsh --login'

" syntax enable                   " Enable Syntax Highlighting
syntax on                       " Enable Syntax Highlighting–Allow VIM override
set autoread                    " Automatically read externally changes to file
set autowriteall                " Automatically write to file if modified
set history=1000                " Remember more commands and search history
set undolevels=1000             " Use many levels of undo
set undoreload=10000            " Save whole buffer for undo when reloading it
set tabpagemax=50               " Maximum tab pages

" Hide buffers instead of closing them. This means that the current buffer can
" be put into background without being written; and that marks and undo history
" are preserved.
set hidden

set switchbuf=useopen           " Jump to specified buffer when jumping buffers

" Makes extra key combinations possible
let mapleader=','
let maplocalleader=','

" GUI nvim
set guioptions-=T
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

if has('mouse') | set mouse=a | endif

set cursorline                  " Show me my position I'm blind
set nocursorbind                " Prevent scroll bind (2 windows w/ same buffer)
set modelines=0                 " Prevent security exploit. Disable
set showcmd                     " Show (partial) command at bottom of buffer
set title                       " Set window title
set scrolloff=3                 " Number of lines to keep above/below cursor
set ruler                       " Show line/column position number
set number                      " Show line number in front of each line
set cmdheight=1                 " Set command bar to 2 lines

" Timeout on key codes but not mappings. Make terminal nvim work sanely
set notimeout
set ttimeout
set ttimeoutlen=10

set lazyredraw
set visualbell                  " NO bell please
set noerrorbells                " Silence

set splitbelow                  " Horizontal split below current.
set splitright                  " Vertical split to right of current.

" Enable tab completion for files/buffers
set wildmenu
set wildmode=list:longest
set wildignore+=.hg,.git,.svn                       " Version control
set wildignore+=*.aux,*.out,*.toc                   " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg      " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest    " compiled object files
set wildignore+=*.spl                               " compiled spelling word lists
set wildignore+=*.sw?                               " Vim swap files
set wildignore+=*.DS_Store                          " OSX
set wildignore+=*.luac                              " Lua byte code
set wildignore+=migrations                          " Django migrations
set wildignore+=*.pyc                               " Python byte code
set wildignore+=*.orig                              " Merge resolution files

set backspace=indent,eol,start  " Allow backspace over everything in insert mode

set cpoptions+=d    " Use tags relative to CWD

" Always use system clipboard for ALL operations
"set clipboard+=unnamedplus

let g:python_host_prog='/usr/local/bin/python2'
let g:python3_host_prog='/usr/local/bin/python3'

let g:node_host_prog='/usr/local/lib/node_modules/neovim/bin/cli.js'

" Enable Project Based Configuration
set exrc
set secure

"-------------------------------------------------------------------------------
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" => File and Backup {{{
"-------------------------------------------------------------------------------
set termencoding=utf-8          " Encoding used for the terminal
set fileformats=unix
set fileformat=unix

set undofile
set backup                              " Enable Backups
"set noswapfile                          " It's 2014 NeoVim
set backupskip=/tmp/*,/private/tmp/*
set undodir=~/.nvim/tmp/undo//          " Undo files
set backupdir=~/.nvim/tmp/backup//      " Backup files
set viewdir=~/.nvim/tmp/view//          " View files
set directory=~/.nvim/tmp/swap//        " Swap files
set tags=./tags,tags

" Create directories if they do not exist
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), 'p')
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), 'p')
endif
if !isdirectory(expand(&viewdir))
    call mkdir(expand(&viewdir), 'p')
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), 'p')
endif

let tempDir='~/.nvim/tmp//'

"-------------------------------------------------------------------------------
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" => Text, Tab and Indent {{{
"-------------------------------------------------------------------------------
set formatoptions=qrn1j         " Pasted Content Handling
set autoindent                  " Always set autoindenting on
set smartindent                 " Smart autoindenting when starting on newline
set shiftround                  " Round indent to multiple of 'shiftwidth'
set nowrap                      " Don't wrap text to textwidth
set textwidth=80                " Max width of text to be inserted
set tabstop=4                   " Number of spaces a <tab> equals
set wrapmargin=0
set shiftwidth=4
set softtabstop=4
set expandtab
set conceallevel=1              " Enable Code Conceal
set concealcursor="nc"          " Show concealed chars in cursorline

set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮

"-------------------------------------------------------------------------------
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" => Mapping {{{
"-------------------------------------------------------------------------------

" Navigation - Buffer
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" Buffer Horizontal Navigation
nnoremap <ScrollWheelLeft> 20zh
nnoremap <ScrollWheelRigth> 20zl
imap <ScrollWheelLeft> <Left>
imap <ScrollWheelRight> <Right>
nnoremap <M-h> 20zh
nnoremap <M-l> 20zl

" Switch (previous,next) Buffer
nmap <leader>kk :bnext<CR>
nmap <leader>jj :bprevious<CR>
nmap <leader>hh :tabprevious<CR>
nmap <leader>ll :tabnext<CR>

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Sudo to write (handle permission-denied error)
cnoremap w!! w !sudo tee % >/dev/null
" Open .nvimrc file
nnoremap <leader>ev <c-w><c-v><c-l>:e $MYVIMRC<cr>

" Insert Mode Magic
" -> quick escape
inoremap jj <esc>
" -> move cursor to beginning
inoremap II <esc>I
" -> move cursor to eol
inoremap AA <esc>A
" -> make newline above and place cursor there
inoremap OO <esc>O
" -> clear row and place cursor inline
inoremap CC <esc>cc

" Easy Single Line Indent
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Split Buffers
nnoremap <c-s> <c-w>s
nnoremap <c-a-s> <c-w>v
nnoremap <c-q> <c-w>q

" Resize Window
" Window (Buffer) Height
nnoremap <silent> <Leader>+ :exe "resize +" . (winheight(0) * 1/8)<CR>
nnoremap <silent> <Leader>_ :exe "resize -" . (winheight(0) * 1/8)<CR>
" Window (BUffer) Width
nnoremap <silent> <Leader>= :exe "vertical resize +" . (winwidth(0) * 1/8)<CR>
nnoremap <silent> <Leader>- :exe "vertical resize -" . (winwidth(0) * 1/8)<CR>

" Clear Search Results
nnoremap <leader><space> :noh<cr>

" Strip all trailing whitespace in current buffer
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<cr>

" Terminal Commands
if exists(':tnoremap')  " Neovim
    tnoremap <Leader>e <C-\><C-n>
endif

"-------------------------------------------------------------------------------
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" => Search {{{
"-------------------------------------------------------------------------------
set ignorecase              " Ignore case when searching
set smartcase               " Make case-sensitive if has uppercase char
set incsearch               " Show search as you type
set hlsearch                " Highlight search items
set gdefault                " Search/Replace 'globally' (on line) by default
set showmatch               " Highlight closing ), >, }, ], etc...
" Use Sane Regexes
nnoremap / /\v
vnoremap / /\v

set runtimepath+=/usr/local/opt/fzf

"-------------------------------------------------------------------------------
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" => FileType {{{
"-------------------------------------------------------------------------------

" Blade {{{
augroup ft_blade
    au!
    au FileType blade setlocal ts=2 sts=2 sw=2 expandtab
    au BufNewFile,BufRead *.blade setlocal filetype=blade
augroup END
" }}}

" C {{{
augroup ft_c
    au!
    au FileType c setlocal foldmethod=marker foldmarker={,}
augroup END
" }}}

" CoffeeScript {{{
augroup ft_coffee
    au!
    au BufNewFile,BufRead *.coffee setlocal filetype=coffee
    au BufNewFile,BufRead *.js.coffee setlocal filetype=coffee
    au FileType coffee setlocal ts=2 sts=2 sw=2 expandtab
augroup END
" }}}

" CSS, SASS, Stylus, LESS  {{{
augroup ft_css
    au!
    au FileType css,scss,sass,less,stylus setlocal ts=4 sts=4 sw=4 noexpandtab
    au BufNewFile,BufRead *.css setlocal filetype=css
    au BufNewFile,BufRead *.scss setlocal filetype=scss
    au BufNewFile,BufRead *.sass setlocal filetype=sass
    au BufNewFile,BufRead *.less setlocal filetype=less
    au BufNewFile,BufRead *.styl setlocal filetype=stylus
    " au FileType css set omnifunc=csscomplete#CompleteCSS

    au FileType scss,sass,less,css setlocal foldmethod=marker foldmarker={,}
    " Make {<cr> insert a pair of brackets in such a way that the cursor is
    " correctly positioned inside of them AND the following code doesn't get
    " unfolded.
    au BufNewFile,BufRead *.less,*.css inoremap <buffer> {<cr> }<left><cr><space><space><space><space>.<cr><esc>kA<bs>}
augroup END
" }}}

" Django {{{
augroup ft_django
    au!
    au BufNewFile,BufRead urls.py           setlocal nowrap
    au BufNewFile,BufRead dashboard.py      normal! zR
    au BufNewFile,BufRead local_settings.py normal! zR

    au BufNewFile,BufRead admin.py     setlocal filetype=python.django
    au BufNewFile,BufRead urls.py      setlocal filetype=python.django
    au BufNewFile,BufRead models.py    setlocal filetype=python.django
    au BufNewFile,BufRead views.py     setlocal filetype=python.django
    au BufNewFile,BufRead settings.py  setlocal filetype=python.django
    au BufNewFile,BufRead settings.py  setlocal foldmethod=marker
    au BufNewFile,BufRead forms.py     setlocal filetype=python.django
    au BufNewFile,BufRead common_settings.py  setlocal filetype=python.django
    au BufNewFile,BufRead common_settings.py  setlocal foldmethod=marker
augroup END
" }}}

" Git {{{
augroup ft_git
    au!
    au FileType gitcommit setlocal tw=72 cc=72 spell
augroup END
" }}}

" GO-Lang {{{
augroup ft_go
    au!
    au BufRead,BufNewFile *.go setlocal filetype=go
augroup END
" }}}

" Handlebars {{{
augroup ft_handlebars
    au!
    au BufNewFile,BufRead *.handlebars setlocal filetype=handlebars
    au BufNewFile,BufRead *.hbs setlocal filetype=handlebars
    au FileType handlebars setlocal ts=2 sts=2 sw=2 expandtab
augroup END
" }}}

" HTML {{{
augroup ft_html
    au!
    au FileType html setlocal ts=2 sts=2 sw=2 expandtab
    au FileType html setlocal foldmethod=syntax
augroup END
" }}}

" Jade {{{
augroup ft_jade
    au!
    au FileType jade setlocal ts=2 sts=2 sw=2 expandtab
augroup END
" }}}

" JavaScript {{{
augroup ft_javascript
    au!
    au FileType javascript setlocal ts=2 sts=2 sw=2 cocu="" expandtab
    au BufNewFile,BufRead *.js setlocal filetype=javascript.jsx
    au BufNewFile,BufRead *.jsx setlocal filetype=javascript.jsx
    au BufNewFile,BufRead *.es6 setlocal filetype=javascript.jsx
    au BufNewFile,BufRead *.spec.js setlocal filetype=javascript.spec
    au FileType javascript setlocal foldmethod=syntax
    " au FileType javascript setlocal foldmethod=marker foldmarker={,}
    " au FileType javascript inoremap <buffer> {<cr> {}<left><cr><space><space><space><space>.<cr><esc>kA<bs>
    au FileType javascript set omnifunc=javascriptcomplete#CompleteJS
augroup END
" }}}

" JSON {{{
augroup ft_json
    au!
    au BufNewFile,BufRead *.json setlocal filetype=json
    au BufNewFile,BufRead *.jsonp setlocal filetype=json
    au FileType json setlocal ts=2 sts=2 sw=2 expandtab
    au FileType json setlocal foldmethod=marker foldmarker={,}
augroup END
" }}}

" Markdown {{{
augroup ft_markdown
    au!
    au BufNewFile,BufRead *.md setlocal filetype=markdown
    au BufNewFile,BufRead *.markdown setlocal filetype=markdown
    au FileType markdown setlocal wrap linebreak nolist
augroup END
" }}}

" Mustache {{{
augroup ft_mustache
    au!
    au FileType mustache setlocal ts=2 sts=2 sw=2 expandtab
    au BufNewFile,BufRead *.mustache setlocal filetype=mustache
augroup END
" }}}

" Nginx {{{
augroup ft_nginx
    au!
    au BufRead,BufNewFile /etc/nginx/conf/*                      set ft=nginx
    au BufRead,BufNewFile /etc/nginx/sites-available/*           set ft=nginx
    au BufRead,BufNewFile /usr/local/etc/nginx/sites-available/* set ft=nginx
    au BufRead,BufNewFile vhost.nginx                            set ft=nginx
    au FileType nginx setlocal foldmethod=marker foldmarker={,}
augroup END
" }}}

" PHP {{{
augroup ft_php
    au!
    au BufNewFile,BufRead *.php setlocal filetype=php
    au FileType php setlocal ts=4 sts=4 sw=4 smartindent expandtab
augroup END
" }}}

" Puppet {{{
augroup ft_puppet
    au!
    au FileType puppet setlocal foldmethod=marker foldmarker={,}
augroup END
" }}}

" Python {{{
augroup ft_python
    au!
    au FileType python setlocal ts=4 sts=4 sw=4 expandtab
    au FileType python setlocal define=^\s*\\(def\\\\|class\\)
    au FileType man nnoremap <buffer> <cr> :q<cr>
    au FileType python if exists("python_space_error_highlight") | unlet python_space_error_highlight | endif
    au FileType python iabbrev <buffer> afo assert False, 'Okay'
augroup END
" }}}

" Ruby {{{
augroup ft_ruby
    au!
    au BufRead,BufNewFile Capfile setlocal filetype=ruby
    au FileType ruby,pml,erb,haml setlocal ts=2 sts=2 sw=2 expandtab
    au FileType ruby setlocal foldmethod=syntax
augroup END
" }}}

" TypeScript {{{
augroup ft_typescript
    au!
    au FileType typescript setlocal ts=2 sts=2 sw=2 cocu="" expandtab
    au BufRead,BufNewFile *.ts setlocal filetype=typescript
    au BufRead,BufNewFile *.tsx setlocal filetype=typescript
    au FileType typescript setlocal foldmethod=syntax
augroup END
" }}}

" SQL {{{
augroup ft_sql
    au!
    au BufNewFile,BufRead *.sql setlocal filetype=sql
    au FileType sql setlocal foldmethod=indent
    au FileType sql setlocal ts=2 sts=2 sw=2
    au FileType sql setlocal commentstring=--\ %s comments=:--
augroup END
" }}}

" Vagrant {{{
augroup ft_vagrant
    au!
    au BufNewFile,BufRead Vagrantfile setlocal filetype=ruby
augroup END
" }}}

" Vim {{{
augroup ft_vim
    au!
    au FileType vim setlocal foldmethod=marker
    au FileType help setlocal textwidth=78
    au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END
" }}}

" YAML {{{
augroup ft_yaml
    au!
    au FileType yaml set sw=2
augroup END
" }}}

" XML {{{
augroup ft_xml
    au!
    au BufNewFile,BufRead *.rss setlocal filetype=xml
    au FileType xml setlocal foldmethod=manual
augroup END
" }}}

" VIMRC {{{
augroup ft_vimrc
    au!
    " Disable Line Numbers in Terminal
    au TermOpen * setlocal nonumber norelativenumber
    " Save when losing focus
    au FocusLost * :silent! wa
    au BufEnter * :syntax sync fromstart
    " Prevent Location List color column and numbers
    au FileType qf setlocal nonumber colorcolumn=
    au BufReadPre * setlocal foldmethod=indent
    " Automatically save folding
    au BufWinLeave * silent! mkview
    au BufWinEnter * silent! loadview
    au WinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
    " Make Neovim return to same line on file reopen
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \       execute 'normal! g`"zvzz' |
        \ endif
augroup END
" }}}

"-------------------------------------------------------------------------------
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" => Window {{{
"-------------------------------------------------------------------------------
set winheight=5
set winminheight=5

set diffopt+=vertical
set diffopt+=iwhite

set nofoldenable    " Expand folds by default
set foldcolumn=0    " Hide fold depth info from gutter

function! SetScrollBind(isBound)
    if a:isBound
        execute 'set scrollbind'
        execute 'set cursorbind'
    else
        execute 'set noscrollbind'
        execute 'set nocursorbind'
    endif
endfunction

noremap <silent>[og :call SetScrollBind(1)<CR>
noremap <silent>]og :call SetScrollBind(0)<CR>

"-------------------------------------------------------------------------------
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" => Plug-Vim {{{
"-------------------------------------------------------------------------------

augroup plug_vim
    au!
    if empty(glob('~/.nvim/autoload/plug.vim'))
        silent !curl -fLo ~/.nvim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        au!
        autocmd VimEnter * PlugInstall
    endif
augroup END

source ~/.config/nvim/vimplugrc.vim

"-------------------------------------------------------------------------------
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" => Color and Font {{{
"-------------------------------------------------------------------------------

if has('termguicolors')
    set termguicolors               " Set True Colors in Terminal
else
    let base16colorspace=256        " Access colors present in 256 colorspace
endif

set synmaxcol=0                 " Don't highlight lines longer than
set colorcolumn=80              " Column number to highlight

"-------------------------------------------------------------------------------
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" => Plug:Configuration {{{
"-------------------------------------------------------------------------------

" Ack {{{
    if executable('rg')
    let g:ackprg = 'rg --vimgrep'
    elseif executable('ag')
        let g:ackprg = 'ag --vimgrep'
    endif
    let g:ack_use_dispatch = 1
    command Todo Ack! 'TODO\|FIXME'
"  }}}

" Airline {{{
    set laststatus=2        " Always display the statusline in all windows
    set noshowmode          " Hide default mode text
    let g:airline_detect_modified=1
    let g:airline_detect_paste=1
    let g:airline_detect_crypt=1
    let g:airline_detect_spell=1
    let g:airline_detect_spelllang=1
    let g:airline_inactive_collapse=1
    let g:airline_skip_empty_sections=1
    let g:airline_highlighting_cache=1
    let g:airline_powerline_fonts=1
    let g:airline_exclude_preview=1
    let g:airline#extensions#default#section_truncate_width = {
        \ 'b': 140,
        \ 'x': 140,
    \ }
    let g:airline#extensions#tabline#ignore_bufadd_pat = 'gundo|undotree|vimfiler|tagbar|nerd_tree|startify'

    " Airline : Ale ============================================================
    let g:airline#extensions#ale#enabled=1

    " Airline : Coc ============================================================
    let g:airline#extensions#coc#enabled = 1
    let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
    let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

    " Airline : CtrlSpace ======================================================
    let g:CtrlSpaceUseTabline=0
    let g:airline#extensions#ctrlspace#enabled=1
    let g:airline#extensions#ctrlp#show_adjacent_modes = 1
    let g:CtrlSpaceStatuslineFunction='airline#extensions#ctrlspace#statusline()'

    " Airline : CursorMode =====================================================
    let g:airline#extensions#cursormode#enabled = 1

    " Airline : Fugitive =======================================================
    let g:airline#extensions#fugitiveline#enabled = 1

    " Airline : Git ============================================================
    let g:airline#extensions#branch#enabled = 1
    let g:airline#extensions#branch#format=1
    let g:airline#extensions#branch#empty_message = ''
    let g:airline#extensions#branch#sha1_len = 10
    let g:airline#extensions#branch#displayed_head_limit = 10

    " Airline : Gutentags ======================================================
    let g:airline#extensions#gutentags#enabled = 1

    " Airline : Hunks ==========================================================
    let g:airline#extensions#hunks#enabled = 1
    let g:airline#extensions#hunks#non_zero_only = 0

    " Airline : Signify ========================================================
    let g:airline#extensions#hunks#enabled=1
    let g:airline#extensions#hunks#non_zero_only=0
    let g:airline#extensions#hunks#hunk_symbols=['+', '~', '-']

    " Airline : TabLine ========================================================
    let g:airline#extensions#tabline#enabled=1  " Automatically displays all buffers
    let g:airline#extensions#tabline#buffers_label = 'buffer'
    let g:airline#extensions#tabline#tabs_label = 'tab'
    let g:airline#extensions#tabline#current_first = 1
    let g:airline#extensions#tabline#show_tabs = 1
    let g:airline#extensions#tabline#show_splits = 1
    let g:airline#extensions#tabline#buffer_min_count=1
    let g:airline#extensions#tabline#fnamecollapse = 1
    let g:airline#extensions#tabline#formatter='unique_tail'

    " Airline : VirtualEnv =====================================================
    let g:airline#extensions#virtualenv#enabled = 1

    " Airline : Vista ==========================================================
    function! NearestMethodOrFunction() abort
        return get(b:, 'vista_nearest_method_or_function', '')
    endfunction
    let g:airline_section_y = airline#section#create_right(['vista','NearestMethodOrFunction()'])


    " Airline : WhiteSpace =====================================================
    let g:airline#extensions#whitespace#enabled=1
    let g:airline#extensions#whitespace#checks=[ 'indent', 'trailing', 'long', 'mixed-indent-file' ]
    let g:airline#extensions#whitespace#max_lines=20000
    let g:airline#extensions#whitespace#show_message=1
    let g:airline#extensions#whitespace#trailing_format='trailing[%s]'
    let g:airline#extensions#whitespace#mixed_indent_format='mixed-indent[%s]'
    let g:airline#extensions#whitespace#long_format='long[%s]'
    let g:airline#extensions#whitespace#mixed_indent_file_format='mix-indent-file[%s]'
    let airline#extensions#c_like_langs=['c', 'cpp', 'cuda', 'go', 'javascript', 'typescript', 'ld', 'php']

    " Airline : WindowSwap =====================================================
    let g:airline#extensions#windowswap#indicator_text='WS'
" }}}

" Ale {{{
    let g:ale_set_highlights = 1
    let b:ale_set_balloons = 1
    let g:ale_cache_executable_check_failures = 1
    let g:ale_cursor_detail = 0
    let g:ale_lint_delay = 200
    let g:ale_lint_on_enter = 1
    let g:ale_lint_on_filetype_changed = 1
    let g:ale_lint_on_text_changed = 'normal'
    let g:ale_lint_on_insert_leave = 1
    let g:ale_open_list = 'on_save'
    let g:ale_keep_list_window_open = 0
    let g:ale_linters = {
        \ 'typescript': ['tsserver', 'tslint', 'typecheck'],
        \ 'javascript': ['standard'],
        \ 'go': ['gometalinter', 'gofmt'],
        \ 'html': [],
    \ }
    let g:ale_fix_on_save = 0
    let g:ale_fixers = {
        \ 'typescript': ['tslint'],
        \ 'javascript': ['standard'],
        \ 'html': [],
    \ }
    let g:ale_go_gometalinter_options = '--fast'
    let g:ale_javascript_eslint_options = '--no-color'
    let g:ale_sign_error = '✘'
    let g:ale_sign_warning = ''
    let g:ale_typescript_tslint_executable = '/usr/loca/bin/tslint'
    let g:ale_typescript_tsserver_executable = '/usr/local/bin/tsserver'
    let g:ale_typescript_tsserver_use_global = 1

    let g:ale_virtualtext_cursor = 1
    let g:ale_virtualtext_prefix = '  ' " ⌫ ﱥ                 

    nmap <leader>ek <Plug>(ale_previous)
    nmap <leader>ej <Plug>(ale_next)

    augroup plug_ale
        autocmd!
        autocmd QuitPre * if empty(&buftype) | lclose | endif
        " autocmd BufWinLeave * silent! lclose
    augroup END
"  }}}

" Coc {{{
    let g:coc_node_path = '/usr/local/bin/node'
    function! s:check_back_space() abort
        let columnPosition = col('.') - 1
        return !columnPosition || getline('.')[columnPosition - 1]  =~# '\s'
    endfunction

    inoremap <expr><TAB> pumvisible() ? '<C-n>' : '<TAB>'
    inoremap <expr><S-TAB> pumvisible() ? '<C-p>' : '<S-TAB>'

    " Use `[c` and `]c` to navigate diagnostics
    nmap <silent> [c <Plug>(coc-diagnostic-prev)
    nmap <silent> ]c <Plug>(coc-diagnostic-next)

    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Coc : coc-snippets =======================================================
    let g:coc_snippet_next = '<TAB>'
    let g:coc_snippet_prev = '<S-TAB>'
    inoremap <silent><expr> <CR>
        \ pumvisible() ? coc#_select_confirm() :
        \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
        \ <SID>check_back_space() ? "\<CR>" : coc#refresh()."\<CR>"

    augroup plug_coc
        au!
        au! CompleteDone * if pumvisible() == 0 | pclose | endif
    augroup END
" }}}

" DelimitMate {{{
    let delimitMate_no_esc_mapping=1    " Esc Issue Fix
" }}}

" EditorConfig {{{
    let g:EditorConfig_exclude_patterns = ['fugitive://.*']
" }}}

" Far {{{
    let g:far#source = 'rgnvim'
" }}}

" Fugitive {{{
    nnoremap <leader>? :Gstatus<cr>
" }}}

" FZF {{{
    if has('nvim')
        nmap <c-t> :FZF<cr>
        let g:fzf_history_dir = '~/.nvim/tmp/fzf-history//'
        let g:fzf_colors = {
            \ 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment']
        \ }
    endif
" }}}

" Goyo {{{
    function! s:goyo_enter()
        set noshowmode
        set scrolloff=999
    endfunction

    function! s:goyo_leave()
        set showmode
        set scrolloff=5
    endfunction

    augroup plug_goyo
        au!
        au! User GoyoEnter nested call <SID>goyo_enter()
        au! User GoyoLeave nested call <SID>goyo_leave()
    augroup END
" }}}

" Gundo {{{
    nnoremap <F7> :MundoToggle<CR>
" }}}

" indentLine {{{
    let g:indentLine_enabled = 1
    let g:indentLine_char = '¦'
    let g:indentLine_first_char = '¦'
    let g:indentLine_setConceal = 1
    let g:indentLine_setColors=0
    let g:indentLine_showFirstIndentLevel = 1
    nnoremap <leader>ti :IndentLinesToggle<CR>
" }}}

" javascript-libraries-syntax {{{
    let g:used_javascript_libs = join([
        \ 'angularjs',
        \ 'angularui',
        \ 'angularuirouter',
        \ 'backbone',
        \ 'chai',
        \ 'd3',
        \ 'flux',
        \ 'handlebars',
        \ 'jasmine',
        \ 'jquery',
        \ 'prelude',
        \ 'ramda',
        \ 'react',
        \ 'requirejs',
        \ 'sugar',
        \ 'underscore',
        \ 'vue'
    \ ], ',')
" }}}

" NERDCommenter {{{
    " Add spaces after comment delimiters by default
    let g:NERDSpaceDelims = 1

    " Use compact syntax for prettified multi-line comments
    let g:NERDCompactSexyComs = 1

    " Align line-wise comment delimiters flush left instead of following code indentation
    " let g:NERDDefaultAlign = 'left'

    " Set a language to use its alternate delimiters by default
    let g:NERDAltDelims_java = 1

    " Allow commenting and inverting empty lines (useful when commenting a region)
    let g:NERDCommentEmptyLines = 1

    " Enable trimming of trailing whitespace when uncommenting
    let g:NERDTrimTrailingWhitespace = 1

    " Enable NERDCommenterToggle to check all selected lines is commented or not 
    let g:NERDToggleCheckAllLines = 1
" }}}

" NERDTree {{{
    augroup plug_nerdtree
        " Quit when NERDTree is only open buffer
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    augroup END
    nmap <F8> :NERDTreeToggle<CR>
    let NERDTreeAutoDeleteBuffer=1
    let NERDTreeBookmarksFile=expand(tempDir).'/NERDTreeBookmarks'
    let NERDTreeCascadeSingleChildDir=0
    let NERDTreeChDirMode=2
    let NERDTreeHijackNetrw=0 " Startify Session Patch
    let NERDTreeMinimalUI=1
    let NERDTreeMouseMode=2
    let NERDTreeNaturalSort=1
    let NERDTreeHighlightCursorline=1
    let NERDTreeIgnore = [
        \ '\~$', '.*\.pyc$', 'pip-log\.txt$', 'whoosh_index', 'xapian_index',
        \ '.*.pid', 'monitor.py', '.DS_Store', '.*-fixtures-.*.json', '.*\.o$',
        \ 'db.db', 'tags', 'tags.bak', '.*\.pdf$', '.*\.mid$', '.*\.midi$',
        \ 'GPATH', 'GRTAGS', 'GTAGS'
    \ ]
" }}}

" NERDTree Commentor {{{
    let NERDMenuMode=0
    let NERDSpaceDelims=1
" }}}

" NERDTree Git Plugin {{{
    let g:NERDTreeIndicatorMapCustom = {
        \ 'Modified'  : '',
        \ 'Staged'    : '',
        \ 'Untracked' : '',
        \ 'Renamed'   : '',
        \ 'Unmerged'  : '',
        \ 'Deleted'   : '',
        \ 'Dirty'     : '',
        \ 'Clean'     : '',
        \ 'Ignored'   : ' ',
        \ 'Unknown'   : ''
    \ }
" }}}

" Scratch {{{
    function! ToggleScratchBuffer(scratchType)
        let scr_open = bufwinnr('__Scratch__')
        if scr_open != -1
            execute scr_open . 'close'
        elseif  a:scratchType ==? 'insert-clear'
            execute 'ScratchInsert!'
        elseif a:scratchType ==? 'select-reuse'
            execute 'ScratchSelection'
        elseif a:scratchType ==? 'select-clear'
            execute 'ScratchSelection!'
        else " insert-reuse
            execute 'ScratchInsert'
        endif
    endfunction

    let g:scratch_no_mappings = 1
    let g:scratch_autohide = 0
    let g:scratch_insert_autohide = 0  
    let g:scratch_filetype = 'markdown'
    nnoremap <F12> :call ToggleScratchBuffer('insert-reuse')<CR>
    nnoremap <F24> :call ToggleScratchBuffer('insert-clear')<CR>
    vnoremap <F12> :call ToggleScratchBuffer('select-reuse')<CR>
    vnoremap <F24> :call ToggleScratchBuffer('select-clear')<CR>

    function! s:set_scratch_path()
        let repoRoot = projectroot#guess()
        if isdirectory(repoRoot . '/.git')
            let scratchPath = repoRoot . '/.git/scratch.md'
            let g:scratch_persistence_file = repoRoot . '/.git/scratch.md'
        endif
    endfunction

    augroup plug_scratch
        au VimEnter * call s:set_scratch_path()
    augroup END
" }}}

" Surround {{{
    let g:surround_{char2nr('-')} = '<% \r %>'
    let g:surround_{char2nr('=')} = '<%= \r %>'
    let g:surround_{char2nr('8')} = '/* \r */'
    let g:surround_{char2nr('s')} = ' \r '
    let g:surround_{char2nr('^')} = '/^\r$/'
    let g:surround_indent = 1
" }}}

" VimDevIcon {{{
    let g:webdevicons_enable = 1
    let g:webdevicons_enable_vimfiler  =  1
    let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
    let g:WebDevIconsUnicodeDecorateFolderNodes = 1
    let g:DevIconsEnableFoldersOpenClose = 1
    let g:DevIconsEnableFolderPatternMatching = 1
    let g:DevIconsEnableFolderExtensionPatternMatching = 0
    let g:WebDevIconsUnicodeDecorateFolderNodesExactMatches = 1

    let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols = {} " needed
    " let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['node_modules'] = '' "      ﯵ
    let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['\%(.*\.\)*spec\.\%(ts\|js\|es6\|jsx\)$'] = '' "  
    let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['\%(.*\.\)*module\.\%(ts\|js\|es6\|jsx\)$'] = ' '
    let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['\%(.*\.\)*service\.\%(ts\|js\|es6\|jsx\)$'] = 'ﰩ'
    let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['\%(.*\.\)*component\.\%(ts\|js\|es6\|jsx\)$']=''
    let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['\%(.*\.\)\+d\.\%(ts\|js\|es6\|jsx\)$'] = ''
    let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['\%(.*\.\)*data\.\%(ts\|js\|es6\|jsx\)$'] = ''

    let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*\.csv$'] = ''
    let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*\.tsv$'] = ''
    "    簾               ﰩ    
    "    ﯤ          

    let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['package\%(-lock\)\?\.json'] = ''
    " TODO: Validate REGEX in Assignment
    let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['tsconfig\%(\..*\)\?\.json'] = ''
    let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['\%(tslint\|eslint\)\?\.json'] = ''

    let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*\.js\%(\..\+\)\?\.map$'] = '慎'

    " vimDevIcon: NERDTree
    let g:webdevicons_enable_nerdtree = 1
    let g:webdevicons_conceal_nerdtree_brackets = 1
    let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
    let g:WebDevIconsNerdTreeBeforeGlyphPadding = ''
    let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
    " vimDevIcon: Airline
    let g:webdevicons_enable_airline_tabline = 1
    let g:webdevicons_enable_airline_statusline = 1
    " vimDevIcon: CtrlP
    let g:webdevicons_enable_ctrlp = 1
    let g:webdevicons_enable_flagship_statusline = 1
" }}}

" vim-delve {{{
    let g:delve_backend = 'native'
    let s:aDelveCachePath='~/.nvim/tmp/vim-delve//'
    if !isdirectory(expand(s:aDelveCachePath))
        call mkdir(expand(s:aDelveCachePath), 'p')
    endif
    let g:delve_cache_path = expand(s:aDelveCachePath)
" }}}

" vim-diff-enhanced {{{
    if &diff
        let &diffexpr='EnhancedDiff#Diff("git diff", \"--diff-algorithm=patience")'
        " let &diffexpr='EnhancedDiff#Diff("git diff", '--diff-algorithm=histogram')'
    endif
" }}}

" vim-ctrlspace {{{
    let s:aCtrlSpaceCacheDir='~/.nvim/tmp/ctrlspacecache/'
    if !isdirectory(expand(s:aCtrlSpaceCacheDir))
        call mkdir(expand(s:aCtrlSpaceCacheDir), 'p')
    endif
    let g:CtrlSpaceCacheDir = expand(s:aCtrlSpaceCacheDir)
    let g:CtrlSpaceDefaultMappingKey = '<c-space> '
    let g:CtrlSpaceUseArrowsInTerm = 1
    let g:CtrlSpaceUseMouseAndArrowsInTerm=1
    let g:CtrlSpaceLoadLastWorkspaceOnStart=0
    let g:CtrlSpaceSaveWorkspaceOnSwitch=1
    let g:CtrlSpaceSaveWorkspaceOnExit=1
    let g:CtrlSpaceHeight = 10
    if executable('rg')
        let g:CtrlSpaceGlobCommand = 'rg --hidden --vimgrep --files'
    elseif executable('ag')
        let g:CtrlSpaceGlobCommand = '/usr/bin/env ag -l --hidden --vimgrep -g ""'
    endif
    let g:CtrlSpaceCacheDir = expand(tempDir).'/ctrlspacecache'
" }}}

" vim-go {{{
    " Setting
    let g:go_test_show_name = 1
    let g:go_autodetect_gopath = 1
    let g:go_fmt_command = 'goimports'
    let g:go_term_mode = 'split'
    let g:go_textobj_include_function_doc = 1
    " Syntax Highlight
    let g:go_highlight_types = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_functions = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_extra_types = 1
    let g:go_highlight_generate_tags = 1
    let g:go_highlight_build_constraints = 1
    let g:go_highlight_variable_assignments = 1
    let g:go_highlight_variable_declarations = 1

    let g:go_highlight_space_tab_error = 1
    let g:go_highlight_chan_whitespace_error = 1
    let g:go_highlight_array_whitespace_error = 1
    " Shortcuts
    if isdirectory(expand('$GOPATH/src/github.com/golang/lint/misc/vim'))
        set runtimepath+=$GOPATH/src/github.com/golang/lint/misc/vim
    endif
    " run :GoBuild or :GoTestCompile based on the go file
    function! s:build_go_files()
    let l:file = expand('%')
    if l:file =~# '^\f\+_test\.go$'
        call go#test#Test(0, 1)
    elseif l:file =~# '^\f\+\.go$'
        call go#cmd#Build(0)
    endif
    endfunction

    augroup plug_go
        au!
        au FileType go nmap <leader>r <Plug>(go-run)
        au FileType go nmap <leader>t <Plug>(go-test)
        au FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
        au FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
    augroup END
" }}}

" vim-gutentags {{{
    let g:gutentags_enabled = 1
    let g:gutentags_modules = ['ctags']
    let g:gutentags_resolve_symlinks = 1
    let g:gutentags_define_advanced_commands = 1
    let g:gutentags_project_root = ['.root']
    let g:gutentags_ctags_executable_javascript = 'ctags'
    let g:gutentags_ctags_executable_typescript = 'tstags'
    let g:gutentags_ctags_exclude = ['*\.ts']
    if &diff
        let g:gutentags_enabled = 0
    endif
    augroup plug_gutentags
        au!
        au FileType gitcommit,gitrebase,startify let g:gutentags_enabled=0
    augroup END
" }}}

" vim-javascript {{{
    let g:javascript_plugin_jsdoc = 1
    let g:javascript_plugin_ngdoc = 1
    let g:javascript_plugin_flow = 1
    let g:javascript_conceal_function             = 'ƒ'
    let g:javascript_conceal_null                 = 'ø'
    let g:javascript_conceal_this                 = '@'
    let g:javascript_conceal_return               = '⇚'
    let g:javascript_conceal_undefined            = '¿'
    let g:javascript_conceal_NaN                  = 'ℕ'
    let g:javascript_conceal_prototype            = '¶'
    let g:javascript_conceal_static               = '•'
    let g:javascript_conceal_super                = 'Ω'
    let g:javascript_conceal_arrow_function       = '⇒'
" }}}

" vim-js-pretty-template {{{
    augroup plug_jsprettytemplate
        au!
        " Register tag name associated the filetype
        au! User vim-js-pretty-template call jspretmpl#register_tag('gql','graphql')
        au FileType javascript JsPreTmpl
        au FileType javascript.jsx JsPreTmpl
        au FileType typescript JsPreTmpl
        au FileType typescript.tsx JsPreTmpl
    augroup END
" }}}

" vim-jsdoc {{{
    nmap <leader>jsd :JsDoc<CR>
    let g:jsdoc_additional_descriptions = 1
    let g:jsdoc_input_description = 1
    let g:jsdoc_allow_input_prompt = 1
    let g:jsdoc_access_descriptions = 1
    let g:jsdoc_underscore_private = 1
    let g:jsdoc_param_description_separator = ' - '
    let g:jsdoc_enable_es6 = 1
" }}}

" vim-jsx {{{
    let g:jsx_ext_required = 0 " Allow JSX in normal JS files
" }}}

" vim-move {{{
    let g:move_key_modifier = 'C-A'
" }}}

" vim-multiple-cursors {{{
    let g:multi_cursor_exit_from_visual_mode=0
" }}}

" vim-nerdtree-syntax-highlight {{{
    let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
" }}}

" vim-polyglot {{{
    let g:polyglot_disabled = ['javascript', 'typescript']
" }}}

" vim-startify {{{
    let g:startify_use_env = 1
    let g:startify_change_to_dir = 0
    let g:startify_change_to_vcs_root = 1
    let g:startify_padding_left = 3
    let g:startify_skiplist = [
        \ 'COMMIT_EDITMSG',
        \ escape(fnamemodify(resolve($VIMRUNTIME), ':p'), '\') .'doc',
        \ 'bundle/.*/doc',
        \ '/\.git/index$',
    \ ]

    function! StartifyEntryFormat()
        return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
    endfunction

    function! s:startify_center_header(lines) abort
        let longest_line   = max(map(copy(a:lines), 'strwidth(v:val)'))
        let centered_lines = map(copy(a:lines),
            \ 'repeat(" ", (longest_line / 5)) . v:val')
            " \ 'repeat(" ", (&columns / 2) + longest_line + (longest_line / 10)) . v:val')
            " \ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
        return centered_lines
    endfunction

    function! s:list_commits()
        let git = 'git -C ' . getcwd()
        let commits = systemlist(git .' log --oneline | head -n5')
        let git = 'G'. git[1:]
        return map(commits, '{"line": "  " . matchstr(v:val, "\\s\\zs.*"), "cmd": "'. git .' show ". matchstr(v:val, "^\\x\\+") }')
    endfunction

    function! s:get_project_name()
        let cwd = getcwd()
        let git = 'git -C ' . cwd
        let dirname = system(git . ' rev-parse --abbrev-ref HEAD')
        return '   ' . (strchars(dirname) > 0 ? ('  ' .substitute(dirname, '[[:cntrl:]]', '', 'g')) : cwd)
    endfunction

    let g:startify_lists = [
        \ { 'type': 'files',                    'header': ['   MRU']                },
        \ { 'type': 'dir',                      'header': [s:get_project_name()]    },
        \ { 'type': 'sessions',                 'header': ['   Sessions']           },
        \ { 'type': 'bookmarks',                'header': ['   Bookmarks']          },
        \ { 'type': 'commands',                 'header': ['   Commands']           },
        \ { 'type': function('s:list_commits'), 'header': ['   Commits']            }
    \ ]
    let g:startify_custom_header = [
    \ '   Web browsers are useless here.',
    \ ' ',
    \ ' ',
    \ '         ,+++77777++=:,                    +=                      ,,++=7++=,,',
    \ '       7~?7   +7I77 :,I777  I          77 7+77 7:        ,?777777??~,=+=~I7?,=77 I',
    \ '   =7I7I~7  ,77: ++:~+7 77=7777 7     +77=7 =7I7     ,I777= 77,:~7 +?7, ~7   ~ 777?',
    \ '   77+7I 777~,,=7~  ,::7=7: 7 77   77: 7 7 +77,7 I777~+777I=   =:,77,77  77 7,777,',
    \ '     = 7  ?7 , 7~,~  + 77 ?: :?777 +~77 77? I7777I7I7 777+77   =:, ?7   +7 777?',
    \ '         77 ~I == ~77= +777 777~: I,+77?  7  7:?7? ?7 7 7 77 ~I   7I,,?7 I77~',
    \ '          I 7=77~+77+?=:I+~77?     , I 7? 77 7   777~ +7 I+?7  +7~?777,77I',
    \ '            =77 77= +7 7777         ,7 7?7:,??7     +7    7   77??+ 7777,',
    \ '                =I, I 7+:77?         +7I7?7777 :             :7 7',
    \ '                   7I7I?77 ~         +7:77,     ~         +7,::7   7',
    \ '                  ,7~77?7? ?:         7+:77777,           77 :7777=',
    \ '                   ?77 +I7+,7         7~  7,+7  ,?       ?7?~?777:',
    \ '                      I777=7777 ~     77 :  77 =7+,    I77  777',
    \ '                        +      ~?     , + 7    ,, ~I,  = ? ,',
    \ '                                       77:I+',
    \ '                                       ,7',
    \ '                                        :77',
    \ '                                           :',
    \ '   Welcome.',
    \ ]
    highlight StartifyHeader ctermfg=111 guifg=#98A8FF
    augroup plug_startify
        au!
        " Set Header Color/Style to Comment
        au ColorScheme * highlight link StartifyHeader Comment
        au User Startified setlocal buflisted
    augroup END
" }}}

" vim-signify {{{
    let g:signify_realtime = 1 " autocmd User Fugitive SignifyRefresh
    let g:signify_update_on_bufenter = 1
    let g:signify_update_on_focusgained = 1
    let g:signify_vcs_list = ['git', 'hg']
    let g:signify_sign_add               = '+'
    let g:signify_sign_delete            = '-'
    let g:signify_sign_delete_first_line = '‾'
    let g:signify_sign_change            = '~'
    let g:signify_sign_changedelete      = '*'
    nmap <leader>gj <plug>(signify-next-hunk)<CR>
    nmap <leader>gk <plug>(signify-prev-hunk)<CR>
    nmap <leader>gd :SignifyDiff!<CR>
    nmap <leader>gf :SignifyFold!<CR>
" }}}

" vim-signature {{{
    let g:SignatureMarkerTextHLDynamic = 1
    let g:SignatureMap = {
        \ 'Leader'             :  'm',
        \ 'PlaceNextMark'      :  'm,',
        \ 'ToggleMarkAtLine'   :  'm.',
        \ 'PurgeMarksAtLine'   :  'm-',
        \ 'DeleteMark'         :  '<Leader>dm',
        \ 'PurgeMarks'         :  '<Leader>m<Space>',
        \ 'PurgeMarkers'       :  '<Leader>m<Del>',
        \ 'GotoNextLineAlpha'  :  "m']",
        \ 'GotoPrevLineAlpha'  :  "m'[",
        \ 'GotoNextSpotAlpha'  :  'm`]',
        \ 'GotoPrevSpotAlpha'  :  'm`[',
        \ 'GotoNextLineByPos'  :  "m]'",
        \ 'GotoPrevLineByPos'  :  "m['",
        \ 'GotoNextSpotByPos'  :  'm]`',
        \ 'GotoPrevSpotByPos'  :  'm[`',
        \ 'GotoNextMarker'     :  'm]-',
        \ 'GotoPrevMarker'     :  'm[-',
        \ 'GotoNextMarkerAny'  :  'm]=',
        \ 'GotoPrevMarkerAny'  :  'm[=',
        \ 'ListBufferMarks'    :  '<Leader>m/',
        \ 'ListBufferMarkers'  :  '<Leader>m?'
    \ }
" }}}

" Vista {{{
    nnoremap <F9> :Vista!!<CR>
    let g:vista_sidebar_width = 40
    let g:vista_icon_indent = ['╰─▸ ', '├─▸ ']
    let g:vista_default_executive = 'coc'
    let g:vista_fzf_preview = ['right:50%']
    let g:vista#renderer#enable_icon = 1
    let g:vista_echo_cursor_strategy = 'both'
" }}}

" yats {{{
let g:yats_host_keyword = 1
" }}}

"-------------------------------------------------------------------------------
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" => Color Scheme {{{
"-------------------------------------------------------------------------------
" airline doesn't behave when set before Vundle:Config
let s:fmColorSchemeLight='solarized8'
let s:fmColorSchemeDark='base16-materia'

function! s:setColorScheme()
    " $ITERM_PROFILE variable requires (Iterm Shell integration) Toolset
    if $ITERM_PROFILE =~? 'Night'
        set background=dark
       execute 'colorscheme '.s:fmColorSchemeDark
    else
        set background=light
        let g:airline_theme = 'solarized'
        let g:solarized_visibility = 'high'
        let g:solarized_diffmode = 'high'
        let g:solarized_termtrans = 1
        let g:solarized_statusline = 'normal'
        let g:solarized_italics = 1
        let g:solarized_old_cursor_style = 0
        let g:solarized_enable_extra_hi_groups = 1
        execute 'colorscheme '.s:fmColorSchemeLight
    endif
endfunction
call s:setColorScheme()

function! s:ToggleBackground()
    let fmShade = &background =~? 'dark' ? 'light' : 'dark'
    let fmColorScheme = fmShade =~?'dark' ? s:fmColorSchemeDark : s:fmColorSchemeLight
    execute 'set background='.fmShade
    execute 'colorscheme '.fmColorScheme
endfunction

command! ToggleBg call s:ToggleBackground()
nnoremap <leader>bg :ToggleBg<CR>

"-------------------------------------------------------------------------------
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" => Work Hacker Functions {{{
"-------------------------------------------------------------------------------

" function! NcmsTag()
    " let randId = system('openssl rand -base64 24')
    " let randId = substitute(randId, '\n$', '', '')
    " return ' data-ncms-uuid="' . randId . '"'
" endfunction
" nnoremap <leader>nc "=NcmsTag()<cr>p<esc>

"-------------------------------------------------------------------------------
" }}}
"-------------------------------------------------------------------------------

