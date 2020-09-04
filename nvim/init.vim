"===============================================================================
" Maintainer Franky Martinez <frankymartz@gmail.com>
" Version 1.0.0
" Note
" To start nvim without using this .nvimrc file, use:
"     nvim -u NORC
"
" To start nvim without loading any .nvimrc or plugins, use:
"     nvim -u NONE
"
" Sections
" => General
" => Text, Tab and Indent
" => Mapping
" => Search
" => FileType
" => Window
" => Plug-Vim
" => Helper Functions
" => File and Backup
" => Color and Font
" => Plug:Configuration
" => Color Scheme
" => Destroy
"
"===============================================================================
"=> General {{{
"-------------------------------------------------------------------------------
set encoding=utf-8
scriptencoding=utf-8
" let &shell='/usr/bin/env zsh --login'

if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable                 " Enable Syntax Highlighting
  " syntax on                   " Enable Syntax Highlighting–Allow VIM override
endif

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
set ruler                       " Show line/column position number
set number                      " Show line number in front of each line
set cmdheight=1                 " Set command bar to 1 line
set complete-=i                 " Disable Included Files autocomplete Search
set laststatus=2                " Always display the statusline in all windows
set display+=lastline           " Show as much of lastline of text as possible
set updatetime=300              " ms to update SWAP files
set shortmess+=c                " No ins completion menu give messages

set regexpengine=0              " [0, automatic], [1, oldengine], [2 NFA engine]
set maxmempattern=5000          " Max Mem (in KB) allowed for pattern matching

if !&scrolloff
  set scrolloff=1               " Number of lines to keep above/below cursor
endif
if !&sidescrolloff
  set sidescrolloff=5
endif


set notimeout
if !has('nvim') && &ttimeoutlen == -1
  " Timeout on key codes but not mappings. Make terminal nvim work sanely
  set ttimeout
  set ttimeoutlen=100
endif

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
set wildignore+=*.o,*.obj,*.exe,*.dmanifest         " compiled object files
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

let g:python_host_prog='/usr/bin/python2'
let g:python3_host_prog='/usr/bin/python3'
" Direct Neovim to NPM 'neovim' package install
let g:node_host_prog=systemlist('/usr/local/bin/npm root -g')[0].'/neovim/bin/cli.js'


" Enable Project Based Configuration
set exrc
set secure

"-------------------------------------------------------------------------------
" }}}
"------------------------------------------------------------------------------- 

"-------------------------------------------------------------------------------
" => Text, Tab and Indent {{{
"-------------------------------------------------------------------------------
set formatoptions=qrn1j         " Pasted Content Handling
set autoindent                  " Always set autoindenting on
set smartindent                 " Smart autoindenting when starting on newline
set smarttab                    " Smart autoindent w/shiftwidth or {soft}tabstop
set shiftround                  " Round indent to multiple of 'shiftwidth'
set nowrap                      " Don't wrap text to textwidth
set linebreak                   " Don't break words in two if wrap is enabled
set textwidth=80                " Max width of text to be inserted
set tabstop=2                   " Number of spaces a <tab> equals
set wrapmargin=0
set shiftwidth=2
set softtabstop=2
set expandtab
set conceallevel=1              " Enable Code Conceal
set concealcursor="nc"          " Show concealed chars in cursorline

set listchars=tab:▸\ ,eol:¬,trail:…,extends:❯,precedes:❮

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
inoremap <ScrollWheelLeft> <Left>
inoremap <ScrollWheelRight> <Right>
nnoremap <M-h> 20zh
nnoremap <M-l> 20zl

" Switch (previous,next) Buffer
nnoremap <leader>kk :bnext<CR>
nnoremap <leader>jj :bprevious<CR>
nnoremap <leader>hh :tabprevious<CR>
nnoremap <leader>ll :tabnext<CR>

" " Copy to clipboard
vnoremap <leader>y "+y
nnoremap <leader>Y "+yg_
nnoremap <leader>y "+y

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
nnoremap <Tab> >>
nnoremap <S-Tab> <<
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
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <leader><space> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
else
  nnoremap <silent> <leader><space> :noh<cr>
endif

" Strip all trailing whitespace in current buffer
" nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<cr>

" Terminal Commands
if exists(':tnoremap')  " Neovim
  tnoremap <Leader>e <C-\><C-n>
endif

" Location List - Open/Close
" noremap <silent><leader>eo :lopen<cr>
" noremap <silent><leader>ec :lclose<cr>

nnoremap <silent> <Leader>1 :call s:LoadComponentTypeFile('.ts')<CR>
nnoremap <silent> <Leader>2 :call s:LoadComponentTypeFile('.scss')<CR>
nnoremap <silent> <Leader>3 :call s:LoadComponentTypeFile('.html')<CR>

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

" Load matchit.vim, but only if the user hasn't installed a newer version.
if (
  \ !exists('g:loaded_matchit')
  \ && findfile('plugin/matchit.vim', &runtimepath) ==# ''
\)
  runtime! macros/matchit.vim
endif


"-------------------------------------------------------------------------------
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" => FileType {{{
"-------------------------------------------------------------------------------

" Blade {{{
augroup ft_blade
  au!
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
  au BufNewFile,BufRead *.coffee    setlocal filetype=coffee
  au BufNewFile,BufRead *.js.coffee setlocal filetype=coffee
augroup END
" }}}

" CSS, SASS, Stylus, LESS  {{{
augroup ft_css
  au!
  au BufNewFile,BufRead *.css   setlocal filetype=css
  au BufNewFile,BufRead *.scss  setlocal filetype=scss
  au BufNewFile,BufRead *.sass  setlocal filetype=sass
  au BufNewFile,BufRead *.less  setlocal filetype=less
  au BufNewFile,BufRead *.styl  setlocal filetype=stylus
  " au FileType css set omnifunc=csscomplete#CompleteCSS

  au FileType scss,sass,less,css setlocal foldmethod=marker foldmarker={,}
  " Make {<cr> insert a pair of brackets in such a way that the cursor is
  " correctly positioned inside of them AND the following code doesn't get
  " unfolded.
  " au FileType css inoremap <buffer> {<cr> {}<left><cr><space><space><space><space>.<cr><esc>kA<bs>
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

