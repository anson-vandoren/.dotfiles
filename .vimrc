" Set compatibility to Vim only (not vi backward-compatible)
set nocompatible

" Specify directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'andys8/vim-elm-syntax', {'for': ['elm']}
Plug 'scrooloose/nerdcommenter'
Plug 'ambv/black'
Plug 'vimwiki/vimwiki'
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-eunuch'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'jiangmiao/auto-pairs'
" optional fzf if not already installed
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-surround'
Plug 'alvan/vim-closetag'
Plug 'cespare/vim-toml'
Plug 'alaviss/nim.nvim'

call plug#end()

" Set vimwiki to use Markdown
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

" Turn off modelines (comments at beginning/end of file for Vim config)
set modelines=0

" --------------------- QUALITY OF LIFE --------------------------
set encoding=utf-8
set autoindent
set showmode
set showcmd
set wildmenu
set wildmode=list:longest
set cursorline  " underline current line
set laststatus=2  " always show status line at bottom
set backspace=indent,eol,start " Allow backspace through indents, etc.
set ttyfast  " speed up scrolling

" --------------------------- TABS -------------------------------
set tabstop=4       " show existing tab with 4 spaces width
set shiftwidth=4    " when indenting with '>', use 4 spaces width
set softtabstop=4   " enable backspace deleting spaces as if they were tabs
set expandtab       " on pressing tab, insert 4 spaces
set shiftround      " make tabs go to regular tab stops

" -------------------------- KEY MAPPING --------------------------
" change leader key from \ to ,
let mapleader = ","
" move up and down by displayed lines, not file lines
nnoremap j gj
nnoremap k gk
" remap split pane navigation
nnoremap <C-J> <C-W><C-J>  
nnoremap <C-K> <C-W><C-K> 
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" set up fzf
nmap ; :Buffers<CR>
nmap <Leader>6 :Files<CR>
" set up ag/ack
nmap <Leader>a :Rg<CR>

" --------------------------- vim-go ------------------------------
" next/previous error
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
" close quickfix menu
nnoremap <leader>x :cclose<CR>
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <leader>l <Plug>(go-lint)
autocmd FileType go nmap <leader>i <Plug>(go-info)
let g:go_list_type = "quickfix"
let g:go_test_timeout = '10s'  " default value is 10sec
let g:go_auto_type_info = 1
let g:go_auto_sameids = 1

" build or compile tests based on file name
function! s:build_go_files()
    let l:file = expand('%')
    if l:file =~# '^\f\+_test\.go$'
        call go#test#Test(0, 1)
    elseif l:file =~# '^\f\+\.go$'
        call go#cmd#Build(0)
    endif
endfunction
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
set autowrite
let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1

" ------------------------- FIX SEARCH ---------------------------
nnoremap / /\v
vnoremap / /\v
set ignorecase  " search case-insensitive
set smartcase   " be case-sensitive if any search character is uppercase
set incsearch   " search incrementally as you type
set showmatch   " show matching brackets when typing the first
set hlsearch    " highlight search terms
set gdefault    " add the g flag to search/replace by default
" clear search box with ,<space>
nnoremap <leader><space> :noh<cr>:GoSameIdsClear<cr>
" make tab key match bracket pairs in visual and normal modes
nnoremap <tab> %
vnoremap <tab> %

" ---------------------- HANDLE LONG LINES -------------------------
set wrap
set textwidth=79
set formatoptions=qrn1
" Use the OS clipboard by default
set clipboard=unnamed

" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
    set undodir=~/.vim/undo
endif

" Don't create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" Enable line numbers
set number
"set number relativenumber
"set nu rnu

" Enable mouse in all modes
"set mouse=a

" Don't reset cursor to start of line when moving around
set nostartofline

" Show the cursor position
set ruler

" Start scrolline three lines before the horizontal window border
set scrolloff=5

" Automatic commands
if has("autocmd")
    " Enable file type detection
    filetype on
    " Treat .json files as .js
    autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
    " Treat .md files as Markdown
    autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif

" set up indentation
autocmd BufNewFile,BufRead *.py
    \ set fileformat=unix

autocmd Filetype html setlocal softtabstop=2 shiftwidth=2 expandtab
autocmd Filetype htmldjango setlocal softtabstop=2 shiftwidth=2 expandtab
autocmd Filetype javascript setlocal softtabstop=2 shiftwidth=2 expandtab
autocmd Filetype css setlocal softtabstop=2 shiftwidth=2 expandtab
autocmd Filetype Python setlocal softtabstop=4 shiftwidth=4 expandtab

" Autoformat with Black
autocmd BufWritePre *.py execute ':Black'
" recognize .gohtml files as html-ish
autocmd BufRead,BufNewFile *.gohtml set filetype=gohtmltmpl

" Map F5 to save and then run current Python buffer
autocmd FileType Python nnoremap <buffer> <F5> :w<CR>:exec '!clear; python' shellescape(@%, 1)<cr>
" Map F5 to save and then run current Go buffer
" autocmd FileType go nnoremap <buffer> <F5> :w<CR>:GoRun<cr>

" disable auto comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" add some useful abbreviations for common typos
" shift still held down when opening a file from $HOME:
ab ~? ~/
" shift still held down with not-equal
ab !+ !=
" fix stupid print typo in Go
ab Pringln Println

" make error messages easier to read
:hi ErrorMsg ctermfg=Black guifg=Black
:hi Error ctermfg=Black guifg=Black

" make vim use ripgrep
let g:ackprg = 'rg --vimgrep --no-heading'
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,:%f:%l:%m
endif

" from https://github.com/junegunn/fzf.vim
function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

" set Prettier to run on save
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml, PrettierAsync
" only use Prettier on HTML files that aren't templates
autocmd FileType html autocmd BufWritePre <buffer> PrettierAsync

" set netrw file browser style
" show directory tree
let g:netrw_liststyle = 3
" remove top banner
let g:netrw_banner = 0
" open files in horizontal split
let g:netrw_browse_split = 1
" open netrw with 25% of page
let g:netrw_winsize = 25
