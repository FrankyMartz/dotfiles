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
" nnoremap <silent> <Leader>< V<<esc>
" nnoremap <silent> <Leader>> V><esc>
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Split Buffers
nnoremap <c-s> <c-w>s
nnoremap <c-v> <c-w>v

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
    " au FileType typescript setlocal foldmethod=syntax
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
    " au WinEnter * setlocal cursorline cursorcolumn
    " au WinLeave * setlocal nocursorline nocursorcolumn
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
set winheight=5
set winminheight=5
" set winheight=999

set diffopt+=vertical
set diffopt+=iwhite

" Disable Line Numbers in Terminal
au TermOpen * setlocal nonumber norelativenumber

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

" set guifont=Menlo:h11
"set guifont=hack:h11

set synmaxcol=0                 " Don't highlight lines longer than
set colorcolumn=80              " Column number to highlight

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
" let g:airline_section_y = airline#section#create_right(['ffenc','gutentags#statusline()'])
let g:airline#extensions#default#section_truncate_width = {
    \ 'b': 140,
    \ 'x': 140,
\ }
" \ 'y': 140,
let g:airline#extensions#tabline#ignore_bufadd_pat = 'gundo|undotree|vimfiler|tagbar|nerd_tree|startify'

" Airline : Ale ================================================================
let g:airline#extensions#ale#enabled=1

" Airline : Base16 =============================================================
" let g:airline_base16_improved_contrast=1
" let g:airline#themes#base16#constant=1

" Airline : Git ================================================================
let g:airline#extensions#branch#format=1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#displayed_head_limit = 10
let g:airline#extensions#branch#sha1_len = 10

" Airline : Gutentags ==========================================================
let g:airline#extensions#gutentags#enabled = 1

" Airline : Fugitive ===========================================================
let g:airline#extensions#fugitiveline#enabled = 1

" Airline : Hunks ==============================================================
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 0

" Airline : PromptLine =========================================================
let g:airline#extensions#promptline#snapshot_file='~/.dotfiles/bin/.shell_prompt.sh'
let g:airline#extensions#promptline#enabled=0
let g:airline#extensions#windowswap#enabled=1

" Airline : WindowSwap =========================================================
let g:airline#extensions#windowswap#indicator_text='WS'

" Airline : YouCompleteMe ======================================================
let g:airline#extensions#ycm#enabled=1

" Airline : Signify ============================================================
let g:airline#extensions#hunks#enabled=1
let g:airline#extensions#hunks#non_zero_only=0
let g:airline#extensions#hunks#hunk_symbols=['+', '~', '-']

" Airline : WhiteSpace =========================================================
let g:airline#extensions#whitespace#enabled=1
let g:airline#extensions#whitespace#checks=[ 'indent', 'trailing', 'long', 'mixed-indent-file' ]
let g:airline#extensions#whitespace#max_lines=20000
let g:airline#extensions#whitespace#show_message=1
let g:airline#extensions#whitespace#trailing_format='trailing[%s]'
let g:airline#extensions#whitespace#mixed_indent_format='mixed-indent[%s]'
let g:airline#extensions#whitespace#long_format='long[%s]'
let g:airline#extensions#whitespace#mixed_indent_file_format='mix-indent-file[%s]'
let airline#extensions#c_like_langs=['c', 'cpp', 'cuda', 'go', 'javascript', 'typescript', 'ld', 'php']

" Airline : CtrlSpace ==========================================================
let g:CtrlSpaceUseTabline=0
let g:airline#extensions#ctrlspace#enabled=1
let g:airline#extensions#ctrlp#show_adjacent_modes = 1
" let g:airline#extensions#tabline#switch_buffers_and_tabs = 1
let g:CtrlSpaceStatuslineFunction='airline#extensions#ctrlspace#statusline()'

" Airline : CursorMode =========================================================
let g:airline#extensions#cursormode#enabled = 1

" Airline : TabLine ============================================================
let g:airline#extensions#tabline#enabled=1  " Automatically displays all buffers
let g:airline#extensions#tabline#buffers_label = 'buffer'
let g:airline#extensions#tabline#tabs_label = 'tab'
let g:airline#extensions#tabline#current_first = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#buffer_min_count=1
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#tabline#formatter='unique_tail_improved'
let g:airline#extensions#tabline#buffer_nr_show = 1

