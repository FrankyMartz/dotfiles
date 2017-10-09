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
syntax on                       " Enable Syntax Highlighting – Allow VIM override
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

set omnifunc=csscomplete#CompleteCSS

let g:python_host_prog = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'

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
autocmd FocusLost * :silent! wall

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
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l

" Buffer Horizontal Navigation
nnoremap ˙ z30h
nnoremap ¬ z30l
"nnoremap <m-H> z20h
"nnoremap <m-L> z20l

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
    au FileType javascript inoremap <buffer> {<cr> {}<left><cr><space><space><space><space>.<cr><esc>kA<bs>
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

"-------------------------------------------------------------------------------
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" => Plug-Vim {{{
"-------------------------------------------------------------------------------
source ~/.config/nvim/vimplugrc

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

"set synmaxcol=500              " Don't highlight lines longer than
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
" Airline {{{
set laststatus=2        " Always display the statusline in all windows
set noshowmode          " Hide default mode text

let g:airline_detect_modified=1
let g:airline_detect_paste=1
let g:airline_detect_crypt=1
let g:airline_detect_spell=1
let g:airline_inactive_collapse=1
let g:airline_skip_empty_sections = 1
let g:airline_highlighting_cache = 0
let g:airline_powerline_fonts=1
let g:airline_section_y = airline#section#create_right(['ffenc','gutentags#statusline()'])
" Promptline
let g:airline#extensions#promptline#snapshot_file = '~/.dotfiles/bin/.shell_prompt.sh'
let g:airline#extensions#promptline#enabled = 0
let g:airline#extensions#windowswap#enabled = 1
" Windowswap
let g:airline#extensions#windowswap#indicator_text = 'WS'
" base16
let g:airline_base16_improved_contrast = 1
let g:airline#themes#base16#constant = 1
" vim-ctrlspace
let g:airline#extensions#ctrlspace#enabled = 1
let g:CtrlSpaceStatuslineFunction = 'airline#extensions#ctrlspace#statusline()'
" YouCompleteMe
" let g:airline#extensions#ycm#enabled = 1
" let g:airline#extensions#ycm#error_symbol = 'E:'
" let g:airline#extensions#ycm#warning_symbol = 'W:'
" neomake
let g:airline#extensions#neomake#enabled = 1
let airline#extensions#neomake#error_symbol = 'E:'
let airline#extensions#neomake#warning_symbol = 'W:'
" Hunks -  vim-signify
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 0
let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-']
" Whitespace
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing', 'long', 'mixed-indent-file' ]
let g:airline#extensions#whitespace#max_lines = 20000
let g:airline#extensions#whitespace#show_message = 1
let g:airline#extensions#whitespace#trailing_format = 'trailing[%s]'
let g:airline#extensions#whitespace#mixed_indent_format = 'mixed-indent[%s]'
let g:airline#extensions#whitespace#long_format = 'long[%s]'
let g:airline#extensions#whitespace#mixed_indent_file_format = 'mix-indent-file[%s]'
let airline#extensions#c_like_langs = ['c', 'cpp', 'cuda', 'go', 'javascript', 'ld', 'php']
" tabline
let g:airline#extensions#tabline#enabled=1  " Automatically displays all buffers
let g:airline#extensions#tabline#buffer_min_count=2
" let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#formatter='unique_tail_improved'
let g:airline#extensions#tabline#left_sep=''
" let g:airline#extensions#tabline#buffer_nr_show=1
" let g:airline#extensions#tabline#buffer_nr_format='[%s]'
"let g:airline#extensions#tabline#buffer_idx_mode=1
"nmap <leader>1 <Plug>AirlineSelectTab1
"nmap <leader>2 <Plug>AirlineSelectTab2
"nmap <leader>3 <Plug>AirlineSelectTab3
"nmap <leader>4 <Plug>AirlineSelectTab4
"nmap <leader>5 <Plug>AirlineSelectTab5
"nmap <leader>6 <Plug>AirlineSelectTab6
"nmap <leader>7 <Plug>AirlineSelectTab7
"nmap <leader>8 <Plug>AirlineSelectTab8
"nmap <leader>9 <Plug>AirlineSelectTab9
"if !exists('g:airline_symbols')
      "let g:airline_symbols = {}
"endif
" unicode symbols
"let g:airline_left_sep = ''
"let g:airline_right_sep = ''
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.branch = '⑂'
"let g:airline_symbols.paste = '↯'
"let g:airline_symbols.whitespace = 'Ξ'
" }}}

" Ack {{{
if executable('rg')
  let g:ackprg = 'rg --color=never --column'
elseif executable('ag')
    " let g:ackprg = 'ag --vimgrep'
    let g:ackprg = 'ag --nogroup --nocolor --column'
endif

" let g:ackhighlight = 1
let g:ack_use_dispatch = 1
command Todo Ack! 'TODO\|FIXME'
"  }}}

" Buffergator {{{
" Use the right side of the screen
let g:buffergator_viewport_split_policy = 'R'

" I want my own keymappings...
let g:buffergator_suppress_keymaps = 1

" Looper buffers
"let g:buffergator_mru_cycle_loop = 1

" Go to the previous buffer open
nmap <leader>jj :BuffergatorMruCyclePrev<cr>

" Go to the next buffer open
nmap <leader>kk :BuffergatorMruCycleNext<cr>

" View the entire list of buffers open
nmap <leader>bl :BuffergatorOpen<cr>

" Shared bindings from Solution #1 from earlier
nmap <leader>T :enew<cr>
nmap <leader>bq :bp <BAR> bd #<cr>
" }}}

" DelimitMate {{{
let delimitMate_no_esc_mapping=1    " Esc Issue Fix
" }}}

" Deoplete {{{
let g:deoplete#enable_at_startup = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#auto_complete_start_length = 1
" use tab to forward cycle
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" use tab to backward cycle
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
call deoplete#custom#set('ultisnips', 'matchers', ['matcher_fuzzy'])
" }}}

" Deoplete-TernJS {{{
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]
let g:deoplete#sources#ternjs#types = 1
let g:deoplete#sources#ternjs#depths = 1
let g:deoplete#sources#ternjs#docs = 1
let g:deoplete#sources#ternjs#include_keywords = 1
let g:deoplete#sources#ternjs#filetypes = [
            \ 'jsx',
            \ 'javascript',
            \ 'javascript.jsx',
            \ 'vue',
            \ 'es6'
            \ ]

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
let g:indentLine_enabled = 0
let g:indentLine_conceallevel = 1
let g:indentLine_concealcursor=''
let g:indentLine_setColors=0
nnoremap <leader>ig :IndentLinesToggle<CR> 
" }}}

