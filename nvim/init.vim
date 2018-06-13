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
set nocompatible

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

set backspace=indent,eol,start  " Allow backspace over everything in insert modeA

set cpoptions+=d    " Use tags relative to CWD

" Always use system clipboard for ALL operations
"set clipboard+=unnamedplus

let g:python_host_prog='/usr/local/opt/python@2/bin/python2'
let g:python3_host_prog='/usr/local/opt/python@3/bin/python3'

"-------------------------------------------------------------------------------
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" => File and Backup {{{
"-------------------------------------------------------------------------------
set encoding=utf-8
set termencoding=utf-8          " Encoding used for the terminal
set fileformat=unix

" Save when losing focus
au FocusLost * :silent! wa

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
set concealcursor=""            " Show all concealed chars in cursorline

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
" nnoremap ˙ z30h
" nnoremap ¬ z30l
nnoremap <M-h> 20zh
nnoremap <M-l> 20zl
" nnoremap ˍ 20zh
" nnoremap - 20zl

" Switch (previous,next) Buffer
nmap <leader>kk :bnext<CR>
nmap <leader>jj :bprevious<CR>
nmap <leader>hh :tabprevious<CR>
nmap <leader>ll :tabnext<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
" nmap <leader>bq :bp <BAR> bd #<CR>
" Show all open buffers and their status
" nmap <leader>bl :ls<CR>

" COPY / PASTE ... PLEASE
"vnoremap <leader>y "*y
"noremap <leader>p :silent! set paste<cr>"*p:set nopaste<cr>

function! ClipboardYank()
  call system('pbcopy', @@)
endfunction
function! ClipboardPaste()
  let @@ = system('pbpaste')
endfunction

vnoremap <silent> <leader>y y:call ClipboardYank()<cr>
vnoremap <silent> <leader>d d:call ClipboardYank()<cr>
nnoremap <silent> <leader>p :call ClipboardPaste()<cr>p<cr>
vnoremap <silent> P "0p<cr>

" Sudo to write (handle permission-denied error)
cnoremap w!! w !sudo tee % >/dev/null
" Open .nvimrc file
nnoremap <leader>ev <c-w><c-v><c-l>:e $MYVIMRC<cr>
" Toggle display invisible characters
nmap <leader>i :set list!<cr>
" Set line numbers to relative
nmap <leader>r :set relativenumber<cr>
" Toggle cursorline
nmap <leader>c :set cursorline!<cr>

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

" Split Buffers
nnoremap <c-s> <c-w>s
nnoremap <c-v> <c-w>v

" Resize Window
nnoremap <silent> + :exe "vertical resize +" . (winwidth(0) * 1/8)<CR>
nnoremap <silent> - :exe "vertical resize -" . (winwidth(0) * 1/8)<CR>

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

set rtp+=/usr/local/opt/fzf

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

" CSS {{{
augroup ft_css
    au!
    au FileType css,scss,sass,less,stylus setlocal ts=4 sts=4 sw=4 noexpandtab
    au BufNewFile,BufRead *.css setlocal filetype=css
    au BufNewFile,BufRead *.scss setlocal filetype=scss
    au BufNewFile,BufRead *.sass setlocal filetype=sass
    au BufNewFile,BufRead *.less setlocal filetype=less
    au BufNewFile,BufRead *.styl setlocal filetype=stylus
    au FileType css set omnifunc=csscomplete#CompleteCSS

    " au FileType less UltiSnipsAddFiletypes less.css
    au FileType scss,sass,less,css setlocal foldmethod=marker foldmarker={,}
    "au FileType css,scss,sass,less,stylus omnifunc=csscomplete#CompleteCSS
    "au FileType less,css setlocal isKeyword+=-
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
    au FileType html UltiSnipsAddFiletypes html.css.javascript
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
    au FileType javascript.jsx UltiSnipsAddFiletypes javascript.jsx.html
    au FileType javascript.jsx UltiSnipsAddFiletypes javascript.jsx
    au FileType javascript.spec UltiSnipsAddFiletypes javascript.javascript-jasmine
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
" Keep active buffer on larger window ratio
" We have to have a winheight bigger than we want to set winminheight. But if we
" set winheight to be huge before winminheight, the winminheight set will fail.
"set winwidth=84
set winheight=10
set winminheight=10
set winheight=999

set diffopt+=vertical
set diffopt+=iwhite

