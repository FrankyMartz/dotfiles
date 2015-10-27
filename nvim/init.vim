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
" => General {{{
"-------------------------------------------------------------------------------

syntax enable                   " Enable Syntax Highlighting
set autoread                    " Automatically read externally changes to file
set autowriteall                " Automatically write to file if modified
set history=1000                " Remember more commands and search history
set undolevels=1000             " Use many levels of undo
set undoreload=10000            " Save whole buffer for undo when reloading it

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

set splitbelow
set splitright

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

" Always use system clipboard for ALL operations
"set clipboard+=unnamedplus

" }}}

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
set noswapfile                          " It's 2014 NeoVim
set backupskip=/tmp/*,/private/tmp/*
set undodir=~/.nvim/tmp/undo//          " Undo files
set backupdir=~/.nvim/tmp/backup//      " Backup files
set viewdir=~/.nvim/tmp/view//          " View files
set directory=~/.nvim/tmp/swap//        " Swap files

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

" }}}

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

set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮

" }}}

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
vnoremap <leader>y "*y
noremap <leader>p :silent! set paste<cr>"*p:set nopaste<cr>

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
" -> move cursore to eol
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

" }}}

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

" }}}

"-------------------------------------------------------------------------------
" => FileType {{{
"-------------------------------------------------------------------------------

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

" HTML {{{
augroup ft_html
    au!
    au FileType html setlocal ts=2 sts=2 sw=2 expandtab
augroup END
" }}}

" Blade {{{
augroup ft_blade
    au!
    au FileType blade setlocal ts=2 sts=2 sw=2 expandtab
    au BufNewFile,BufRead *.blade setlocal filetype=blade
augroup END
" }}}

" Mustache {{{
augroup ft_mustache
    au!
    au FileType mustache setlocal ts=2 sts=2 sw=2 expandtab
    au BufNewFile,BufRead *.mustache setlocal filetype=mustache
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
    au FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
    "au FileType javascript setlocal foldmethod=marker foldmarker={,}
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

" }}}

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

" }}}

"-------------------------------------------------------------------------------
" => Plug-Vim {{{
"-------------------------------------------------------------------------------
source ~/.nvim/vimplugrc

" }}}

"-------------------------------------------------------------------------------
" => Color and Font {{{
"-------------------------------------------------------------------------------
set guifont=Menlo:h11

set synmaxcol=500              " Don't highlight lines longer than
set colorcolumn=80              " Column number to highlight

hi DiffAdd term=reverse cterm=bold ctermbg=darkgreen ctermfg=black
hi DiffChange term=reverse cterm=bold ctermbg=gray ctermfg=black
hi DiffText term=reverse cterm=bold ctermbg=blue ctermfg=black
hi DiffDelete term=reverse cterm=bold ctermbg=darkred ctermfg=black
hi CursorLine cterm=NONE ctermbg=black ctermfg=NONE guibg=black guifg=NONE

" }}}

"-------------------------------------------------------------------------------
" => Plug:Configuration {{{
"-------------------------------------------------------------------------------

" Fugitive {{{
nmap <leader>? :Gstatus<cr>
" }}}

" Airline {{{
set laststatus=2        " Always display the statusline in all windows
set noshowmode          " Hide default mode text
let g:airline_powerline_fonts=0
"let g:airline#extensions#tabline#enabled=1  " Automatically displays all buffers
"let g:airline#extensions#tabline#buffer_min_count=2
"let g:airline#extensions#tabline#fnamemod = ':t'
"let g:airline#extensions#tabline#formatter='unique_tail_improved'
"let g:airline#extensions#tabline#left_sep=' '
"let g:airline#extensions#tabline#buffer_nr_show=1
"let g:airline#extensions#tabline#buffer_nr_format='[%s]'
"let g:airline#extensions#tabline#buffer_idx_mode=1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
if !exists('g:airline_symbols')
      let g:airline_symbols = {}
endif
" unicode symbols
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.branch = '⑂'
let g:airline_symbols.paste = '↯'
let g:airline_symbols.whitespace = 'Ξ'
" }}}

" CtrlP {{{
" Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site|node_modules|bower_components)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}

" Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in version
" control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'r'

" Use a leader instead of the actual named binding
"nmap <leader>p :CtrlP<cr>
nmap <c-p> :CtrlP<cr>

" Easy bindings for its various modes
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>
" }}}

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

" Surround {{{
let g:surround_{char2nr('-')} = '<% \r %>'
let g:surround_{char2nr('=')} = '<%= \r %>'
let g:surround_{char2nr('8')} = '/* \r */'
let g:surround_{char2nr('s')} = ' \r '
let g:surround_{char2nr('^')} = '/^\r$/'
let g:surround_indent = 1
" }}}

" Gundo {{{
nnoremap <F7> :GundoToggle<CR>
" }}}

" DelimitMate {{{
let delimitMate_no_esc_mapping=1    " Esc Issue Fix
" }}}

" Tagbar {{{
nmap <F9> :TagbarToggle<CR>
" }}}