" javascript-libraries-syntax {{{
let g:used_javascript_libs = 'jquery,underscore,backbone,angularjs,angularui,angularuirouter,react,flux,jasmine,chai,handlebars,d3'
"autocmd BufReadPre *.jsx let b:javascript_lib_use_react=1
"autocmd BufReadPre *.jsx let b:javascript_lib_use_flux=1
"autocmd BufReadPre *.js let b:javascript_lib_use_angularjs = 1
"autocmd BufReadPre *[sS]pec.js let b:javascript_lib_use_angularjs = 1
" }}}

" Neomake {{{
" autocmd! BufWritePost * Neomake
call neomake#configure#automake('w')
" let g:neomake_verbose=3
let g:neomake_javascript_enabled_makers = ['eslint']
" Going to have to manually configure for (.eslintrc)
let g:neomake_javascript_eslint_maker = {
        \ 'args': ['--no-color', '-f', 'compact', '-c', 'package.json'],
        \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
        \   '%W%f: line %l\, col %c\, Warning - %m,%-G,%-G%*\d problems%#'
        \ }
let g:neomake_open_list=2
let g:neomake_highlight_lines=1
let g:neomake_tempfile_enabled = 0
" }}}

" NeoSnippet {{{
" let g:neosnippet#enable_snipmate_compatibility = 1
" " Tell Neosnippet about the other snippets
" " let g:neosnippet#snippets_directory='~/.nvim/bundle/vim-snippets/snippets'
" let g:neosnippet#snippets_directory=['~/.nvim/bundle/vim-snippets/snippets',
            " \ '~/.nvim/bundle/neosnippet-snippets/neosnippets' ]
            " " \ '~/.nvim/bundle/vim-react-snippets/UltiSnips',
            " " \ '~/.nvim/bundle/vim-laravel4-snippets/UltiSnips']
" imap <C-k>     <Plug>(neosnippet_expand_or_jump)
" smap <C-k>     <Plug>(neosnippet_expand_or_jump)
" xmap <C-k>     <Plug>(neosnippet_expand_target)
" }}}

