set nocompatible                " choose no compatibility with legacy vi
syntax enable
set encoding=utf-8
set showcmd                     " display incomplete commands
set nu

if &term == "xterm-256color"
  set t_Co=256
endif

colorscheme myterm
set noeb vb t_vb=               " disable beep of dead

" Plugins 
filetype off                    " For plugins

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'


"---------=== Code/project navigation ===-------------

Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'rizzatti/dash.vim'


Plugin 'Townk/vim-autoclose'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'airblade/vim-gitgutter'

" --- Python ---
Plugin 'klen/python-mode'
Plugin 'mitsuhiko/vim-jinja'
Plugin 'mitsuhiko/vim-python-combined'

" --- html ---
Plugin 'mattn/emmet-vim'

" --- Gui ---

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

call vundle#end()
filetype on
filetype plugin on
filetype plugin indent on

"" Plugin config 
" nerdtree
map <C-n> :NERDTreeToggle<CR>
"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode



autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8
      \ formatoptions=croqj softtabstop=4 textwidth=74 comments=:#\:,:#

"=====================================================
"" Python-mode settings
"=====================================================

" документация
" let g:pymode_doc = 0
let g:pymode_doc_key = 'K'
" " проверка кода
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
let g:pymode_lint_ignore="E501,W601,C0110"
" " провека кода после сохранения
let g:pymode_lint_write = 1
"
" " поддержка virtualenv
let g:pymode_virtualenv = 1
"
" " установка breakpoints
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'
"
" " подстветка синтаксиса
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
"
" " отключить autofold по коду
let g:pymode_folding = 0
"
" " возможность запускать код
let g:pymode_run = 0

" Disable choose first function/method at autocomplete
let g:jedi#popup_select_first = 0

autocmd FileType python map <buffer> <leader>8 :PymodeLint<CR>

" emmet

let g:user_emmet_install_global = 0
autocmd FileType html,htmljinja EmmetInstall

" airline

set laststatus=2
let g:airline_theme = 'solarized'


" template language support (SGML / XML too)
" " ------------------------------------------
" " and disable that stupid html rendering (like making stuff bold etc)
autocmd FileType xml,html,htmljinja,htmldjango setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType html setlocal commentstring=<!--\ %s\ -->
autocmd FileType htmljinja setlocal commentstring={#\ %s\ #}
let html_no_rendering=1
let g:syntastic_html_checkers = []


"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

"" backups
set backupdir=~/.vim/backup/
set directory=~/.vim/swap/
set undodir=~/.vim/undo/
"" binds
" disable arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
noremap <Ctrl> <Esc>


