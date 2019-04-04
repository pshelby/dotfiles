set nocompatible              " be iMproved, required
filetype off                  " required

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
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
"Plugin 'edkolev/promptline.vim'
Plugin 'mhinz/vim-signify'
"Plugin 'file:///Users/pshelby/Documents/git_repos/vim-puppet'

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

" General settings
syntax on
"set noexpandtab
set hlsearch
set number
set relativenumber
set ts=2
set sw=2
autocmd BufWritePre * :%s/\s\+$//e
"augroup my_python_settings
"	autocmd!
"	"autocmd FileType python setlocal noexpandtab
"	autocmd FileType python setlocal sw=4
"	autocmd FileType python setlocal ts=4
"augroup END

" Only do this part when compiled with support for autocommands
if has("autocmd")
	augroup redhat
	" In text files, always limit the width of text to 78 characters
	autocmd BufRead *.txt set tw=78
	" When editing a file, always jump to the last cursor position
	autocmd BufReadPost *
	\ if line("'\"") > 0 && line ("'\"") <= line("$") |
	\   exe "normal! g'\"" |
	\ endif
	augroup END
endif

"scrooloose/syntastic' Airline settings
set laststatus=2
let g:airline_powerline_fonts = 1

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Syntastic settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_perl_checker = 1
let g:syntastic_enable_puppet_checker = 1
let g:syntastic_enable_python_checker = 1
let g:syntastic_perl_checkers = ['perl']
let g:syntastic_puppet_checkers=['puppetlint']
let g:syntastic_python_checkers = ['python', 'pylint', 'pydocstyle', 'pycodestyle']
"let g:syntastic_python_checkers = ['pylint']
let g:syntastic_xml_checkers = ['xmllint']
let g:syntastic_yaml_checkers = ['yamllint']
let g:syntastic_shell = 'ksh'

" Syntastic options - default file types
autocmd BufRead,BufNewFile ~/Documents/git_repos/etdash/scripts/TABLES/* set filetype=perl
autocmd BufRead,BufNewFile ~/Documents/git_repos/nagiosplug/libcfg/ad.nagios.cfg/service/* set filetype=perl
autocmd BufRead,BufNewFile ~/Documents/git_repos/nagiosplug/libcfg/ad.nagios.cfg/xml/* set filetype=perl
autocmd BufRead,BufNewFile ~/Documents/git_repos/nagiosplug/libexec/wpm.cfg set filetype=perl
autocmd BufRead,BufNewFile *.pp set filetype=puppet

" Promptline settings
"" sections (a, b, c, x, y, z, warn) are optional
""let g:promptline_preset = 'full'
""let g:promptline_preset = {
""        \'a' : [ promptline#slices#python_virtualenv() ],
""        \'b' : [ promptline#slices#host() ],
""        \'c' : [ promptline#slices#user() ],
""        \'x' : [ promptline#slices#cwd() ],
""        \'y' : [ promptline#slices#vcs_branch() ],
""        \'warn' : [ promptline#slices#last_exit_code() ]}
"let g:promptline_preset = {
"	\'a': [ promptline#slices#python_virtualenv() ],
"	\'b': [ '\t', promptline#slices#user() ],
"	\'c': [ promptline#slices#cwd() ],
"	\'z' : [ promptline#slices#vcs_branch(), promptline#slices#git_status() ],
"	\'warn' : [ promptline#slices#last_exit_code() ]}
"
"" available slices:
"" 	promptline#slices#cwd() - current dir, truncated to 3 dirs. To configure: promptline#slices#cwd({ 'dir_limit': 4 })
"" 	promptline#slices#vcs_branch() - branch name only. By default, only git branch is enabled. Use promptline#slices#vcs_branch({ 'hg': 1, 'svn': 1, 'fossil': 1}) to enable check for svn, mercurial and fossil branches. Note that always checking if inside a branch slows down the prompt
"" 	promptline#slices#last_exit_code() - display exit code of last command if not zero
"" 	promptline#slices#jobs() - display number of shell jobs if more than zero
"" 	promptline#slices#battery() - display battery percentage (on OSX and linux) only if below 10%. Configure the threshold with promptline#slices#battery({ 'threshold': 25 })
"" 	promptline#slices#host() - current hostname.  To hide the hostname unless connected via SSH, use promptline#slices#host({ 'only_if_ssh': 1 })
"" 	promptline#slices#user()
"" 	promptline#slices#python_virtualenv() - display which virtual env is active (empty is none)
"" 	promptline#slices#git_status() - count of commits ahead/behind upstream, count of modified/added/unmerged files, symbol for clean branch and symbol for existing untraced files
""
"" any command can be used in a slice, for example to print the output of whoami in section 'b':
""       \'b' : [ '$(whoami)'],
""
"" more than one slice can be placed in a section, e.g. print both host and user in section 'a':
""       \'a': [ promptline#slices#host(), promptline#slices#user() ],
""
"" to disable powerline symbols
"" `let g:promptline_powerline_symbols = 0`