" Docker {{{
augroup ft_dotenv
  au!
  au BufRead,BufNewFile *.Dockerfile setlocal filetype=Dockerfile
augroup END
" }}}

" DotEnv {{{
augroup ft_dotenv
  au!
  au BufRead,BufNewFile *.env setlocal filetype=sh.env
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
augroup END
" }}}

" HTML {{{
augroup ft_html
  au!
  au FileType html setlocal foldmethod=syntax
augroup END
" }}}

" JavaScript {{{
augroup ft_javascript
  au!
  au BufNewFile,BufRead *.js      setlocal filetype=javascript
  au BufNewFile,BufRead *.jsx     setlocal filetype=javascript.jsx
  au BufNewFile,BufRead *.es6     setlocal filetype=javascript
  au BufNewFile,BufRead *.spec.js setlocal filetype=javascript.spec
  " au FileType javascript setlocal foldmethod=marker foldmarker={,}
  " au FileType javascript inoremap <buffer> {<cr> {}<left><cr><space><space><space><space>.<cr><esc>kA<bs>
  " au FileType javascript set omnifunc=javascriptcomplete#CompleteJS
augroup END
" }}}

" JSON {{{
augroup ft_json
  au!
  au BufNewFile,BufRead *.json  setlocal filetype=json
  au BufNewFile,BufRead *.jsonp setlocal filetype=json
  au FileType json setlocal foldmethod=marker foldmarker={,}
augroup END
" }}}

" Markdown {{{
augroup ft_markdown
  au!
  au BufNewFile,BufRead *.md        setlocal filetype=markdown
  au BufNewFile,BufRead *.markdown  setlocal filetype=markdown
  au FileType markdown setlocal wrap linebreak nolist spell
augroup END
" }}}

" Mustache {{{
augroup ft_mustache
  au!
  au BufNewFile,BufRead *.mustache setlocal filetype=mustache
augroup END
" }}}