" NERDTree {{{
augroup nerdtree
    " Quit when NERDTree is only open buffer
    au bufenter * if (winnr("$") == 1 && exists('b:NERDTreeType') && b:NERDTreeType == 'primary') | q | endif
augroup END
nmap <F8> :NERDTreeToggle<CR>
let NERDTreeChDirMode=2
let NERDTreeBookmarksFile=expand("~/.nvim/tmp/NERDTreeBookmarks")
let NERDTreeMouseMode=2
let NERDTreeMinimalUI=1
let NERDTreeAutoDeleteBuffer=1
let NERDTreeIgnore = ['\~$', '.*\.pyc$', 'pip-log\.txt$', 'whoosh_index',
                        \ 'xapian_index', '.*.pid', 'monitor.py',
                        \ '.*-fixtures-.*.json', '.*\.o$', 'db.db', 'tags.bak',
                        \ '.*\.pdf$', '.*\.mid$', '.*\.midi$']
" }}}

" NERDTree Git Plugin {{{
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "❍", 
    \ "Staged"    : "●",
    \ "Untracked" : "△",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "=",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "☐",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }
" }}}

" Syntastic {{{
let g:syntastic_auto_jump=1
let g:syntastic_auto_loc_list=1
let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd']
"let g:syntastic_javascript_checkers=['jsxhint', 'flow']
let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_check_on_wq=0
let g:syntastic_error_symbol='✘'
let g:syntastic_warning_symbol='▲'
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute " ,"trimming empty <", "unescaped &" , "lacks \"action", "is not recognized!", "discarding unexpected"]
" }}}

" YouCompleteMe {{{
autocmd FileType c nnoremap <buffer> <silent> <C-]> :YcmCompleter GoTo<cr>
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_autoclose_preview_window_after_completion=1
" pyenv
let g:ycm_path_to_python_interpreter = '/usr/local/bin/python'
" }}}

" UltiSnips {{{
let g:UltiSnipsExpandTrigger='<c-k>'
let g:UltiSnipsJumpForwardTrigger='<c-k>'
let g:UltiSnipsJumpBackwardTrigger='<s-c-j>'
" }}}

" javascript-libraries-syntax {{{
let g:used_javascript_libs = 'jquery,underscore,requirejs'
autocmd BufReadPre *.jsx let b:javascript_lib_use_react=1
autocmd BufReadPre *.jsx let b:javascript_lib_use_flux=1
autocmd BufReadPre *.js let b:javascript_lib_use_angularjs = 1
autocmd BufReadPre *[sS]pec.js let b:javascript_lib_use_angularjs = 1
" }}}

" vim-jsdoc {{{
let g:jsdoc_default_mapping=0
let g:jsdoc_allow_input_prompt=1
nmap <leader>l :JsDoc<CR>
" }}}

" vim-json {{{
let g:vim_json_syntax_conceal=0
" }}}

" vim-flow {{{
" Use Syntastic instead. (vim-flow) includes autocompletion so keep around.
let g:flow#enable = 0
" }}}

" Splice {{{
let g:splice_initial_layout_grid=1
let g:splice_initial_scrollbind_grid=1
let g:splice_initial_scrollbind_loupe=1
let g:splice_initial_scrollbind_compare=1
let g:splice_initial_diff_grid=1
let g:splice_initial_diff_compare=1
let g:splice_wrap='nowrap'
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

" vim-gitgutter {{{
nmap <Leader>hs <Plug>GitGutterStageHunk
nmap <Leader>hr <Plug>GitGutterRevertHunk
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk
" }}}

" vim-livedown {{{
let g:livedown_autorun = 0  " Auto-Open Preview on markdown
let g:livedown_open = 1     " Open Browser on Preview
let g:livedown_port = 1337  " Browser Port
nnoremap <silent><F14> :LivedownPreview<CR>
" }}}

" goyo {{{
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
" }}}

" }}}

"-------------------------------------------------------------------------------
" => Color Scheme {{{
"-------------------------------------------------------------------------------
" airline doesn't behave when set before Vundle:Config
let base16colorspace=256        " Access colors present in 256 colorspace
colorscheme base16-eighties
"colorscheme base16-codeschool
set background=dark             " Set ColorScheme Flavor
"set background=light             " Set ColorScheme Flavor

function! s:ToggleBackground()
    let fmShade = &background == "dark" ? "light" : "dark"
    let fmColorScheme = &background == "dark" ? "base16-default" : "base16-eighties"
    execute "set background=".fmShade
    execute "colorscheme ".fmColorScheme
endfunction

command! ToggleBg call s:ToggleBackground()
nnoremap <silent><F13> :ToggleBg<CR>

" }}}


"-------------------------------------------------------------------------------
" => Work Hacker Functions {{{
"-------------------------------------------------------------------------------

function! NcmsTag()
    let randId = system('openssl rand -base64 24')
    let randId = substitute(randId, '\n$', '', '')
    return ' data-ncms-uuid="' . randId . '"'
endfunction
nnoremap <leader>nc "=NcmsTag()<cr>p<esc>

" }}}
