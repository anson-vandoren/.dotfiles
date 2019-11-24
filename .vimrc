" Set compatibility to Vim only (not vi backward-compatible)
set nocompatible

" Specify directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'andys8/vim-elm-syntax', {'for': ['elm']}
Plug 'scrooloose/nerdcommenter'
Plug 'ambv/black'
Plug 'chrisbra/csv.vim'
Plug 'vimwiki/vimwiki'
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" optional fzf if not already installed
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'mileszs/ack.vim'

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
nmap <Leader>a :Ag<CR>

" --------------------------- vim-go ------------------------------
" next/previous error
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
" close quickfix menu
nnoremap <leader>x :cclose<CR>
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>t <Plug>(go-test)
let g:go_list_type = "quickfix"
let g:go_test_timeout = '10s'  " default value is 10sec

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
nnoremap <leader><space> :noh<cr>
" make tab key match bracket pairs in visual and normal modes
nnoremap <tab> %
vnoremap <tab> %

" ---------------------- HANDLE LONG LINES -------------------------
set wrap
set textwidth=79
set formatoptions=qrn1
" Use the OS clipboard by default
set clipboard=unnamed

" Allow cursor keys in insert mode
set esckeys

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

autocmd Filetype html setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd Filetype javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd Filetype css setlocal tabstop=2 softtabstop=2 shiftwidth=2

" Autoformat with Black
autocmd BufWritePre *.py execute ':Black'

" Map F5 to save and then run current Python buffer
autocmd FileType Python nnoremap <buffer> <F5> :w<CR>:exec '!clear; python' shellescape(@%, 1)<cr>
" Map F5 to save and then run current Go buffer
" autocmd FileType go nnoremap <buffer> <F5> :w<CR>:GoRun<cr>

" disable auto comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" make error messages easier to read
:hi ErrorMsg ctermfg=Black guifg=Black
:hi Error ctermfg=Black guifg=Black

" make ack use ag
let g:ackprg = 'ag --nogroup --nocolor --column'
