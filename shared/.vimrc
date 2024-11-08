" Vim Settings

" Make Vim more useful
set nocompatible

" Vundle
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
"Plugin 'ascenator/L9', {'name': 'newL9'}

Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'edkolev/promptline.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'mhinz/vim-signify'
Plugin 'rodjek/vim-puppet'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" Use the Solarized Dark theme
"set background=dark
"colorscheme solarized
"let g:solarized_termtrans=1

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
"set clipboard=unnamed
" Enhance command-line completion
"set wildmenu
" Allow cursor keys in insert mode
"set esckeys
" Allow backspace in insert mode
"set backspace=indent,eol,start
" Optimize for fast terminal connections
"set ttyfast
" Add the g flag to search/replace by default
"set gdefault
" Use UTF-8 without BOM
"set encoding=utf-8 nobomb
" Change mapleader
"let mapleader=","
" Don’t add empty newlines at the end of files
"set binary
"set noeol
" Centralize backups, swapfiles and undo history
"set backupdir=~/.vim/backups
"set directory=~/.vim/swaps
"if exists("&undodir")
"	set undodir=~/.vim/undo
"endif

" Don’t create backups when editing files in certain directories
"set backupskip=/tmp/*,/private/tmp/*

" Respect modeline in files
"set modeline
"set modelines=4
" Enable per-directory .vimrc files and disable unsafe commands in them
"set exrc
"set secure
" Enable line numbers
set number
" Enable syntax highlighting
syntax on
" Highlight current line
"set cursorline
" Make tabs as wide as four spaces
set tabstop=4
" Make shift widths as wide as four spaces
set shiftwidth=4
" Do not expand tabs
set noexpandtab
" Show “invisible” characters
"set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
"set list
" Highlight searches
set hlsearch
" Ignore case of searches
"set ignorecase
" Highlight dynamically as pattern is typed
"set incsearch
" Always show status line
set laststatus=2
" Enable mouse in all modes
"set mouse=a
" Disable error bells
"set noerrorbells
" Don’t reset cursor to start of line when moving around.
"set nostartofline
" Show the cursor position
"set ruler
" Don’t show the intro message when starting Vim
"set shortmess=atI
" Show the current mode
"set showmode
" Show the filename in the window titlebar
"set title
" Show the (partial) command as it’s being typed
"set showcmd
" Use relative line numbers
if exists("&relativenumber")
	set relativenumber
	au BufReadPost * set relativenumber
endif
" Start scrolling three lines before the horizontal window border
"set scrolloff=3

" Override Python syntax settings
augroup my_python_settings
	autocmd!
	autocmd FileType python setlocal noexpandtab
	autocmd FileType python setlocal sw=4
	autocmd FileType python setlocal ts=4
augroup END

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Automatic commands
if has("autocmd")
	" Enable file type detection
	filetype on
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
	" Treat .md files as Markdown
	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif

" Airline settings
let g:airline_powerline_fonts=1
set t_Co=256
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Syntastic settings
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_enable_puppet_checker = 1
let g:syntastic_puppet_checkers=['puppetlint']
let g:syntastic_python_checkers = ['python', 'pylint']
let g:syntastic_yaml_checkers = ['yamllint']
let g:syntastic_shell = 'zsh'

" Syntastic options - default file types
autocmd BufRead,BufNewFile *.pp set filetype=puppet

" Promptline settings
let g:promptline_preset={
	\'a': [ promptline#slices#python_virtualenv() ],
	\'b': [ '\t', promptline#slices#user() ],
	\'c': [ promptline#slices#cwd() ],
	\'z': [ promptline#slices#vcs_branch(), promptline#slices#git_status() ],
	\'warn': [ promptline#slices#last_exit_code() ]}
