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

" Update Plugin
if has('vim_starting') && dein#check_install()
  call dein#update()
endif

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
map <C-n> <plug>NERDTreeTabsToggle<CR>

" neomake
let g:neomake_open_list = 2 
autocmd! BufWritePost,BufEnter * Neomake
let g:neomake_error_sign = {
\ 'text': '',
\ 'texthl': 'Error',
\ }
let g:neomake_warning_sign = {
\ 'text': '',
\ 'texthl': 'Error',
\ }
let g:neomake_info_sign = {
\ 'text': '',
\ 'texthl': 'Title',
\ }
let g:neomake_message_sign = {
\ 'text': '',
\ 'texthl': 'Operator',
\ }

" jedi
let g:jedi#use_tabs_not_buffers = 1 
let g:jedi#popup_select_first = 0 
let g:jedi#popup_on_dot = 0
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#rename_command = "<leader>R"

augroup QfAutoCommands
  autocmd!
  " Auto-close quickfix window
  autocmd WinEnter * if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&buftype')) == 'quickfix' | quit | endif
augroup END

" unite
let g:unite_enable_smart_case = 1
let g:unite_enable_start_insert = 1
let g:unite_enable_ignore_case = 1
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>

if executable('ag')
    let g:unite_source_grep_command       = 'ag'
    let g:unite_source_grep_default_opts  = '--nogroup --nocolor --column'
    let g:unite_source_grep_recursive_opt = ''
endif
nnoremap [unite] <Nop>
nmap <Space>u [unite]
nnoremap [unite]f :<C-u>Unite file<CR>

" neo complete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1

if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns._ = '\h\w*'

" -- Language --
" rust
let g:rustfmt_autosave = 1
set hidden
let g:racer_cmd = '~/.cargo/bin/racer'
let $RUST_SRC_PATH="~/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src"
set omnifunc=syntaxcomplete#Complete
autocmd filetype rust setl tabstop=8 expandtab shiftwidth=4 softtabstop=4

" python
autocmd filetype python setl autoindent
autocmd filetype python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd filetype python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4

" binary
augroup BinaryXXD
  autocmd!
  autocmd BufReadPre  *.bin let &binary =1
  autocmd BufReadPost * if &binary | silent %!xxd -g 1
  autocmd BufReadPost * set ft=xxd | endif
  autocmd BufWritePre * if &binary | %!xxd -r | endif
  autocmd BufWritePost * if &binary | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END

" -- Settitngs --
set encoding=utf-8
set fileencoding=utf-8

syntax on " Color scheme
colorscheme solarized 
highlight Normal ctermbg=none

" set clipboard=unnamed,autoselect
set number
set wildmode=list:longest

set cursorline      " Highlight line number
hi clear CursorLine

" set spell " Spell check
hi clear SpellBad
hi SpellBad cterm=underline

" Statusline
set laststatus=2
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ \[ENC=%{&fileencoding}]%P

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
set mouse=a
set whichwrap=b,s,h,l,<,>,[,],~

set splitbelow
set splitright

" keymap
imap <c-e> <end>
imap <c-a> <home>
imap <c-j> <down>
imap <c-k> <up>
imap <c-l> <right>

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

if !has('gui_running') " Modify lag when switch mode.
    set timeout timeoutlen=1000 ttimeoutlen=50
endif

" -- END --