" Disable Line Numbers in Terminal
au TermOpen * setlocal nonumber norelativenumber

"-------------------------------------------------------------------------------
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" => Plug-Vim {{{
"-------------------------------------------------------------------------------
source ~/.config/nvim/vimplugrc.vim

"-------------------------------------------------------------------------------
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" => Color and Font {{{
"-------------------------------------------------------------------------------
"
if has('termguicolors')
    set termguicolors               " Set True Colors in Terminal
else
    let base16colorspace=256        " Access colors present in 256 colorspace
endif

" set guifont=Menlo:h11
"set guifont=hack:h11

autocmd BufEnter * :syntax sync fromstart

set synmaxcol=0                 " Don't highlight lines longer than
set colorcolumn=80              " Column number to highlight
" Prevent Location List color column and numbers
au FileType qf setlocal nonumber colorcolumn=

" highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
" highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
" highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167

" hi DiffAdd term=reverse cterm=bold ctermbg=darkgreen ctermfg=black
" hi DiffChange term=reverse cterm=bold ctermbg=gray ctermfg=black
" hi DiffText term=reverse cterm=bold ctermbg=blue ctermfg=black
" hi DiffDelete term=reverse cterm=bold ctermbg=darkred ctermfg=black
" hi CursorLine cterm=NONE ctermbg=black ctermfg=NONE guibg=black guifg=NONE

"-------------------------------------------------------------------------------
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" => Plug:Configuration {{{
"-------------------------------------------------------------------------------

" Ack {{{
if executable('rg')
  " let g:ackprg = 'rg --color=never --column'
  let g:ackprg = 'rg --vimgrep'
elseif executable('ag')
    let g:ackprg = 'ag --vimgrep'
    " let g:ackprg = 'ag --nogroup --nocolor --column'
endif

" let g:ackhighlight = 1
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
let g:airline_inactive_collapse=1
let g:airline_skip_empty_sections=1
let g:airline_highlighting_cache=1
let g:airline_powerline_fonts=1
let g:airline_exclude_preview=1
let g:airline_section_y = airline#section#create_right(['ffenc','gutentags#statusline()'])
let g:airline#extensions#default#section_truncate_width = {
    \ 'b': 140,
    \ 'x': 140,
    \ 'y': 140,
\ }
" Ale --------------------------------------------------------------------------
let g:airline#extensions#ale#enabled=1
" Base16 -----------------------------------------------------------------------
" let g:airline_base16_improved_contrast=1
" let g:airline#themes#base16#constant=1
" Git --------------------------------------------------------------------------
let g:airline#extensions#branch#format=1
" PromptLine -------------------------------------------------------------------
let g:airline#extensions#promptline#snapshot_file='~/.dotfiles/bin/.shell_prompt.sh'
let g:airline#extensions#promptline#enabled=0
let g:airline#extensions#windowswap#enabled=1
" WindowSwap -------------------------------------------------------------------
let g:airline#extensions#windowswap#indicator_text='WS'
" YouCompleteMe ----------------------------------------------------------------
let g:airline#extensions#ycm#enabled=1
" Vim-Signify ------------------------------------------------------------------
let g:airline#extensions#hunks#enabled=1
let g:airline#extensions#hunks#non_zero_only=0
let g:airline#extensions#hunks#hunk_symbols=['+', '~', '-']
" WhiteSpace -------------------------------------------------------------------
let g:airline#extensions#whitespace#enabled=1
let g:airline#extensions#whitespace#checks=[ 'indent', 'trailing', 'long', 'mixed-indent-file' ]
let g:airline#extensions#whitespace#max_lines=20000
let g:airline#extensions#whitespace#show_message=1
let g:airline#extensions#whitespace#trailing_format='trailing[%s]'
let g:airline#extensions#whitespace#mixed_indent_format='mixed-indent[%s]'
let g:airline#extensions#whitespace#long_format='long[%s]'
let g:airline#extensions#whitespace#mixed_indent_file_format='mix-indent-file[%s]'
let airline#extensions#c_like_langs=['c', 'cpp', 'cuda', 'go', 'javascript', 'typescript', 'ld', 'php']
" vim-ctrlspace ----------------------------------------------------------------
let g:CtrlSpaceUseTabline=0
let g:airline#extensions#ctrlspace#enabled=1
let g:CtrlSpaceStatuslineFunction='airline#extensions#ctrlspace#statusline()'
" TabLine ----------------------------------------------------------------------
let g:airline#extensions#tabline#enabled=1  " Automatically displays all buffers
let g:airline#extensions#tabline#buffer_min_count=1
let g:airline#extensions#tabline#formatter='unique_tail_improved'
" let g:airline#extensions#tabline#switch_buffers_and_tabs=1
let g:airline#extensions#tabline#exclude_preview=1
let g:airline#extensions#tabline#left_sep=''
let g:airline#extensions#tabline#excludes = ['loclist', 'quickfix']
" }}}

