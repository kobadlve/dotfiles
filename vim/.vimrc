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

" NERDTree
let file_name = expand('%')
if has('vim_starting') &&  file_name == ''
  autocmd VimEnter * NERDTree ./
endif
let NERDTreeShowHidden = 1
nmap <Leader><Tab> <C-w>w
if argc() == 0
  let g:nerdtree_tabs_open_on_console_startup = 1
end

" Neomake
autocmd! BufEnter,BufWritePost * Neomake
let g:neomake_python_enabled_makers = ['python', 'flake8']
" unite
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>

" neo complete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1

if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns._ = '\h\w*'

" -- Settitngs --
set encoding=utf-8
set fileencoding=utf-8

syntax on " Color scheme

set number

set cursorline      " Highlight line number
hi clear CursorLine

set spell " Spell check
set spelllang=en,cjk

set laststatus=2 " status line

set nowrap

set pumheight=10

set ignorecase
set smartcase
set incsearch
set hlsearch
set backspace=2

" Indent
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent

set splitbelow
set splitright

" emacs
imap <c-e> <end>
imap <c-a> <home>
imap <c-d> <del>

" python
autocmd filetype python setl autoindent
autocmd filetype python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd filetype python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4

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
