set guifont=Menlo:h13
syntax enable
set background=light
let g:solarized_termcolors=256
colorscheme solarized

source ~/.vim/plugin/to-github.vim
source ~/.vim/plugin/gist.vim

filetype indent on

set nocompatible
set nobackup
set directory^=~/.vim/swap//

" basic config
set number
set ruler
set laststatus=2
set sw=2 ts=2 sts=2 et
" allow to hide unsaved buffers
set hidden
" enable mouse (for terminals that support it)
set mouse=a

" multiple files
set winminheight=0
set winminwidth=0

" Indentation
set smartindent
set autoindent

" Matching brackets
set showmatch
runtime! macros/matchit.vim

" tab completion mode
set wildmenu
set wildmode=list:longest,full

" Search config
set incsearch
set ignorecase
set hlsearch

" support mouse on multiple files on vim
set ttymouse=xterm2
set mouse=a
set mousefocus

set encoding=utf8
set tenc=utf8

if &modifiable
  set fileencoding=utf8
  set ff=unix
endif

" Disable F1 from opening the help
" I can type :help perfectly fine, thank you very much
imap <F1> <Esc>
nmap <F1> <Esc>

" disable search highlight until the next search
nmap <silent> <Leader><Leader> :nohls<CR>

" buffer-navigation (analogous to tab-navigation)
nmap gb :bn<CR>
nmap gB :bp<CR>

" switchers
nmap <silent> <Leader>n :set number!<CR>
nmap <Leader>i :set ignorecase!<CR>:set ignorecase?<CR>
nmap <Leader>w :set wrap!<CR>:set wrap?<CR>

" use system registry by default
set clipboard=unnamed

syntax on
filetype plugin indent on

augroup MyAutoCommands
  " Clear old autocmds in group
  autocmd!

  " File types
  autocmd BufRead,BufNewFile *.haml                               setfiletype haml
  autocmd BufRead,BufNewFile *.sass,*.scss                        setfiletype sass
  autocmd BufRead,BufNewFile config.ru,Gemfile,Isolate,Thorfile   setfiletype ruby
  autocmd BufRead,BufNewFile *.py                                 setfiletype python
  autocmd BufRead,BufNewFile *.liquid,*.mustache                  setfiletype liquid

  " Ruby files
  autocmd FileType ruby,eruby,      set sw=2 ts=2 sts=2 et
  autocmd FileType ruby,eruby,      imap <buffer> <CR> <C-R>=RubyEndToken()<CR>

  " HTML/HAML
  autocmd FileType html,haml   set shiftwidth=2 softtabstop=2 expandtab

  " Javascript
  autocmd FileType javascript  set shiftwidth=4 softtabstop=4 expandtab

  " CSS
  autocmd FileType sass,css    set shiftwidth=2 softtabstop=2 expandtab

  " Other langs
  autocmd FileType python,php  set shiftwidth=4 tabstop=4 softtabstop=4 expandtab

  " Vim files
  autocmd FileType     vim     set shiftwidth=2 softtabstop=2 expandtab
  autocmd BufWritePost .vimrc  source $MYVIMRC

  " Auto-wrap text in all buffers
  autocmd BufRead,BufNewFile * set formatoptions+=t
augroup END

" show tabs as blank-padded arrows, trailing spaces as middle-dots
set list
set listchars=tab:\ \ ,trail:·
" set listchars=tab:·,trail:·

" Pathogen
execute pathogen#infect()
syntax on
filetype plugin indent on

" vim-go
let g:go_disable_autoinstall = 1
let g:go_fmt_autosave = 1