" Nginx {{{
augroup ft_nginx
  au!
  au BufRead,BufNewFile /etc/nginx/conf/*                       setlocal ft=nginx
  au BufRead,BufNewFile /etc/nginx/sites-available/*            setlocal ft=nginx
  au BufRead,BufNewFile /usr/local/etc/nginx/sites-available/*  setlocal ft=nginx
  au BufRead,BufNewFile vhost.nginx                             setlocal ft=nginx
  au FileType nginx setlocal foldmethod=marker foldmarker={,}
augroup END
" }}}

" PHP {{{
augroup ft_php
  au!
  au BufNewFile,BufRead *.php setlocal filetype=php
  au FileType php setlocal ts=4 sts=4 sw=4
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
  au FileType python setlocal ts=4 sts=4 sw=4 define=^\s*\\(def\\\\|class\\)
  au FileType man nnoremap <buffer> <cr> :q<cr>
  au FileType python if exists("python_space_error_highlight") |
    \ unlet python_space_error_highlight |
  \ endif
  au FileType python iabbrev <buffer> afo assert False, 'Okay'
augroup END
" }}}

" Ruby {{{
augroup ft_ruby
  au!
  au BufRead,BufNewFile Capfile setlocal filetype=ruby
  au FileType ruby setlocal foldmethod=syntax
augroup END
" }}}

" Text {{{
augroup ft_text
  au!
  au BufRead,BufNewFile *.txt setlocal filetype=text
  au FileType text setlocal spell textwidth=80 colorcolumn=1
augroup END
" }}}

" TypeScript {{{
augroup ft_typescript
  au!
  au BufRead,BufNewFile *.ts  setlocal filetype=typescript
  au BufRead,BufNewFile *.tsx setlocal filetype=typescriptreact
  au FileType typescript setlocal cocu="" foldmethod=syntax
augroup END
" }}}

" SQL {{{
augroup ft_sql
  au!
  au BufNewFile,BufRead *.sql setlocal filetype=sql
  au FileType sql setlocal foldmethod=indent commentstring=--\ %s comments=:--
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
  au BufRead,BufNewFile *.vim setlocal filetype=vim
  au FileType vim setlocal foldmethod=marker
  au FileType help setlocal textwidth=78
augroup END
" }}}

" XML {{{
augroup ft_xml
  au!
  au BufNewFile,BufRead *.rss setlocal filetype=xml
  au FileType xml setlocal foldmethod=syntax
  " au FileType xml setlocal foldmethod=manual
augroup END
" }}}

" VIMRC {{{
augroup ft_vimrc
  au!
  au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
  " Disable Line Numbers in Terminal
  au TermOpen * setlocal nonumber norelativenumber
  " Save when losing focus
  " au FocusLost * :silent! wa
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
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
    \ execute 'normal! g`"zvzz' |
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

noremap <silent>[og :set scrollbind cursorbind<CR>
noremap <silent>]og :set noscrollbind nocursorbind<CR>

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

let s:dotfileRoot=expand('$HOME/.dotfiles/nvim/tmp')
let s:projectRoot=projectroot#guess()
let s:isGitRepository=isdirectory(s:projectRoot . '/.git')

"-------------------------------------------------------------------------------
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" => Helper Functions {{{
"-------------------------------------------------------------------------------

" function! NcmsTag()
    " let randId = system('openssl rand -base64 24')
    " let randId = substitute(randId, '\n$', '', '')
    " return ' data-ncms-uuid="' . randId . '"'
" endfunction
" nnoremap <leader>nc "=NcmsTag()<cr>p<esc>

function! s:getNeovimTempDir()
  if s:isGitRepository
    let gitNvimDir=expand(s:projectRoot . '/.git/nvim//')
    if !isdirectory(gitNvimDir)
      call mkdir(gitNvimDir, 'p')
    endif
    return gitNvimDir
  endif
  return s:dotfileRoot
endfunction

function! s:LoadComponentTypeFile(fileType) abort
  let fileName=expand('%:r')
  " Check if Component. Ignore Case
  if fileName =~? '\.component$' && type(a:fileType) == v:t_string
      execute 'find ' . fileName . a:fileType
      echo expand('%')
  else
    echohl WarningMsg
    echo 'File Does NOT match Component Name Scheme. (component.{html,ts,scss})'
    echohl None
  endif
endfunction

" Manage DOS EOL files
function! s:ConvertDosFileEOL(toDOS) abort
  update " Save any Changes
  " Edit file again, using dos fileformat ('fileformats' ignored)
  execute 'edit ++ff=dos'
  if a:toDOS
    setlocal fileformat=dos
  else
    setlocal fileformat=unix " Buffer will use LF-only EOL when written
  endif
  write
endfunction
" Create commands for Buffer utilization
command! DosToUnix :call s:ConvertDosFileEOL(0)
command! UnixToDos :call s:ConvertDosFileEOL(1)

function! s:VerifyOnBattery()
  if has('macunix')
    return match(system('pmset -g batt'), "Now drawing from 'Battery Power'") != -1
  elseif has('unix')
    return readfile('/sys/class/power_supply/AC/online') == ['0']
  endif
  return 0
endfunction

command! FormatJSON :%!python -m json.tool

"-------------------------------------------------------------------------------
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" => File and Backup {{{
"-------------------------------------------------------------------------------
let s:tempDir=s:getNeovimTempDir()

set termencoding=utf-8          " Encoding used for the terminal
set fileformats=unix
set fileformat=unix
set sessionoptions-=options     " Do not save options in mksession

set undofile
set backup                                  " Enable Backups

"set noswapfile                             " It's 2014 NeoVim
let &backupskip='/tmp/*,/private/tmp/*'
let &undodir=expand(s:tempDir . '/undo//')          " Undo files
let &backupdir=expand(s:tempDir . '/backup//')      " Backup files
let &viewdir=expand(s:tempDir . '/view//')          " View files
let &directory=expand(s:tempDir . '/swap//')        " Swap files
let &tags='./tags,tags'

" Create directories if they do not exist
if !isdirectory(&undodir)
  call mkdir(&undodir, 'p')
endif
if !isdirectory(&backupdir)
  call mkdir(&backupdir, 'p')
endif
if !isdirectory(&viewdir)
  call mkdir(&viewdir, 'p')
endif
if !isdirectory(&directory)
  call mkdir(&directory, 'p')
endif

"-------------------------------------------------------------------------------
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" => Color and Font {{{
"-------------------------------------------------------------------------------

if has('termguicolors')
  set termguicolors             " Set True Colors in Terminal
else
  let base16colorspace=256      " Access colors present in 256 colorspace
endif

if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=16                   " Allow colorSchemes bright colors wo/force bold
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
  let g:ackprg='rg --vimgrep '
  command Todo Rg TODO:|FIXME:|XXXX:|NOTE:|BUG:|CHANGED:|OPTIMIZE:
elseif executable('ag')
  let g:ackprg='ag --vimgrep '
endif
" }}}

" Airline {{{
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
let g:airline#extensions#default#section_truncate_width={
  \ 'b': 140,
  \ 'x': 140,
\ }
let g:airline#extensions#tabline#ignore_bufadd_pat='gundo|undotree|vimfiler|tagbar|nerd_tree|startify'

" Airline : Ale ================================================================
let g:airline#extensions#ale#enabled=1

" Airline : Coc ================================================================
let g:airline#extensions#coc#enabled=1
let g:airline_section_error='%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning='%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

" Airline : CtrlSpace ==========================================================
let g:CtrlSpaceUseTabline=0
let g:airline#extensions#ctrlspace#enabled=1
let g:airline#extensions#ctrlp#show_adjacent_modes=1
let g:CtrlSpaceStatuslineFunction='airline#extensions#ctrlspace#statusline()'

" Airline : CursorMode =========================================================
" let g:airline#extensions#cursormode#enabled=1

" Airline : Fugitive ===========================================================
let g:airline#extensions#fugitiveline#enabled=1

" Airline : Git ================================================================
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#branch#format=1
let g:airline#extensions#branch#empty_message=''
let g:airline#extensions#branch#sha1_len=10
let g:airline#extensions#branch#displayed_head_limit=10

" Airline : Hunks ==============================================================
let g:airline#extensions#hunks#enabled=1
let g:airline#extensions#hunks#non_zero_only=0

" Airline : Signify ============================================================
let g:airline#extensions#hunks#enabled=1
let g:airline#extensions#hunks#non_zero_only=0
let g:airline#extensions#hunks#hunk_symbols=['+', '~', '-']

" Airline : TabLine ============================================================
let g:airline#extensions#tabline#enabled=1  " Auto display all buffers
let g:airline#extensions#tabline#buffers_label='buffer'
let g:airline#extensions#tabline#tabs_label='tab'
let g:airline#extensions#tabline#current_first=1
let g:airline#extensions#tabline#show_tabs=1
let g:airline#extensions#tabline#show_splits=1
let g:airline#extensions#tabline#buffer_min_count=1
let g:airline#extensions#tabline#fnamecollapse=1
let g:airline#extensions#tabline#formatter='unique_tail_improved'

" Airline : VirtualEnv =========================================================
let g:airline#extensions#virtualenv#enabled=1

" Airline : Vista ==============================================================
let g:airline#extensions#vista#enabled = 1

" Airline : WhiteSpace =====================================================
let g:airline#extensions#whitespace#enabled=1
let g:airline#extensions#whitespace#checks=[
  \ 'indent',
  \ 'trailing',
  \ 'long',
  \ 'mixed-indent-file',
\ ]
let g:airline#extensions#whitespace#max_lines=20000
let g:airline#extensions#whitespace#show_message=1
let g:airline#extensions#whitespace#trailing_format='trailing[%s]'
let g:airline#extensions#whitespace#mixed_indent_format='mixed-indent[%s]'
let g:airline#extensions#whitespace#long_format='long[%s]'
let g:airline#extensions#whitespace#mixed_indent_file_format='mix-indent-file[%s]'
let airline#extensions#c_like_langs=[
  \ 'c',
  \ 'cpp',
  \ 'cuda',
  \ 'go',
  \ 'javascript',
  \ 'typescript',
  \ 'ld',
  \ 'php',
\ ]

" Airline : WindowSwap =====================================================
let g:airline#extensions#windowswap#indicator_text='WS'
" }}}

" Ale {{{
let g:ale_cache_executable_check_failures=1
let g:ale_cursor_detail=0 " Use (coc.nvim) codelens
let g:ale_completion_enabled=0 " Use coc.nvim autocomplete

" let g:ale_disable_lsp=1 " Push from coc.nvim
" let g:ale_lint_on_save=1
" let g:ale_lint_delay=500
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_enter=1
" let g:ale_lint_on_insert_leave=0
" let g:ale_lint_on_filetype_changed=1
" let g:ale_open_list=1
" let g:ale_keep_list_window_open=0

" let g:ale_echo_delay=50

let g:ale_sign_error='✘'
let g:ale_sign_warning=''
let g:ale_sign_highlight_linenrs=1
let g:ale_sign_column_always=1

let g:ale_virtualtext_cursor=1
let g:ale_virtualtext_prefix='  ' " ⌫ ﱥ                 
" let g:ale_virtualtext_delay=50

let g:ale_pattern_options={'\.env$': {'ale_enabled': 0}}
" let g:ale_go_gometalinter_options='--fast'
" let g:ale_javascript_eslint_options='--no-color'

let g:ale_linters={
  \ 'go': ['golangci-lint', 'gofmt'],
  \ 'html': ['stylelint', 'htmlhint', 'tidy'],
  \ 'javascript': ['standard'],
  \ 'javascriptreact': ['eslint'],
  \ 'typescript': ['eslint'],
  \ 'typescriptreact': ['eslint'],
  \ 'css': ['stylelint'],
\ }

let g:ale_fix_on_save=0
" let g:ale_fix_on_save_ignore=['eslint', 'tsserver', 'standard']
" let g:ale_fixers={}

" ALE : LINTER : SQL-LINT
" ale_linters/sql/sqllint.vim
" Author: Joe Reynolds <joereynolds952@gmail.com>
" Description: sql-lint for SQL files

function! AleLinterSqlLint(buffer, lines) abort
    " Matches patterns like the following:
    "
    " stdin:1 [ER_NO_DB_ERROR] No database selected
    let l:pattern = '\v^[^:]+:(\d+) (.*)'
    let l:output = []

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
    " echom l:match[0]
        call add(l:output, {
          \ 'lnum': l:match[1] + 0,
          \ 'col': l:match[2] + 0,
          \ 'type': l:match[3][0],
          \ 'text': l:match[0],
        \})
    endfor

    return l:output
endfunction

call ale#linter#Define('sql', {
  \ 'name': 'sqllint',
  \ 'executable': 'sql-lint',
  \ 'command': 'sql-lint',
  \ 'callback': 'AleLinterSqlLint',
\})

" nmap <leader>t :ALELint<cr>
noremap <silent><leader>ek :ALEPrevious<cr>
noremap <silent><leader>ej :ALENext<cr>
noremap <silent><leader>el :ALELint<cr>
noremap <silent><leader>er :ALEReset<cr>

" Ale : TypeScript =============================================================

augroup plug_ale
  autocmd!
  autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END
"  }}}

" Coc {{{
" let g:coc_enabled=0
let g:coc_force_debug=0 " Make sure COC uses compiled code
let g:coc_node_path = '/usr/local/bin/node'
" let g:coc_force_debug=1

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Coc : Config : Markdown ---------------------------------------------------------------

let g:markdown_fenced_languages=['css', 'js=javascript']

" Coc : Extension ==============================================================
" \ 'coc-ccls',
let g:coc_global_extensions=[
  \ 'coc-actions',
  \ 'coc-angular',
  \ 'coc-clangd',
  \ 'coc-css',
  \ 'coc-cssmodules',
  \ 'coc-elixir',
  \ 'coc-ember',
  \ 'coc-fsharp',
  \ 'coc-go',
  \ 'coc-highlight',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-lit-html',
  \ 'coc-lua',
  \ 'coc-omnisharp',
  \ 'coc-phpls',
  \ 'coc-pyright',
  \ 'coc-python',
  \ 'coc-r-lsp',
  \ 'coc-reason',
  \ 'coc-rls',
  \ 'coc-rust-analyzer',
  \ 'coc-sh',
  \ 'coc-snippets',
  \ 'coc-sourcekit',
  \ 'coc-solargraph',
  \ 'coc-sql',
  \ 'coc-styled-components',
  \ 'coc-svelte',
  \ 'coc-svg',
  \ 'coc-texlab',
  \ 'coc-tsserver',
  \ 'coc-vetur',
  \ 'coc-vimlsp',
  \ 'coc-vimtex',
  \ 'coc-xml',
  \ 'coc-yaml',
\ ]
" \ 'coc-spell-checker',

" Coc : Helper-Functions =======================================================

function! s:check_back_space() abort
  let columnPosition = col('.') - 1
  return !columnPosition || getline('.')[columnPosition - 1]  =~# '\s'
endfunction

" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Coc : Key-Mapping ============================================================
"
" Coc : Multiple Cursors -------------------------------------------------------

"      ﯎ 
" nnoremap <silent> <c-a-p> <Plug>(coc-cursors-position)
" nnoremap <silent> <c-a-w> <Plug>(coc-cursors-word)
" xnoremap <silent> <c-a-w> <Plug>(coc-cursors-range)
" use normal command like `<leader>xi(`
" nnoremap <leader>x  <Plug>(coc-cursors-operator)

" xnoremap <silent> <c-a-n> y/\V<C-r>=escape(@",'/\')<CR><CR>gN<Plug>(coc-cursors-range)gn
" nnoremap <expr> <silent> <c-a-d> <SID>select_current_word()
" function! s:select_current_word()
  " if !get(g:, 'coc_cursors_activated', 0)
  " " Remove extra backslash when un-commenting
    " return \"\<Plug>(coc-cursors-word)"
  " endif
  " return \"*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
" endfunc

" ------------------------------------------------------------------------------

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for go-to
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

inoremap <C-c> <Esc><Esc>

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? '<C-n>' :
      \ <SID>check_back_space() ? '<TAB>' :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? '<C-p>' : '<C-h>'

" inoremap <expr> <cr> pumvisible() ? '<C-y>' : '<C-g>u<CR>'

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Symbol renaming.
nnoremap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nnoremap <leader>f  <Plug>(coc-format-selected)

" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xnoremap <leader>a  <Plug>(coc-codeaction-selected)
nnoremap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nnoremap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nnoremap <leader>qf  <Plug>(coc-fix-current)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nnoremap <silent> <c-a-r> <Plug>(coc-range-select)
xnoremap <silent> <c-a-r> <Plug>(coc-range-select)

" Coc  : coc-snippets ----------------------------------------------------------

"" Use <C-l> for trigger snippet expand.
inoremap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vnoremap <C-j> <Plug>(coc-snippets-select)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'
" use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != '-1' ? '\<C-y>' : '\<C-g>u\<CR>'

" Coc  : coc-actions -----------------------------------------------------------

xnoremap <silent> <leader>ac :<C-u>execute 'CocCommand actions.open ' . visualmode()<cr>
nnoremap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<cr>g@

" Coc  : Auto-Command ==========================================================

augroup plug_coc
   autocmd!
  " au! CompleteDone * if pumvisible() == 0 | pclose | endif
  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup END
" }}}

" DelimitMate {{{
let delimitMate_no_esc_mapping=1    " Esc Issue Fix
" }}}

" EditorConfig {{{
let g:EditorConfig_exclude_patterns=['fugitive://.*']
let g:EditorConfig_disable_rules = ['trim_trailing_whitespace']
" }}}

" Far {{{
let g:far#source='rgnvim'
" }}}

" Fugitive {{{
nnoremap <leader>? :Git<cr>
" }}}

" FZF {{{
if executable('fzf')
  nmap <c-t> :FZF<cr>
  let g:fzf_history_dir='~/.nvim/tmp/fzf-history//'
  let g:fzf_colors={
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

    let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

    " Mappings using CoCList:
    " add_list_source(name, description, command)
    call coc_fzf#common#add_list_source('fzf-buffers', 'display open buffers', 'Buffers')
    " delete_list_source(name)
    call coc_fzf#common#delete_list_source('fzf-buffers')
    " Show all diagnostics.
    nnoremap <silent> <space>a  :<C-u>CocFzfList diagnostics<cr>
    " Manage extensions.
    nnoremap <silent> <space>e  :<C-u>CocFzfList extensions<cr>
    " Show commands.
    nnoremap <silent> <space>c  :<C-u>CocFzfList commands<cr>
    " Find symbol of current document.
    nnoremap <silent> <space>o  :<C-u>CocFzfList outline<cr>
    " Search workspace symbols.
    nnoremap <silent> <space>s  :<C-u>CocFzfList -I symbols<cr>
    " Resume latest coc list.
    nnoremap <silent> <space>p  :<C-u>CocFzfListResume<CR>
else
    " Mappings using CoCList:
    " Show all diagnostics.
    nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
    " Manage extensions.
    nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
    " Show commands.
    nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
    " Find symbol of current document.
    nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
    " Search workspace symbols.
    nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
    " Resume latest coc list.
    nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
endif
" }}}

" Goyo {{{
augroup plug_goyo
  au!
  au! User GoyoEnter nested :setlocal noshowmode scrolloff=999
  au! User GoyoLeave nested :setlocal showmode scrolloff=3
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
" ex. local .nvimrc
" autocmd BufReadPre *.js let b:javascript_lib_use_jquery = 1
" autocmd BufReadPre *.js let b:javascript_lib_use_underscore = 1
" autocmd BufReadPre *.js let b:javascript_lib_use_backbone = 1
" autocmd BufReadPre *.js let b:javascript_lib_use_prelude = 0
" autocmd BufReadPre *.js let b:javascript_lib_use_angularjs = 0
let g:used_javascript_libs=join([
  \ 'jquery',
  \ 'requirejs',
  \ 'underscore',
\ ], ',')
" }}}

" ListToggle {{{
let g:lt_location_list_toggle_map = '<leader>ee'
let g:lt_quickfix_list_toggle_map = '<leader>qq'
" }}}

" markdown-preview.nvim {{{
let g:mkdp_auto_start=0
let g:mkdp_auto_close=1
let g:mkdp_refresh_slow=0
nnoremap <C-p> :MarkdownPreview<cr>
" }}}

" NERDCommenter {{{
let g:NERDMenuMode=0
let g:NERDSpaceDelims=1       " Add spaces after comment delimiters by default
let g:NERDCompactSexyComs=0   " Use compact syntax for multi-line comments
let g:NERDRemoveExtraSpaces=1
let g:NERDTrimTrailingWhitespace=1
let g:NERDToggleCheckAllLines=1

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines=1

" Enable NERDCommenterToggle to check all selected lines is commented or not 
" }}}

" NERDTree {{{
nmap <F8> :NERDTreeToggle<CR>
let NERDTreeAutoDeleteBuffer=1
let NERDTreeBookmarksFile=s:tempDir.'/NERDTreeBookmarks'
let NERDTreeCascadeSingleChildDir=0
let NERDTreeCaseSensitiveSort=1
let NERDTreeUseTCD=1
let NERDTreeChDirMode=2
let NERDTreeHijackNetrw=0 " Startify Session Patch
let NERDTreeQuitOnOpen=2
let NERDTreeWinSize=40
let NERDTreeMinimalUI=1
let NERDTreeNaturalSort=1
let NERDTreeMouseMode=2
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore=[
  \ '\~$', '.*\.pyc$', 'pip-log\.txt$', 'whoosh_index', 'xapian_index',
  \ '.*.pid', 'monitor.py', '.DS_Store', '.*-fixtures-.*.json', '.*\.o$',
  \ 'db.db', 'tags', 'tags.bak', '.*\.pdf$', '.*\.mid$', '.*\.midi$',
  \ '\.DAT$', '\.LOG1$', '\.LOG1$',
  \ 'GPATH', 'GRTAGS', 'GTAGS'
\ ]
augroup plug_nerdtree
  " Quit when NERDTree is only open buffer
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END
" }}}

" NERDTree Git Plugin {{{
let g:NERDTreeGitStatusShowIgnored = 1 " a heavy feature may cost much more time. default: 0
let g:NERDTreeGitStatusUseNerdFonts=1 " you should install nerdfonts by yourself. default: 0
let g:NERDTreeGitStatusShowClean=1 " default: 0
let g:NERDTreeGitStatusConcealBrackets=1 " default: 0
" let g:NERDTreeGitStatusUntrackedFilesMode='all' " a heave feature too. default: normal
let g:NERDTreeGitStatusIndicatorMapCustom={
  \ 'Modified'  : ' ',
  \ 'Staged'    : ' ',
  \ 'Untracked' : ' ',
  \ 'Renamed'   : ' ',
  \ 'Unmerged'  : ' ',
  \ 'Deleted'   : ' ',
  \ 'Dirty'     : ' ',
  \ 'Clean'     : ' ',
  \ 'Ignored'   : ' ',
  \ 'Unknown'   : ' '
\ }
" Redefine NerdTree Git Ignored Icon Color
" hi def link NERDTreeGitStatusModified Tag
hi def link NERDTreeGitStatusIgnored LineNr
hi def link NERDTreeGitStatusDirClean Directory
" }}}

" Scratch {{{
function! ToggleScratchBuffer(scratchType)
  let scr_open=bufwinnr('__Scratch__')
  if scr_open != -1
    execute scr_open . 'close'
  else
    execute a:scratchType
  endif
endfunction

let g:scratch_no_mappings=1
let g:scratch_autohide=0
let g:scratch_insert_autohide=0  
let g:scratch_filetype='markdown'
nnoremap <F12> :call ToggleScratchBuffer('ScratchInsert')<CR>
nnoremap <F24> :call ToggleScratchBuffer('ScratchInsert!')<CR>
vnoremap <F12> :call ToggleScratchBuffer('ScratchSelection')<CR>
vnoremap <F24> :call ToggleScratchBuffer('ScratchSelection!')<CR>

function! s:set_scratch_path()
  if s:isGitRepository
    let g:scratch_persistence_file=s:tempDir.'/scratch.md'
  endif
endfunction

augroup plug_scratch
  au VimEnter * call s:set_scratch_path()
augroup END
" }}}

" Surround {{{
let g:surround_{char2nr('-')}='<% \r %>'
let g:surround_{char2nr('=')}='<%= \r %>'
let g:surround_{char2nr('8')}='/* \r */'
let g:surround_{char2nr('s')}=' \r '
let g:surround_{char2nr('^')}='/^\r$/'
let g:surround_indent=1
" }}}