" Neotags {{{
" let g:neotags_enabled=1
" " Use RipGrep
" let g:neotags_appendpath = 0
" let g:neotags_recursive = 0
" let g:neotags_ctags_bin = 'rg --files '. getcwd() .' | ctags'
" let g:neotags_ctags_args = [
            " \ '-L -',
            " \ '--fields=+l',
            " \ '--c-kinds=+p',
            " \ '--c++-kinds=+p',
            " \ '--sort=no',
            " \ '--extra=+q'
            " \ ]
" " Syntax Highlighting Speed Improvemnet
" set regexpengine=1
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
let NERDTreeIgnore = ['\~$', '.*\.pyc$', 'pip-log\.txt$', 'whoosh_index',
                        \ 'xapian_index', '.*.pid', 'monitor.py',
                        \ '.*-fixtures-.*.json', '.*\.o$', 'db.db', 'tags', 'tags.bak',
                        \ '.*\.pdf$', '.*\.mid$', '.*\.midi$']
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
" let g:promptline_theme = 'airline_visual'
let g:promptline_powerline_symbols = 1
let g:promptline_preset = {
    \'a' : [ promptline#slices#cwd() ],
    \'b' : [ promptline#slices#vcs_branch({ 'hg': 1, 'svn': 1, 'fossil': 1 }), promptline#slices#git_status() ],
    \'c' : [ '' ],
    \'x' : [ promptline#slices#host({ 'only_if_ssh': 1 }) ],
    \'y' : [ promptline#slices#python_virtualenv() ],
    \'z' : [ promptline#slices#jobs() ],
    \'warn' : [ promptline#slices#last_exit_code() ]}
" }}}

" Surround {{{
let g:surround_{char2nr('-')} = '<% \r %>'
let g:surround_{char2nr('=')} = '<%= \r %>'
let g:surround_{char2nr('8')} = '/* \r */'
let g:surround_{char2nr('s')} = ' \r '
let g:surround_{char2nr('^')} = '/^\r$/'
let g:surround_indent = 1
" }}}

" Syntastic {{{
" let g:syntastic_auto_jump=0
" let g:syntastic_auto_loc_list=1
" let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd']
" "let g:syntastic_javascript_checkers=['jsxhint', 'flow']
" "let g:syntastic_html_tidy_exec = 'tidy5'
" let g:syntastic_javascript_checkers=['eslint', 'tern_lint']
" " javascript/jscs javascript/jshint
" " let g:syntastic_javascript_checkers=['eslint']
" let g:syntastic_sass_checkers=["sass","sass_lint"]
" let g:syntastic_scss_checkers=["sass","sass_lint"]
" let g:syntastic_scss_sass_quiet_messages = {
    " \ 'regex': 'File to import not found or unreadable', }
" "let g:syntastic_html_checkers=['tidy', 'validator', 'w3']
" let g:syntastic_check_on_wq=0
" let g:syntastic_error_symbol=''
" let g:syntastic_warning_symbol=''
" " let g:syntastic_error_symbol='✘'
" " let g:syntastic_warning_symbol='▲'
" let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
" let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute ' ,'trimming empty <", 'unescaped &' , 'lacks \"action', 'is not recognized!', 'discarding unexpected']
" let g:syntastic_sh_shellcheck_args="-x"
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
\  'ctagstype' : 'css',
\  'kinds' : [
\    'v:variables',
\    'c:classes',
\    'i:identities',
\    't:tags',
\    'm:medias'
\  ],
\ 'deffile' : expand(defdir) . 'css.cnf'
\}

let g:tagbar_type_less = {
\  'ctagstype' : 'less',
\  'kinds' : [
\    'v:variable',
\    'c:class',
\    'i:id',
\    't:tag',
\    'm:media'
\  ],
\ 'deffile' : expand(defdir) . 'less.cnf'
\}

let g:tagbar_type_scss = {
\  'ctagstype' : 'scss',
\  'kinds' : [
\    'm:mixins',
\    'v:variables',
\    'c:classes',
\    'i:identities',
\    't:tags',
\    'd:medias'
\  ],
\ 'deffile' : expand(defdir) . 'scss.cnf'
\}

let g:tagbar_type_typescript = {                                                  
  \ 'ctagsbin' : 'tstags',                                                        
  \ 'ctagsargs' : '-f-',                                                           
  \ 'kinds': [                                                                     
    \ 'e:enums:0:1',                                                               
    \ 'f:function:0:1',                                                            
    \ 't:typealias:0:1',                                                           
    \ 'M:Module:0:1',                                                              
    \ 'I:import:0:1',                                                              
    \ 'i:interface:0:1',                                                           
    \ 'C:class:0:1',                                                               
    \ 'm:method:0:1',                                                              
    \ 'p:property:0:1',                                                            
    \ 'v:variable:0:1',                                                            
    \ 'c:const:0:1',                                                              
  \ ],                                                                            
  \ 'sort' : 0                                                                    
\ }                                                                               
" }}}

" TernJS {{{
"let g:tern_show_argument_hints='on_move'
let g:tern_show_signature_in_pum=1
noremap <leader>td :TernDef<cr>
noremap <leader>tdp :TernDefPreview<cr>
noremap <leader>tds :TernDefSplit<cr>
noremap <leader>tdt :TernDefTab<cr>
noremap <leader>tl :TernDoc<cr>
noremap <leader>tt :TernType<cr>
noremap <leader>t<space> :TernRefs<cr>
noremap <leader>tr :TernRename<cr>
" }}}

" UltiSnips {{{
let g:UltiSnipsExpandTrigger='<c-K>'
let g:UltiSnipsJumpForwardTrigger='<c-K>'
let g:UltiSnipsJumpBackwardTrigger='<c-J>'
" }}}

" vim-devicon {{{
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
" }}}

" vim-diff-enhanced {{{
if &diff
    let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
endif
" }}}

" vim-ctrlspace {{{
let g:CtrlSpaceDefaultMappingKey = '<C-Space>'
" [FIX] vim-ctrlspace plugin defaults to terminal mapping of <nul>
nmap <c-space> <nul>
if executable("ag")
    let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif
if has("gui_running")
    " Settings for MacVim and Inconsolata font
    let g:CtrlSpaceSymbols = { "File": "◯", "CTab": "▣", "Tabs": "▢" }
endif
let g:CtrlSpaceCacheDir = expand(tempDir).'/ctrlspacecache'
" }}}

" vim-easymotion {{{

" }}}

" vim-flow {{{
" Use Syntastic instead. (vim-flow) includes autocompletion so keep around.
let g:flow#enable = 0
" }}}

" vim-gutentags {{{
let g:gutentags_enabled = 1
" }}}

" vim-javascript {{{
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
let g:javascript_fold = 0
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

" vim-jsdoc {{{
let g:jsdoc_default_mapping=0
let g:jsdoc_allow_input_prompt=1
nmap <leader>l :JsDoc<CR>
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

" YouCompleteMe {{{
" autocmd FileType c nnoremap <buffer> <silent> <C-]> :YcmCompleter GoTo<cr>
" nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
" " let g:ycm_cache_omnifunc=1                            ' Potential Cause Lag
" let g:ycm_collect_identifiers_from_comments_and_strings=1
" let g:ycm_collect_identifiers_from_tags_files=1
" " let g:ycm_filepath_completion_use_working_dir = 1
" let g:ycm_add_preview_to_completeopt=1
" let g:ycm_autoclose_preview_window_after_completion=1
" let g:ycm_complete_in_comments=1
" let g:ycm_complete_in_strings=1
" let g:ycm_use_ultisnips_completer=1
" " pyenv
" let g:ycm_path_to_python_interpreter = '/usr/local/bin/python'
" let g:ycm_python_binary_path = '/usr/local/bin/python'
" }}}

"-------------------------------------------------------------------------------
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" => Color Scheme {{{
"-------------------------------------------------------------------------------

" airline doesn't behave when set before Vundle:Config
" colorscheme base16-oceanicnext
let g:solarized_termtrans=1
let g:solarized_term_italics=1

" let s:fmColorSchemeDark='base16-eighties'
" let s:fmColorSchemeLight='base16-eighties'
" let s:fmColorSchemeDark='base16-materia'
" let s:fmColorSchemeLight='base16-materia'
" let s:fmColorSchemeDark='base16-oceanicnext'
let s:fmColorSchemeDark='solarized8_dark_high'

" let s:fmColorSchemeLight='base16-oceanicnext'
" let s:fmColorSchemeLight='base16-solarized-light'
let s:fmColorSchemeLight='solarized8_light'

" nnoremap  <leader>B :<c-u>exe 'colors' (g:colors_name =~# 'dark'
    " \ ? substitute(g:colors_name, 'dark', 'light', '')
    " \ : substitute(g:colors_name, 'light', 'dark', '')
    " \ )<cr>

" $ITERM_PROFILE variable requires (Iterm Shell integration) Toolset
if $ITERM_PROFILE == 'Night'
    set background=dark
    execute 'colorscheme '.s:fmColorSchemeDark
else
    set background=light
    execute 'colorscheme '.s:fmColorSchemeLight
endif

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

