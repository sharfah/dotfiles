set nocompatible        " vim, not vi
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set noerrorbells        " don't make noise
set cursorline          " highlight current line
set laststatus=2        " always show the status line
set expandtab           " no real tabs please!
set number              " Display line numbers on the left
set showcmd             " Show partial commands in the last line of the screen
set ignorecase          " case insensitive search, except when using capitals
set smartcase           " case insensitive patterns, when lowercase is used
set smarttab            " smart tabulation and backspace
set autoindent
set showmode            " Show the current mode
set showmatch           " show matching braces
set hlsearch            " highlight searches
set incsearch           " find as you type
set title               " show title
set pastetoggle=<F11>   " F11 toggles indenting when pasting
set wildmenu            " make command-line completion bash like + menu
set wildmode=longest:full
set showcmd             " show the cmd being typed
set shiftwidth=4        " No 8 character tabs
set softtabstop=4
set undolevels=1000     " 1000 undos
 
" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
 
"F10 toggles line numbers
map <silent> <F10> :set invnumber<cr>
 
syntax on