" Ale {{{
let g:ale_sign_error = '✘'
let g:ale_sign_warning = ''
let g:ale_change_sign_column_color = 1
" let g:ale_completion_enabled = 1
let g:ale_open_list = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_linters = {
    \ 'javascript': ['eslint', 'standard'],
    \ 'go': ['gometalinter', 'gofmt'],
    \ 'html': [],
\ }
let g:ale_fixers = {
    \ 'javascript': ['eslint'],
\ }
let g:ale_javascript_eslint_options = '--no-color'
let g:ale_go_gometalinter_options = '--fast'
nmap <leader>ek <Plug>(ale_previous_wrap)
nmap <leader>ej <Plug>(ale_next_wrap)
au BufWinLeave * silent! lclose
"  }}}

" DelimitMate {{{
let delimitMate_no_esc_mapping=1    " Esc Issue Fix
" }}}

" EditorConfig {{{
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
" }}}

" Fugitive {{{
nmap <leader>? :Gstatus<cr>
" }}}

" FZF {{{
nmap <c-t> :FZF<cr>
if has('nvim')
  let $FZF_DEFAULT_OPTS .= ' --inline-info'
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

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
" }}}

" Gundo {{{
" nnoremap <F7> :GundoToggle<CR>
nnoremap <F7> :MundoToggle<CR>
" }}}

" indentLine {{{
let g:indentLine_enabled = 1
let g:indentLine_conceallevel = 1
let g:indentLine_concealcursor='¦'
let g:indentLine_setColors=0
nnoremap <leader>ig :IndentLinesToggle<CR>
" let g:indentLine_bgcolor_term = 202
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

" Neotags.nvim {{{
let g:neotags_enabled = 1
let g:neotags_ignore = [
    \ 'html',
    \ 'text',
    \ 'nofile',
    \ 'mail',
    \ 'qf',
\ ]
" set regexpengine=1
" Utilize RipGrep
let g:neotags_highlight = 1
let g:neotags_appendpath = 0
let g:neotags_recursive = 1
" let g:neotags_ctags_args = [
    " \ '-L -',
    " \ '--fields=+l',
    " \ '--c-kinds=+p',
    " \ '--c++-kinds=+p',
    " \ '--sort=no',
    " \ '--extra=+q'
" \ ]

" Or this one for ripgrep. Not both.
"/usr/local/bin/ctags
" let g:neotags_ctags_bin = 'rg --files '. getcwd() .' | /usr/local/bin/ctags'
" let g:neotags_verbose = 1
let g:neotags_find_tool = 'rg --files'
" }}}

" NERDTree {{{
augroup nerdtree
    " Quit when NERDTree is only open buffer
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END
nmap <F8> :NERDTreeToggle<CR>
let NERDTreeChDirMode=2
let NERDTreeBookmarksFile=expand(tempDir).'/NERDTreeBookmarks'
let NERDTreeMouseMode=2
let NERDTreeMinimalUI=1
let NERDTreeAutoDeleteBuffer=1
let NERDTreeCascadeSingleChildDir=0
let NERDTreeIgnore = [
    \ '\~$', '.*\.pyc$', 'pip-log\.txt$', 'whoosh_index', 'xapian_index',
    \ '.*.pid', 'monitor.py', '.DS_Store', '.*-fixtures-.*.json', '.*\.o$',
    \ 'db.db', 'tags', 'tags.bak', '.*\.pdf$', '.*\.mid$', '.*\.midi$'
\ ]
" }}}

" NERDTree Commentor {{{
let NERDMenuMode=0
let NERDSpaceDelims=1
" }}}

