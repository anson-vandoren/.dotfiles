" set compatibility to Vim only (not vi backward-compatible)
set nocompatible

" install vim-plug if not already
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" specify directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'alvan/vim-closetag'
Plug 'cespare/vim-toml'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'github/copilot.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'easymotion/vim-easymotion'
Plug 'APZelos/blamer.nvim'
Plug 'preservim/tagbar'
Plug 'srcery-colors/srcery-vim'

call plug#end()

let mapleader = ","

set termguicolors
colorscheme srcery

let g:copilot_assume_mapped = v:true
imap <silent><expr> <C-J> copilot#Accept("<CR>")
imap <silent><expr> <C-H> copilot#Previous()
imap <silent><expr> <C-L> copilot#Next()

let g:context_enabled = 1

let g:airline_theme='molokai'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" turn off modelines to prevent some vulnerabilities
set modelines=0

" -------------------- QUALITY OF LIFE ------------------
set encoding=utf-8
set autoindent
set showmode
set showcmd
set wildmenu
set wildmode=list:longest
set cursorline           	    " underline current line
set backspace=indent,eol,start 	" allow backspace through indents, lines, etc.
set ttyfast  			        " speed up scrolling
set clipboard=unnamedplus  	    " use system clipboard inside vim (for Linux)

" ----------------------- TABS -------------------
set tabstop=4      " show existing tab with 4 spaces width
set shiftwidth=4   " when indenting with '>', use 4 spaces width
set softtabstop=4  " enable backspace deleting spaces as if they were tabs
set expandtab      " on pressing tab, insert 4 spaces
set shiftround     " make tabs to go regular tab stops

" ---------------- NAVIGATION -------------------
" move up and down by displayed lines, not file lines
nnoremap j gj
nnoremap k gk
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" ------------------- SEARCH ---------------------
nnoremap / /\v
vnoremap / /\v
set ignorecase  " search case-insensitive
set smartcase   " be case-sensitive if any search character is uppercase
set incsearch   " search incrementally as you type
set showmatch   " show matching brackets when typing the first
set hlsearch    " highlight search terms
set gdefault    " add the g (global) flag to search/replace by default
" clear search box with ,<space>
nnoremap <leader><space> :noh<cr>
" make tab key match bracket pairs in visual and normal modes
nnoremap <tab> %
vnoremap <tab> %

" --------------- HANDLE LONG LINES ------------
set wrap
set textwidth=88
set formatoptions=cqn1

" centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
    set undodir=~/.vim/undo
endif
" Don't create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" ------------------ GENERAL --------------------
set number
set norelativenumber
set nostartofline
set ruler
set scrolloff=10

nmap ; :Buffers<CR>
nmap <C-p> :Files<CR>
" show list of commits
nmap <Leader>gc :Commits<CR>
" show git status
nmap <Leader>gs :GitFiles?<CR>

" ------------------- Ack/Ag/Ripgrep -------------
" set ,a to search files from cwd
nmap <Leader>a :RG<CR>
" make vim use ripgrep instead of ack
let g:ackprg = 'rg --vimgrep --no-heading'
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,:%f:%l:%m
endif
" from https://github.com/junegunn/fzf.vim
function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --hidden --column --line-number --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let cdCurBuf = printf('cd %s', shellescape(expand('%:p:h')))
    let dir = systemlist(printf('%s && git rev-parse --show-toplevel || true', cdCurBuf))[0] " get git root
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command], 'dir': dir}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" -------------- git blame --------------
let g:blamer_enabled = 1

" -------------- tagbar --------------
nmap <F8> :TagbarToggle<CR>

" ------------------------------ NETRW -----------------
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 1
let g:netrw_winsize = 25

" set autocmds
if has("autocmd")
    filetype on
    " treat .json files as .js
    autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
    " treat typescript as js
    autocmd FileType typescript setlocal formatprg=prettier\ --parser\ typescript
    " treat .md files as markdown
    autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
    " --------------------- INDENTATION ---------------------
    autocmd BufNewFile,BufRead *.py set fileformat=unix
    autocmd Filetype html setlocal softtabstop=2 shiftwidth=2 expandtab
    autocmd Filetype htmldjango setlocal softtabstop=2 shiftwidth=2 expandtab
    autocmd Filetype javascript setlocal softtabstop=2 shiftwidth=2 expandtab
    autocmd Filetype typescript setlocal softtabstop=2 shiftwidth=2 expandtab
    autocmd Filetype css setlocal softtabstop=2 shiftwidth=2 expandtab
    autocmd Filetype Python setlocal softtabstop=4 shiftwidth=4 expandtab foldmethod=indent
    " get rid of the stupid extra comment on next line
    autocmd FileType * set formatoptions-=r
    " save on lose focus
    autocmd BufLeave,FocusLost * silent! wall
endif

" Allow saving of files as sudo when I forget to start vim as sudo
cmap w!! w !sudo tee > /dev/null %

" close all open buffers except current one
map <leader>q :%bd\|e#\|bd#<CR>
" close all open buffers
map <leader>Q :%bd<CR>
