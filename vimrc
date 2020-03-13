"A vimrc file for vim settings
"Creator : Kalyan

" Don't include vi compatibility
set nocompatible
" Don't need modelines and the potential security hazard
set modelines=0

" Default history is only 20
set history=1000
" Use more levels of undo
set undolevels=1000

" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
"set clipboard=unnamed
" Allow cursor keys in insert mode
set esckeys
" Optimize for fast terminal connections
set ttyfast
" Allow backspace in insert mode
set backspace=indent,eol,start

" Setup term color support
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
	set t_Co=256
elseif $TERM == "xterm-true-color"
	" set Vim-specific sequences for RGB colors
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif
" Use the Gruvbox Dark theme
syntax enable
set background=dark
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox

" Expand tab to spaces
set expandtab
" Tab=4-char-block (Here 4 spaces)
set tabstop=4
set softtabstop=4
" Number of spaces to use for autoindenting
set shiftwidth=4
" Use multiple of shiftwidth when indenting with '<' and '>'
"set shiftround
" Insert tabs on the start of a line according to shiftwidth, not tabstop
set smarttab
" Always set autoindenting on
set autoindent
" Copy the previous indentation on autoindenting
set copyindent

" Highlight current line
set cursorline
" Enable line numbers
set number
" Use relative line numbers
if exists("&relativenumber")
	set relativenumber
	au BufReadPost * set relativenumber
endif

" Search Settings
set incsearch   " show search matches as you type
set ignorecase  " case insensitive search
set smartcase   " If a capital letter is included in search, make it case-sensitive
set hlsearch    " dont highlight search results

" Start scrolling three lines before the horizontal window border
set scrolloff=3
" Don’t show the intro message when starting Vim
set shortmess=atI
set shortmess+=O
" Don't beep
set novisualbell
" Disable error bells
set noerrorbells
" Show the filename in the window titlebar
set title
" Show the current mode
set showmode
" Show the (partial) command as it’s being typed
set showcmd
" Enable mouse in all modes
set mouse-=a
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Auto read when a file is changed on disk
set autoread
" set paste! - toggle key
set pastetoggle=<F9>
" split below and right like tmux
set splitbelow splitright
" hide buffers even modified
set hidden

" Enhance command-line completion
set wildmenu

" Show “invisible” characters
set list
set listchars=tab:→\ ,trail:•,eol:¬,nbsp:␣,precedes:«,extends:»

" Always show status line
set laststatus=2
"set statusline=
"set statusline+=%#LineNr#
"set statusline+=%F
"set statusline+=%=
"set statusline+=%y
"set statusline+=\ %p%%
"set statusline+=\ %l:%c
"set statusline+=\ 

highlight CustomColor ctermbg=red ctermfg=white guibg=#592929
match CustomColor /\%81v.\+/

" Centralize backups, swapfiles and undo history
"set backup
set backupdir=~/.vim/backups//
set directory=~/.vim/swaps//
if exists("&undodir")
	set undofile
	set undodir=~/.vim/undo//
endif
" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" Change mapleader
let mapleader=","

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//ge
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

" Allow saving a sudo file if forgot to open as sudo
cmap w!! w !sudo tee % >/dev/null

" Automatic commands
if has("autocmd")
	" Enable file type detection
	filetype on
	" Treat .s files as .sh
	autocmd BufNewFile,BufRead *.s set filetype=sh syntax=sh
	" Turn on spell check for certain filetypes automatically
	autocmd BufRead,BufNewFile *.txt setlocal spell spelllang=en_us
	autocmd FileType gitcommit setlocal spell spelllang=en_us
endif
