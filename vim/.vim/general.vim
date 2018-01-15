""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sections:
"       -> General
"       -> VIM User Interface
"       -> Colors and Fonts
"       -> Files and Backups
"       -> Text, tab and indent related
"       -> Status Line


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Genereal
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use vim settings, rather than vi settings
" must be first, because it changes other options as a side effect
set nocompatible

" Set how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM User Interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Show the line and column number of the cursor position
set ruler
" Height of the command bar
set cmdheight=2
set laststatus=2
" Add a bit extra margin to the left
set foldcolumn=1

set number

" Hide buffers, not close them
set hidden

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Make backspace behave in a sane manner
set backspace=indent,eol,start

" case insensitive search
set ignorecase
set smartcase
set infercase

" Highlight search results
set hlsearch
set incsearch

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set matchtime=2

" lazy file name tab completion
set wildmode=longest,list,full
set wildmenu
set wildignorecase
" ignore files vim doesnt use
set wildignore+=.git,.hg,.svn
set wildignore+=*.aux,*.out,*.toc
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
set wildignore+=*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
set wildignore+=*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
set wildignore+=*.mp3,*.oga,*.ogg,*.wav,*.flac
set wildignore+=*.eot,*.otf,*.ttf,*.woff
set wildignore+=*.doc,*.pdf,*.cbr,*.cbz
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
set wildignore+=*.swp,.lock,.DS_Store,._*

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable syntax highlighting
syntax enable

set background=dark

try
    colorschem=desert
catch
endtry

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

" maintain undo history between sessions
set undofile
set undodir=~/.vim/undo

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use spaces instead of tabs
set expandtab
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4

" enable auto indentation
set autoindent
set smartindent

" Lines longer than the width of the window will wrap
set wrap
set linebreak
set textwidth=500

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tailing chars
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Show tailing whitespaces
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/