" NERDTree Git Plugin {{{
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "",
    \ "Staged"    : "",
    \ "Untracked" : "",
    \ "Renamed"   : "",
    \ "Unmerged"  : "",
    \ "Deleted"   : "",
    \ "Dirty"     : " ",
    \ "Clean"     : "",
    \ 'Ignored'   : ' ',
    \ "Unknown"   : ""
\ }
" }}}

" PromptLine {{{
let g:promptline_powerline_symbols = 1
let g:promptline_preset = {
    \'a' : [ promptline#slices#cwd() ],
    \'b' : [ promptline#slices#vcs_branch({ 'hg': 1, 'svn': 1, 'fossil': 1 }), promptline#slices#git_status() ],
    \'c' : [ '' ],
    \'x' : [ promptline#slices#host({ 'only_if_ssh': 1 }) ],
    \'y' : [ promptline#slices#python_virtualenv() ],
    \'z' : [ promptline#slices#jobs() ],
    \'warn' : [ promptline#slices#last_exit_code() ]
\ }
" }}}

" Surround {{{
let g:surround_{char2nr('-')} = '<% \r %>'
let g:surround_{char2nr('=')} = '<%= \r %>'
let g:surround_{char2nr('8')} = '/* \r */'
let g:surround_{char2nr('s')} = ' \r '
let g:surround_{char2nr('^')} = '/^\r$/'
let g:surround_indent = 1
" }}}

" Tagbar {{{
let defdir="~/.nvim/deffile/"
nmap <F9> :TagbarToggle<CR>
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

let g:tagbar_type_css = {
    \ 'ctagstype' : 'css',
    \ 'kinds' : [
        \ 'v:variables',
        \ 'c:classes',
        \ 'i:identities',
        \ 't:tags',
        \ 'm:medias'
    \ ],
    \ 'deffile' : expand(defdir) . 'css.cnf'
\}

let g:tagbar_type_less = {
    \ 'ctagstype' : 'less',
    \ 'kinds' : [
        \ 'v:variable',
        \ 'c:class',
        \ 'i:id',
        \ 't:tag',
        \ 'm:media'
    \ ],
    \ 'deffile' : expand(defdir) . 'less.cnf'
\ }

let g:tagbar_type_scss = {
    \ 'ctagstype' : 'scss',
    \ 'kinds' : [
        \ 'm:mixins',
        \ 'v:variables',
        \ 'c:classes',
        \ 'i:identities',
        \ 't:tags',
        \ 'd:medias'
    \ ],
    \ 'deffile' : expand(defdir) . 'scss.cnf'
\ }

let g:tagbar_type_typescript = {
    \ 'ctagstype' : 'typescript',
    \ 'kinds': [
        \ 'n:namespace:0:1',
        \ 'm:module:0:1',
        \ 'c:class:0:1',
        \ 'a:abstractclass:0:1',
        \ 't:type:0:1',
        \ 'i:interface:0:1',
        \ 'e:enum:0:1',
        \ 'v:variable:0:1',
        \ 'f:function:0:1',
        \ 'l:lambda:0:1',
        \ 'p:member:0:1',
    \ ],
    \ 'sort' : 0,
    \ 'deffile' : expand(defdir) . 'typescript.cnf'
\ }

let g:tagbar_type_js = {
    \ 'ctagstype' : 'js',
    \ 'kinds' : [
        \ 't:tag',
        \ 'i:import',
        \ 'v:variable',
        \ 'a:array',
        \ 'c:class',
        \ 'c:class',
        \ 'f:function',
        \ 'g:generator',
        \ 'm:method',
        \ 'p:property',
        \ 'o:object',
        \ 'e:export',
    \ ],
    \ 'deffile' : expand(defdir) . 'js.cnf'
\ }
" }}}

" vim-devicon {{{
let g:webdevicons_enable=1
let g:webdevicons_enable_nerdtree=1
let g:webdevicons_enable_vimfiler = 1
let g:webdevicons_enable_airline_tabline=1
let g:webdevicons_enable_airline_statusline=1
let g:webdevicons_enable_ctrlp=1
let g:webdevicons_enable_flagship_statusline = 1

let g:WebDevIconsUnicodeGlyphDoubleWidth=1
let g:webdevicons_conceal_nerdtree_brackets=1
let g:WebDevIconsNerdTreeAfterGlyphPadding=' '
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1

let g:WebDevIconsUnicodeDecorateFolderNodes=1
let g:DevIconsEnableFoldersOpenClose=1
let g:DevIconsEnableFolderPatternMatching=1
let g:DevIconsEnableFolderExtensionPatternMatching=0
let g:WebDevIconsUnicodeDecorateFolderNodesExactMatches=1

let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols = {} " needed
" let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['node_modules'] = '' "      ﯵ
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*spec.*\.ts$'] = '' "   
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*module.*\.ts$'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*service.*\.ts$'] = '' 
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*component.*\.ts$'] = '' 
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*component.*\.ts$'] = '' 

let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*\.csv$'] = '' 
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*\.tsv$'] = '' 
"    簾  
"   

let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['package\(-lock\)\?\.json'] = ''  
" TODO: Validate REGEX in Assignment
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['tsconfig\(\..\+\)\?\.json'] = '' 
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['\(tslint\|eslint\)\.json'] = '' 

let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*\.js\.map$'] = '慎' 
" }}}

" vim-delve {{{
let g:delve_backend = "native"
let s:aDelveCachePath='~/.nvim/tmp/vim-delve//'
if !isdirectory(expand(s:aDelveCachePath))
    call mkdir(expand(s:aDelveCachePath), 'p')
endif
let g:delve_cache_path = expand(s:aDelveCachePath)
" }}}

" vim-diff-enhanced {{{
if &diff
    let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
endif
" }}}

" vim-ctrlspace {{{
" let g:CtrlSpaceSetDefaultMapping=0
let s:aCtrlSpaceCacheDir='~/.nvim/tmp/ctrlspace//'
if !isdirectory(expand(s:aCtrlSpaceCacheDir))
    call mkdir(expand(s:aCtrlSpaceCacheDir), 'p')
endif
let g:CtrlSpaceCacheDir = expand(s:aCtrlSpaceCacheDir)
" let g:CtrlSpaceSearchTiming = 0
" [FIX] vim-ctrlspace plugin defaults to terminal mapping of <nul>
nmap <c-space> <nul>
let g:CtrlSpaceUseMouseAndArrowsInTerm=1
let g:CtrlSpaceLoadLastWorkspaceOnStart=1
let g:CtrlSpaceSaveWorkspaceOnSwitch=1
let g:CtrlSpaceSaveWorkspaceOnExit=1

if executable('rg')
    let g:CtrlSpaceGlobCommand = 'rg -l --hidden --nocolor -g ""'
elseif executable('ag')
    let g:CtrlSpaceGlobCommand = 'ag -l --hidden --nocolor -g ""'
endif
let g:CtrlSpaceCacheDir = expand(tempDir).'/ctrlspacecache'
" }}}

" vim-flow {{{
" Use Syntastic instead. (vim-flow) includes autocompletion so keep around.
let g:flow#enable = 0
" }}}

" vim-go {{{
" Setting
let g:go_test_show_name = 1
let g:go_autodetect_gopath = 1
let g:go_fmt_command = "goimports"
let g:go_term_mode = "split"
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
if isdirectory(expand("$GOPATH/src/github.com/golang/lint/misc/vim"))
    set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
endif
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
" }}}

" vim-gutentags {{{
let g:gutentags_enabled = 1
" let g:gutentags_ctags_executable_javascript = 'jsctags'
" let g:gutentags_ctags_executable_javascript = 'ctags'
" let g:gutentags_ctags_executable_typescript = 'tstags'
" }}}

" vim-javascript {{{
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END
let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_null                 = "ø"
let g:javascript_conceal_this                 = "@"
let g:javascript_conceal_return               = "⇚"
let g:javascript_conceal_undefined            = "¿"
let g:javascript_conceal_NaN                  = "ℕ"
let g:javascript_conceal_prototype            = "¶"
let g:javascript_conceal_static               = "•"
let g:javascript_conceal_super                = "Ω"
let g:javascript_conceal_arrow_function       = "⇒"
" }}}

" vim-js-pretty-template {{{
" Register tag name associated the filetype
autocmd! User vim-js-pretty-template call jspretmpl#register_tag('gql', 'graphql')
autocmd FileType javascript JsPreTmpl html
autocmd FileType typescript JsPreTmpl markdown
" }}}

" vim-jsdoc {{{
let g:jsdoc_default_mapping=0
let g:jsdoc_allow_input_prompt=1
nmap <leader>jsd :JsDoc<CR>
" }}}

" vim-json {{{
let g:vim_json_syntax_conceal=0
" }}}

" vim-jsx {{{
let g:jsx_ext_required = 0 " Allow JSX in normal JS files
" }}}

" vim-livedown {{{
let g:livedown_autorun = 0  " Auto-Open Preview on markdown
let g:livedown_open = 1     " Open Browser on Preview
let g:livedown_port = 1337  " Browser Port
nnoremap <silent><F14> :LivedownPreview<CR>
" }}}

" vim-multiple-cursors {{{
let g:multi_cursor_exit_from_visual_mode=0
" }}}

" vim-nerdtree-syntax-highlight {{{
" let g:NERDTreeFileExtensionHighlightFullName = 1
" }}}

" vim-polyglot {{{
let g:polyglot_disabled = ['javascript', 'typescript']
" }}}

" vim-signify {{{
" autocmd User Fugitive SignifyRefresh
let g:signify_update_on_bufenter = 1
let g:signify_update_on_focusgained = 1
" let g:signify_realtime = 1
" let g:signify_line_highlight = 1
let g:signify_cursorhold_normal = 1
" let g:signify_cursorhold_insert = 1
let g:signify_vcs_list = ['git', 'hg']
" let g:signify_sign_add               = ''
" let g:signify_sign_delete            = ''
" let g:signify_sign_delete_first_line = '‾'
" let g:signify_sign_change            = ''
" let g:signify_sign_changedelete      = ''
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '-'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'
let g:signify_sign_changedelete      = '*'
" }}}

" vim-signature {{{
let g:SignatureMarkerTextHLDynamic = 1
" }}}

" UltiSnips {{{
let g:UltiSnipsUsePythonVersion=3
let g:UltiSnipsExpandTrigger='<c-K>'
let g:UltiSnipsJumpForwardTrigger='<c-K>'
let g:UltiSnipsJumpBackwardTrigger='<c-J>'
" }}}

" YouCompleteMe {{{
autocmd FileType c nnoremap <buffer> <silent> <C-]> :YcmCompleter GoTo<cr>
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
" let g:ycm_cache_omnifunc=1                            ' Potential Cause Lag
let g:ycm_key_list_select_completion = ['<TAB>']
let g:ycm_key_list_previous_completion = ['<S-TAB>']
let g:ycm_key_list_stop_completion = ['<C-y>', '<UP>', '<DOWN>']
let g:ycm_collect_identifiers_from_comments_and_strings=1
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_add_preview_to_completeopt=1
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_complete_in_comments=1
let g:ycm_complete_in_strings=1
let g:ycm_use_ultisnips_completer=1
let g:ycm_show_diagnostics_ui=1 " Disable to use ALE
" let g:ycm_min_num_of_chars_for_completion=3
" let g:ycm_min_num_identifier_candidate_chars=3
" let g:ycm_auto_trigger=0
" pyenv
let g:ycm_path_to_python_interpreter = '/usr/local/opt/python@3/bin/python3'
let g:ycm_python_binary_path = '/usr/local/opt/python@3/bin/python3'
" }}}

"-------------------------------------------------------------------------------
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" => Color Scheme {{{
"-------------------------------------------------------------------------------
" airline doesn't behave when set before Vundle:Config
let s:fmColorSchemeDark='OceanicNext'
let s:fmColorSchemeLight = 'solarized8_high'

function! s:setColorScheme()
    " $ITERM_PROFILE variable requires (Iterm Shell integration) Toolset
    if $ITERM_PROFILE == 'Night'
        set background=dark
        let g:airline_theme='oceanicnext'
        let g:oceanic_next_terminal_bold = 1
        let g:oceanic_next_terminal_italic = 1
        execute 'colorscheme '.s:fmColorSchemeDark
    else
        set background=light
        let g:airline_theme = 'solarized'
        let g:solarized_visibility = 'high'
        let g:solarized_termtrans = 1
        let g:solarized_term_italics = 1
        let g:solarized_old_cursor_style=1
        let g:solarized_enable_extra_hi_groups = 1
        execute 'colorscheme '.s:fmColorSchemeLight
    endif
endfunction
call s:setColorScheme()

function! s:ToggleBackground()
    let fmShade = &background == 'dark' ? 'light' : 'dark'
    let fmColorScheme = fmShade == 'dark' ? s:fmColorSchemeDark : s:fmColorSchemeLight
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

