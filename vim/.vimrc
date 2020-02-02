if !&compatible
  set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

" local config
augroup vimrc-local
  autocmd!
  autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(loc)
  let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction

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
let s:toml_file = '~/.vim/.dein.toml'
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

" multi cursor
let g:multi_cursor_use_default_mapping = 0
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

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

" lsp
let g:lsp_diagnostics_enabled = 0
" debug
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/.vim/.vim-lsp.log')
let g:asyncomplete_log_file = expand('~/.vim/.asyncomplete.log')

" - python
if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif

" - go
if executable('gopls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'gopls',
        \ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
        \ 'whitelist': ['go'],
        \ })
endif

" ---

augroup QfAutoCommands
  autocmd!
  " Auto-close quickfix window
  autocmd WinEnter * if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&buftype')) == 'quickfix' | quit | endif
augroup END

" denite
augroup denite_filter
  autocmd FileType denite call s:denite_my_settings()
  function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> <CR>
    \ denite#do_map('do_action')
    nnoremap <silent><buffer><expr> d
    \ denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> p
    \ denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> q
    \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> i
    \ denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <Space>
    \ denite#do_map('toggle_select').'j'
  endfunction
augroup END

" use floating
let s:denite_win_width_percent = 0.85
let s:denite_win_height_percent = 0.7
let s:denite_default_options = {
    \ 'split': 'floating',
    \ 'winwidth': float2nr(&columns * s:denite_win_width_percent),
    \ 'wincol': float2nr((&columns - (&columns * s:denite_win_width_percent)) / 2),
    \ 'winheight': float2nr(&lines * s:denite_win_height_percent),
    \ 'winrow': float2nr((&lines - (&lines * s:denite_win_height_percent)) / 2),
    \ 'highlight_filter_background': 'DeniteFilter',
    \ 'prompt': '$ ',
    \ 'start_filter': v:true,
    \ }
let s:denite_option_array = []
for [key, value] in items(s:denite_default_options)
  call add(s:denite_option_array, '-'.key.'='.value)
endfor
call denite#custom#option('default', s:denite_default_options)

call denite#custom#var('file/rec', 'command',
    \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
    \ [ '.git/', '.ropeproject/', '__pycache__/',
    \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])
" Ag command on grep source
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" grep
command! -nargs=? Dgrep call s:Dgrep(<f-args>)
function s:Dgrep(...)
  if a:0 > 0
    execute(':Denite -buffer-name=grep-buffer-denite grep -path='.a:1)
  else
    execute(':Denite -buffer-name=grep-buffer-denite '.join(s:denite_option_array, ' ').' grep')
  endif
endfunction

" file open
command! -nargs=? Dopen call s:Dopen(<f-args>)
function s:Dopen(...)
  if a:0 > 0
    execute(':Denite -buffer-name=grep-buffer-denite grep -path='.a:1)
  else
    execute(':Denite -buffer-name=grep-buffer-denite '.join(s:denite_option_array, ' ').' file/rec')
  endif
endfunction

call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')

" deoplete
let g:deoplete#enable_at_startup = 0
let g:deoplete#enable_ignore_case = 0  
let g:deoplete#enable_smart_case = 0 
let g:deoplete#auto_complete_delay = 0
let g:deoplete#auto_completion_start_length = 5
imap <expr><CR>
      \ (pumvisible() && neosnippet#expandable()) ? "\<Plug>(neosnippet_expand_or_jump)" : "\<CR>"

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

" vim-go
filetype plugin indent on
let g:go_bin_path = $GOPATH.'/bin'
let g:go_fmt_command = 'goimports'
let g:go_list_type = "quickfix"
autocmd BufWritePre *.go GoFmt

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

"html
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype php inoremap <buffer> </ </<C-x><C-o>
augroup END

" -- Settitngs --
set encoding=utf-8
set fileencoding=utf-8

syntax on " Color scheme
colorscheme solarized 
highlight Normal ctermbg=none

set clipboard=unnamed
set number
set wildmode=list:longest

set cursorline      " Highlight line number
hi clear CursorLine

" set spell " Spell check
hi clear SpellBad
hi SpellBad cterm=underline

" Statusline
set laststatus=2

set nowrap
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

set timeoutlen=1000
set ttimeoutlen=0

if !has('gui_running') " Modify lag when switch mode.
    set timeout timeoutlen=1000 ttimeoutlen=50
endif

" -- END --