" Airline : Tagbar =============================================================
let g:airline#extensions#tagbar#enabled = 1
" let g:airline#extensions#tabline#switch_buffers_and_tabs=1
let g:airline#extensions#tabline#exclude_preview=1
let g:airline#extensions#tabline#left_sep=''
let g:airline#extensions#tabline#excludes = ['loclist', 'quickfix']

" Airline : VirtualEnv =========================================================
let g:airline#extensions#virtualenv#enabled = 1
" }}}

" Ale {{{
let g:ale_set_highlights = 1
" let g:ale_completion_enabled = 1
let b:ale_set_balloons = 1
let g:ale_cache_executable_check_failures = 1
let g:ale_change_sign_column_color = 1
let g:ale_cursor_detail = 0
" let g:ale_keep_list_window_open = 0
" let g:ale_lint_delay = 400
let g:ale_lint_on_enter = 1
let g:ale_lint_on_filetype_changed = 1
" let g:ale_lint_on_insert_leave = 0
" let g:ale_lint_on_save = 1
" let g:ale_lint_on_text_changed = 0
let g:ale_linters = {
    \ 'typescript': ['tsserver', 'tslint', 'typecheck'],
    \ 'javascript': ['standard'],
    \ 'go': ['gometalinter', 'gofmt'],
\ }
let g:ale_fix_on_save = 0
let g:ale_fixers = {
    \ 'typescript': ['tslint'],
    \ 'javascript': ['standard'],
    \ 'html': [],
\ }
let g:ale_go_gometalinter_options = '--fast'
let g:ale_javascript_eslint_options = '--no-color'
let g:ale_open_list = 'on_save'
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
    au!
    au BufWinLeave * silent! lclose
    au QuitPre * if empty(&buftype) | lclose | endif
augroup END
"  }}}

" DelimitMate {{{
let delimitMate_no_esc_mapping=1    " Esc Issue Fix
" }}}

" EditorConfig {{{
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
" }}}

" Far {{{
" let g:far#source = 'rg'
" let g:far#source = 'agnvim'
let g:far#source = 'rgnvim'
" let g:far#auto_preview = 0
" let g:far#debug = 1
" }}}

" Fugitive {{{
nmap <leader>? :Gstatus<cr>
" }}}

" FZF {{{
if has('nvim')
    nmap <c-t> :FZF<cr>
    let $FZF_DEFAULT_OPTS .= ' --inline-info'

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
" nnoremap <F7> :GundoToggle<CR>
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
let g:neotags_verbose = 1
let g:neotags_find_tool = 'rg --files'
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

" Add your own custom formats or override the defaults
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

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

" Surround {{{
let g:surround_{char2nr('-')} = '<% \r %>'
let g:surround_{char2nr('=')} = '<%= \r %>'
let g:surround_{char2nr('8')} = '/* \r */'
let g:surround_{char2nr('s')} = ' \r '
let g:surround_{char2nr('^')} = '/^\r$/'
let g:surround_indent = 1
" }}}

" Tagbar {{{
let defdir='~/.nvim/deffile/'
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
    " let &diffexpr='EnhancedDiff#Diff("git diff", \"--diff-algorithm=patience")'
    let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=histogram")'
endif
" }}}

" vim-ctrlspace {{{
" let g:CtrlSpaceSetDefaultMapping=0
let s:aCtrlSpaceCacheDir='~/.nvim/tmp/ctrlspacecache/'
if !isdirectory(expand(s:aCtrlSpaceCacheDir))
    call mkdir(expand(s:aCtrlSpaceCacheDir), 'p')
