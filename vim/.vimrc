if !&compatible
  set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

" -- dein --
" dein settings {{{
" Install dein
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.vim') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath

" Load Plugin
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/.vim/.dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif

" Install Plugin
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" }}}

" Launch NERDTree
let file_name = expand('%')
if has('vim_starting') &&  file_name == ''
  autocmd VimEnter * NERDTree ./
endif

" neomake
autocmd! BufEnter,BufWritePost * Neomake
let g:neomake_python_enabled_makers = ['python', 'flake8']

" -- Settitngs --
set encoding=utf-8
set fileencoding=utf-8

syntax on " Color scheme

set number

set cursorline      " Highlight line number
hi clear CursorLine

set spell " Spell check
set spelllang=en,cjk "日本語を除外

set laststatus=2 " status line

set nowrap

set pumheight=10

set ignorecase
set smartcase
set incsearch
set hlsearch

" Indent
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent

set mouse=a

set whichwrap=b,s,h,l,<,>,[,],~

inoremap jj <Esc> " jj -> ESC

" Swap colon <-> semicolon
noremap ; :
noremap : ;

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

nnoremap Y y$  " Yank

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

autocmd BufWritePre * :%s/\s\+$//ge " Delete Extra space

if exists('$TMUX') " setting on tmux
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

if !has('gui_running') " Modify lag when switch mode.
    set timeout timeoutlen=1000 ttimeoutlen=50
endif

" -- END --