" vim-devicons {{{
let g:webdevicons_enable=1
let g:webdevicons_enable_vimfiler=1
let g:WebDevIconsUnicodeGlyphDoubleWidth=1
let g:WebDevIconsUnicodeDecorateFolderNodes=1
let g:DevIconsEnableFoldersOpenClose=1
let g:DevIconsEnableFolderPatternMatching=1
let g:DevIconsEnableFolderExtensionPatternMatching=0
let g:WebDevIconsUnicodeDecorateFolderNodesExactMatches=1

let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols={}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['mjs']=''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['cjs']=''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['csv'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['tsv'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['graphql'] = ''

let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols={} " needed
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['\%(.*\)*\.\%(spec\|test\)\.\%(ts\|tsx\|js\|es6\|jsx\)$']='' "  
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['\%(.*\.\)*\.stories\.\%(ts\|tsx\|js\|es6\|jsx\)$']='' "     
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['\%(.*\.\)*\.module\.\%(ts\|tsx\|js\|es6\|jsx\)$']=' '
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['\%(.*\.\)*\.service\.\%(ts\|tsx\|js\|es6\|jsx\)$']='ﰩ'
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['\%(.*\.\)*\.component\.\%(ts\|tsx\|js\|es6\|jsx\)$']=''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['\%(.*\.\)*\.d\.\%(ts\|tsx\|js\|es6\|jsx\)$']=''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['\%(.*\.\)*\.data\.\%(ts\|tsx\|js\|es6\|jsx\)$']=''


"    簾               ﰩ          襁  
"    ﯤ            
" 

" let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['package\%(-lock\)\?\.json']=''
" TODO: Validate REGEX in Assignment
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['tsconfig\%(\..*\)\?\.json']=''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['\%(tslint\|eslint\)\?\.json']=''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*\.js\%(\..\+\)\?\.map$']='慎'
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['\%(.*\.\)*Dockerfile\%(\..*\)*']=''

let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['.dockerignore']=''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['.git']=''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['node_modules']=''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['.gitconfig']=''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['.gitignore']=''

<

" vimDevIcon: NERDTree
let g:webdevicons_enable_nerdtree=1
let g:webdevicons_conceal_nerdtree_brackets=1
let g:WebDevIconsNerdTreeAfterGlyphPadding=' '
let g:WebDevIconsNerdTreeBeforeGlyphPadding=''
let g:WebDevIconsNerdTreeGitPluginForceVAlign=1
" vimDevIcon: Airline
let g:webdevicons_enable_airline_tabline=1
let g:webdevicons_enable_airline_statusline=1
" vimDevIcon: CtrlP
let g:webdevicons_enable_ctrlp=1
let g:webdevicons_enable_flagship_statusline=1
" }}}

" vim-delve {{{
let g:delve_backend='native'
let g:delve_cache_path=expand('~/.nvim/tmp/vim-delve//')
if !isdirectory(g:delve_cache_path)
  call mkdir(g:delve_cache_path, 'p')
endif
" }}}

" vim-diff-enhanced {{{
if &diff
  let &diffexpr='EnhancedDiff#Diff("git diff", \"--diff-algorithm=patience")'
  " let &diffexpr='EnhancedDiff#Diff("git diff", '--diff-algorithm=histogram')'
endif
" }}}

" vim-ctrlspace {{{
let g:CtrlSpaceCacheDir=expand(s:tempDir . '/ctrlspacecache//')
if !isdirectory(g:CtrlSpaceCacheDir)
  call mkdir(g:CtrlSpaceCacheDir, 'p')
endif
let g:CtrlSpaceDefaultMappingKey='<c-space> '
let g:CtrlSpaceUseArrowsInTerm=1
let g:CtrlSpaceUseMouseAndArrowsInTerm=1
let g:CtrlSpaceLoadLastWorkspaceOnStart=0
let g:CtrlSpaceSaveWorkspaceOnSwitch=1
let g:CtrlSpaceSaveWorkspaceOnExit=1
let g:CtrlSpaceHeight=10
if executable('rg')
  let g:CtrlSpaceGlobCommand='rg --hidden --vimgrep --files'
elseif executable('ag')
  let g:CtrlSpaceGlobCommand='/usr/bin/env ag -l --hidden --vimgrep -g ""'
endif
" }}}

" vim-go {{{
" Setting
let g:go_test_show_name=1
let g:go_autodetect_gopath=1
let g:go_fmt_command='goimports'
let g:go_term_mode='split'
let g:go_textobj_include_function_doc=1
" Syntax Highlight
let g:go_highlight_types=1
let g:go_highlight_fields=1
let g:go_highlight_methods=1
let g:go_highlight_functions=1
let g:go_highlight_operators=1
let g:go_highlight_extra_types=1
let g:go_highlight_generate_tags=1
let g:go_highlight_build_constraints=1
let g:go_highlight_variable_assignments=1
let g:go_highlight_variable_declarations=1

let g:go_highlight_space_tab_error=1
let g:go_highlight_chan_whitespace_error=1
let g:go_highlight_array_whitespace_error=1
" Shortcuts
if isdirectory(expand('$GOPATH/src/github.com/golang/lint/misc/vim'))
  set runtimepath+=$GOPATH/src/github.com/golang/lint/misc/vim
endif
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file=expand('%')
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

" GraphQL{{{
augroup plug_graphql
  au BufNewFile,BufRead *.prisma setfiletype graphql
augroup END
" }}}

" vim-javascript {{{
let g:javascript_plugin_jsdoc=1
let g:javascript_plugin_ngdoc=1
let g:javascript_plugin_flow=1
let g:javascript_conceal_function='ƒ'
let g:javascript_conceal_null='ø'
let g:javascript_conceal_this='@'
let g:javascript_conceal_return='⇚'
let g:javascript_conceal_undefined='¿'
let g:javascript_conceal_NaN='ℕ'
let g:javascript_conceal_prototype='¶'
let g:javascript_conceal_static='•'
let g:javascript_conceal_super='Ω'
let g:javascript_conceal_arrow_function='⇒'
" }}}

" vim-jsdoc {{{
nmap <leader>jsd :JsDoc<CR>
let g:jsdoc_additional_descriptions=1
let g:jsdoc_input_description=1
let g:jsdoc_allow_input_prompt=1
let g:jsdoc_access_descriptions=1
let g:jsdoc_underscore_private=1
let g:jsdoc_param_description_separator=' - '
let g:jsdoc_enable_es6=1
" }}}

" vim-jsx {{{
let g:jsx_ext_required=0 " Allow JSX in normal JS files
" }}}

" vim-jsx-pretty {{{
let g:vim_jsx_pretty_highlight_close_tag=1
let g:vim_jsx_pretty_colorful_config=1
let g:vim_jsx_pretty_template_tags=[
  \ 'html',
  \ 'jsx',
  \ 'tsx',
  \ 'typescriptreact',
  \ 'javascriptreact',
\ ]
" }}}

" vim-move {{{
let g:move_key_modifier='C-A'
" }}}

" vim-multiple-cursors {{{
" let g:multi_cursor_exit_from_visual_mode=0
" }}}

" vim-nerdtree-syntax-highlight {{{
let g:NERDTreeHighlightFolders=1 " enables folder icon highlighting using exact match
" }}}

" vim-polyglot {{{
" let g:polyglot_disabled=[
  " \ 'typescript',
  " \ 'typescriptreact',
" \ ]
" \ 'csv',
" }}}

" vim-signature {{{
let g:SignatureMarkerTextHLDynamic=1
let g:SignatureMap={
  \ 'Leader'            : 'm',
  \ 'PlaceNextMark'     : 'm,',
  \ 'ToggleMarkAtLine'  : 'm.',
  \ 'PurgeMarksAtLine'  : 'm-',
  \ 'DeleteMark'        : '<Leader>dm',
  \ 'PurgeMarks'        : '<Leader>m<Space>',
  \ 'PurgeMarkers'      : '<Leader>m<Del>',
  \ 'GotoNextLineAlpha' : "m']",
  \ 'GotoPrevLineAlpha' : "m'[",
  \ 'GotoNextSpotAlpha' : 'm`]',
  \ 'GotoPrevSpotAlpha' : 'm`[',
  \ 'GotoNextLineByPos' : "m]'",
  \ 'GotoPrevLineByPos' : "m['",
  \ 'GotoNextSpotByPos' : 'm]`',
  \ 'GotoPrevSpotByPos' : 'm[`',
  \ 'GotoNextMarker'    : 'm]-',
  \ 'GotoPrevMarker'    : 'm[-',
  \ 'GotoNextMarkerAny' : 'm]=',
  \ 'GotoPrevMarkerAny' : 'm[=',
  \ 'ListBufferMarks'   : '<Leader>m/',
  \ 'ListBufferMarkers' : '<Leader>m?'
\ }
" }}}

" vim-signify {{{
" let g:signify_realtime=1 " autocmd User Fugitive SignifyRefresh
let g:signify_sign_add='+'
let g:signify_sign_delete='-'
let g:signify_sign_delete_first_line='‾'
let g:signify_sign_change='~'
let g:signify_sign_changedelete='*'
nnoremap <leader>gj <plug>(signify-next-hunk)<CR>
nnoremap <leader>gk <plug>(signify-prev-hunk)<CR>
nnoremap <leader>gd :SignifyDiff<CR>
nnoremap <leader>gf :SignifyFold<CR>
nnoremap <leader>gu :SignifyHunkUndo<CR>
" }}}

" vim-startify {{{
let g:startify_use_env=1
let g:startify_change_to_dir=0
let g:startify_change_to_vcs_root=1
let g:startify_padding_left=3
let g:startify_skiplist=[
  \ 'COMMIT_EDITMSG',
  \ escape(fnamemodify(resolve($VIMRUNTIME), ':p'), '\') .'doc',
  \ 'bundle/.*/doc',
  \ '/\.git/index$',
\ ]

function! StartifyEntryFormat()
  return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
endfunction

function! s:startify_center_header(lines) abort
  let longest_line=max(map(copy(a:lines), 'strwidth(v:val)'))
  let centered_lines=map(copy(a:lines),
    \ 'repeat(" ", (longest_line / 5)) . v:val')
  " \ 'repeat(" ", (&columns / 2) + longest_line + (longest_line / 10)) . v:val')
  " \ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
  return centered_lines
endfunction

function! s:list_commits()
  let git='git -C ' . s:projectRoot
  let commits=systemlist(git .' log --oneline | head -n5')
  let git='G'. git[1:]
  return map(commits, '{"line": "  " . matchstr(v:val, "\\s\\zs.*"), "cmd": "'. git .' show ". matchstr(v:val, "^\\x\\+") }')
endfunction

function! s:get_project_name()
  if !s:isGitRepository
    return '   ' . '  ' . s:projectRoot
  endif
  let git='git -C ' . s:projectRoot
  let dirname=system(git . ' rev-parse --abbrev-ref HEAD')
  return '   ' . (strchars(dirname) > 0 ? ('  ' .substitute(dirname, '[[:cntrl:]]', '', 'g')) : s:projectRoot)
endfunction

let g:startify_lists=[
  \ { 'type': 'files',      'header': ['   ﮟ  GLOBAL: MRU']                },
  \ { 'type': 'dir',        'header': [s:get_project_name() . ': MRU']  },
  \ { 'type': 'sessions',   'header': ['   Sessions']                   },
  \ { 'type': 'bookmarks',  'header': ['   Bookmarks']                  },
  \ { 'type': 'commands',   'header': ['   Commands']                   },
\ ]

if s:isGitRepository
  call add(
    \ g:startify_lists,
    \ { 'type': function('s:list_commits'), 'header': ['     Commits'] }
  \ )
endif


" let g:startify_lists = [
  " \ { 'type': 'files',                    'header': ['   MRU']              },
  " \ { 'type': 'dir',                      'header': [s:get_project_name()]  },
  " \ { 'type': 'sessions',                 'header': ['   Sessions']         },
  " \ { 'type': 'bookmarks',                'header': ['   Bookmarks']        },
  " \ { 'type': 'commands',                 'header': ['   Commands']         },
  " \ { 'type': function('s:list_commits'), 'header': ['   Commits']          }
" \ ]
let g:startify_custom_header=[
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

" vim-unimpaired {{{
noremap <silent>[og :set scrollbind cursorbind<CR>
noremap <silent>]og :set noscrollbind nocursorbind<CR>
" }}}

" YATS {{{
let g:yats_host_keyword=1
" }}}

" Vista {{{
nnoremap <F9> :Vista!!<CR>
let g:vista_sidebar_width=40
let g:vista_icon_indent= ['┗━ ', '┣━ ']
let g:vista_default_executive='coc'
let g:vista_fzf_preview=['right:50%']
let g:vista#renderer#enable_icon=1
let g:vista_echo_cursor_strategy='both'
" }}}
"-------------------------------------------------------------------------------
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" => Color Scheme {{{
"-------------------------------------------------------------------------------
" airline doesn't behave when set before Vundle:Config
let s:colorSchemeLight='solarized8'
let s:colorSchemeDark='base16-materia'

" let g:airline_theme='solarized'
let g:solarized_visibility='normal'
let g:solarized_diffmode='normal'
let g:solarized_termtrans=0
let g:solarized_statusline='normal'
let g:solarized_italics=1
let g:solarized_old_cursor_style=0
let g:solarized_enable_extra_hi_groups=1


" $ITERM_PROFILE variable requires (Iterm Shell integration) Toolset
if $ITERM_PROFILE =~? 'Night'
  let &background='dark'
  exe 'colorscheme ' . s:colorSchemeDark
else
  let &background='light'
  exe 'colorscheme ' . s:colorSchemeLight
endif

function! s:ToggleBackground()
  let fmShade=&background =~? 'dark' ? 'light' : 'dark'
  let fmColorScheme=fmShade =~?'dark' ? s:colorSchemeDark : s:colorSchemeLight
  let &background=fmShade
  exe 'colorscheme ' . fmColorScheme
  unlet fmShade
  unlet fmColorScheme
endfunction

command! ToggleBg call s:ToggleBackground()
nnoremap <leader>bg :ToggleBg<CR>

"-------------------------------------------------------------------------------
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" => Destroy {{{
"-------------------------------------------------------------------------------

" unlet s:tempDir

"-------------------------------------------------------------------------------
" }}}
"-------------------------------------------------------------------------------