endif
let g:CtrlSpaceCacheDir = expand(s:aCtrlSpaceCacheDir)
" let g:CtrlSpaceSearchTiming = 0
" [FIX] vim-ctrlspace plugin defaults to terminal mapping of <nul>
" nmap <c-space> <nul>
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
" if executable('ag')
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
" let g:gutentags_modules = ['ctags', 'gtags_cscope']
let g:gutentags_project_root = ['.root']
" let g:gutentags_auto_add_gtags_cscope = 0
let g:gutentags_ctags_executable_javascript = 'jsctags'
" let g:gutentags_ctags_executable_javascript = 'ctags'
let g:gutentags_ctags_executable_typescript = 'ctags'
" let g:gutentags_ctags_executable_typescript = 'tstags'
" function! gutentags#build_default_job_options(module) abort
    " let l:job_opts = {
                " \ 'detach': 1,
                " \'on_exit': function(
                " \    '<SID>nvim_job_exit_wrapper',
                " \    ['gutentags#'.a:module.'#on_job_exit']),
                " \'on_stdout': function(
                " \    '<SID>nvim_job_out_wrapper',
                " \    ['gutentags#default_io_cb']),
                " \'on_stderr': function(
                " \    '<SID>nvim_job_out_wrapper',
                " \    ['gutentags#default_io_cb'])
                " \}
    " return l:job_opts
" endfunction
augroup plug_gutentags
    au!
    au FileType gitcommit,gitrebase,startify let g:gutentags_enabled=0
augroup END

if &diff
    let g:gutentags_enabled = 0
endif
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
    au FileType javascript JsPreTmpl html
    au FileType typescript JsPreTmpl markdown
augroup END
" }}}

" vim-jsdoc {{{
" let g:jsdoc_default_mapping=0
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
" let g:NERDTreeLimitedSyntax = 1
" let g:NERDTreeFileExtensionHighlightFullName = 1
" let g:NERDTreeExactMatchHighlightFullName = 1
" let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
" let g:NERDTreeHighlightFoldersFullName = 1
" }}}

" vim-polyglot {{{
let g:polyglot_disabled = ['javascript', 'typescript']

" vim-json
" let g:vim_json_syntax_conceal=0
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
    let git = 'git -C ' . getcwd()
    let dirname = system(git . ' rev-parse --abbrev-ref HEAD')
    return '   ' . (strchars(dirname) > 0 ? ('  ' .substitute(dirname, '[[:cntrl:]]', '', 'g')) : getcwd())
endfunction

let g:startify_lists = [
    \ { 'type': 'files',                    'header': ['   MRU']                },
    \ { 'type': 'dir',                      'header': [s:get_project_name()]    },
    \ { 'type': 'sessions',                 'header': ['   Sessions']           },
    \ { 'type': 'bookmarks',                'header': ['   Bookmarks']          },
    \ { 'type': 'commands',                 'header': ['   Commands']           },
    \ { 'type': function('s:list_commits'), 'header': ['   Commits']            }
\ ]

let s:startify_tmp_header_01 = [
\ '                                                                    ,t',
\ '              ;t                                                  1;1',
\ '               f1f1i                                          it ,,,t',
\ '                11t:. t                                    1t    i i',
\ '                ::,:   , ..                             ;,         f',
\ '                 Gf1i..     t1                       i;            .',
\ '                 ff;;,....     :1                 :t              i',
\ '                 ,...::,,.        1              .                C',
\ '                  fti;,,.           i          ,                 .',
\ '                  .i:.:...           ,       .L                  ;',
\ '                   0::,..,,.          i      .                  t',
\ '                    C.;.::..           .     i                 i',
\ '                      0fi;:..,;.        L  ;.        :..  ,. G       ,;:',
\ '          i1C:;G,t,t,,Ci....;i,..i.            ...: , i..   L;1        titi',
\ '          :LC:iG;1:CiLi, , .,f:;:.1 ,.       ..:i., :.:.               fff',
\ '           G.:LCL,ff1.,        ..;.i.:1;   ,,,.,. . :.,    . .,.      ,G',
\ '             C,i1.i.    :00G         ,i,  ..i;,  .    tGG;   ,  ,     ;',
\ '               ;0080008000GG0G0Giif::.t ,;:  ;.   iiGGG00G0G0CG0GGG;',
\ '                ,000GG80CG88800000C1i1;1i1;;,.,  1CGGG0i0000GG00GGGC',
\ '              108GL0GGLtt80GG0G0G0GLGCti1ttii::..GGGG0G0GGC00CLCCC0GC',
\ '            tCGCfCitt1i;LLC00GG80GGCLG0L1ti    ,:CG00G00CL1LtfGCLL1fGGC8.',
\ '         GtL:fGLtti:i1CtitL000000GCffLC1t;  :,   iGGGG000CLtLCC1ttfCLtC:  i',
\ '        0C:ttCt,i;:,i;,ifLGC8000C0tLLL1tf1    1 C;;80C00CGLftftt1;ftfGGi    t',
\ '     ,ifCtCi:.    1:1CftLCG00001  LLtfft1i   ,i;.LLCiLf8000CtCfL;LCffiCi    .:t',
\ '   ;GGCtCCfG      fftfLGG0GitG,   GLCLLf,C10  ;;;i.  :Lf1, 0G008G1Lf1fGi     iit.1',
\ ' ;GfCC011fCf1Lt1,,111000i,;fC     ;G0f;G0L80G,: 1i     ;  0 G0i80G00GG1. ,::1,ffff;0',
\ 'tfLCLGC;fffGLG1tfff0G0GGC f11      Gf00G0L00000,C     ti;iL1Cf0 1t.:. ;ii;t    ;f .L G',
\ '                           L1f    Gt008000000000 f    ii,:',
\ '                             :    0f000008008000f     .',
\ '                                 iC00G000iG00000Ct.',
\ '                                 :C;C0GG00t00000Cf',
\ '                                  C;f00800;08000Li',
\ '                                  tf LG00f LGGtfC:',
\ '                                       ;L0C;    ;',
\ '                                   ;.,;.  L    .C',
\ '                                    t.;i; ,f:, L',
\ '                                     L,CGL LLi.',
\ '                                      ii1i0C;1,',
\ '                                      f1;  :;',
\ '                                       Li  11',
\ '                                        tftG',
\ '                                         i:',
\ '                                         :;',
\ ' ,
\ ' ,
\ ]

let s:startify_tmp_header_02 = [
\ ' ',
\ ' ',
\ '                     .ed\"\"\"\" \"\"\"$$$$be.',
\ '                   -\"           ^\"\"**$$$e.',
\ '                 .\"                   \"$$$c',
\ '                /                      \"4$$b',
\ '               d  3                      $$$$',
\ '               $  *                   .$$$$$$',
\ '              .$  ^c           $$$$$e$$$$$$$$.',
\ '              d$L  4.         4$$$$$$$$$$$$$$b',
\ '              $$$$b ^ceeeee.  4$$ECL.F*$$$$$$$',
\ '  e$\"\"=.      $$$$P d$$$$F $ $$$$$$$$$- $$$$$$',
\ ' z$$b. ^c     3$$$F \"$$$$b   $\"$$$$$$$  $$$$*\"      .=\"\"$c',
\ '4$$$$L        $$P\"  \"$$b   .$ $$$$$...e$$        .=  e$$$.',
\ '^*$$$$$c  %..   *c    ..    $$ 3$$$$$$$$$$eF     zP  d$$$$$',
\ '  \"**$$$ec   \"   %ce\"\"    $$$  $$$$$$$$$$*    .r\" =$$$$P\"\"',
\ '        \"*$b.  \"c  *$e.    *** d$$$$$\"L$$    .d\"  e$$***\"',
\ '          ^*$$c ^$c $$$      4J$$$$$% $$$ .e*\".eeP\"',
\ '             \"$$$$$$\"\"$=e....$*$$**$cz$$\" \"..d$*\"',
\ '               \"*$$$  *=%4.$ L L$ P3$$$F $$$P\"',
\ '                  \"$   \"%*ebJLzb$e$$$$$b $P\"',
\ '                    %..      4$$$$$$$$$$ \"',
\ '                     $$$e   z$$$$$$$$$$%',
\ '                      \"*$c  \"$$$$$$$P\"',
\ '                       .\"\"\"*$$$$$$$$bc',
\ '                    .-\"    .$***$$$\"\"\"*e.',
\ '                 .-\"    .e$\"     \"*$c  ^*b.',
\ '          .=*\"\"\"\"    .e$*\"          \"*bc  \"*$e..',
\ '        .$\"        .z*\"               ^*$e.   \"*****e.',
\ '        $$ee$c   .d\"                     \"*$.        3.',
\ '        ^*$E\")$..$\"                         *   .ee==d%',
\ '           $.d$$$*                           *  J$$$e*',
\ '            \"\"\"\"\"                              \"$$$\"',
\ ' ',
\ ' ',
\ ]

let s:startify_tmp_header_03 = [
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
if exists('+termguicolors')
    set termguicolors
endif
let g:startify_custom_header = s:startify_tmp_header_03
" let g:startify_custom_header = s:startify_center_header(s:startify_tmp_header_03)
augroup plug_startify
    au!
    " Set Header Color/Style to Comment
    au ColorScheme * highlight link StartifyHeader Comment
    au User Startified setlocal buflisted
augroup END
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
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '-'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'
let g:signify_sign_changedelete      = '*'
nmap <leader>gj <plug>(signify-next-hunk)<CR>
nmap <leader>gk <plug>(signify-prev-hunk)<CR>
nmap <leader>gd :SignifyDiff<CR>
nmap <leader>gf :SignifyFold<CR>
" }}}

" vim-signature {{{
let g:SignatureMarkerTextHLDynamic = 1
" }}}

" UltiSnips {{{
let g:UltiSnipsUsePythonVersion=3
let g:UltiSnipsExpandTrigger = '<nop>'
let g:ulti_expand_or_jump_res = 0
function ExpandSnippetOrCarriageReturn()
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
        return snippet
    else
        return "\<CR>"
    endif
endfunction
inoremap <expr> <CR> pumvisible() ? "\<C-R>=ExpandSnippetOrCarriageReturn()\<CR>" : "\<CR>"
" }}}

" YouCompleteMe {{{
" let g:loaded_youcompleteme = 1
" autocmd FileType c nnoremap <buffer> <silent> <C-]> :YcmCompleter GoTo<cr>
nnoremap <leader>yjd :YcmCompleter GoTo<CR>
nnoremap <leader>yjt :YcmCompleter GoToType<CR>
nnoremap <leader>yjr :YcmCompleter GoToReferences<CR>
nnoremap <leader>ygt :YcmCompleter GetType<CR>
nnoremap <leader>yoi :YcmCompleter OrganizeImports<CR>
" let g:ycm_cache_omnifunc=1                            ' Potential Cause Lag
let g:ycm_key_list_select_completion = ['<TAB>']
let g:ycm_key_list_previous_completion = ['<S-TAB>']
let g:ycm_key_list_stop_completion = ['<C-y>', '<UP>', '<DOWN>']
let g:ycm_use_ultisnips_completer = 1
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
let g:ycm_path_to_python_interpreter=g:python3_host_prog
let g:ycm_python_binary_path=g:python3_host_prog
" }}}

"-------------------------------------------------------------------------------
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" => Color Scheme {{{
"-------------------------------------------------------------------------------
" airline doesn't behave when set before Vundle:Config
let s:fmColorSchemeLight='solarized8_high'
" let s:fmColorSchemeLight='solarized8_flat'
let s:fmColorSchemeDark='OceanicNext'
" let g:ayucolor='light'
" let s:fmColorSchemeLight='ayu'

function! s:setColorScheme()
    " $ITERM_PROFILE variable requires (Iterm Shell integration) Toolset
    if $ITERM_PROFILE =~? 'Night'
        set background=dark
        let g:airline_theme='oceanicnext'
        let g:oceanic_next_terminal_bold = 1
        let g:oceanic_next_terminal_italic = 1
        execute 'colorscheme '.s:fmColorSchemeDark
    else
        set background=light
        " let g:airline_theme = 'ayu'
        let g:airline_theme = 'solarized'
        let g:solarized_visibility = 'high'
        let g:solarized_diffmode = 'high'
        let g:solarized_termtrans = 1
        let g:solarized_term_italics = 1
        let g:solarized_old_cursor_style=1
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


