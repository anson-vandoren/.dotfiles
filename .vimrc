" set compatibility to Vim only (not vi backward-compatible
set nocompatible

" specify directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'alvan/vim-closetag'
Plug 'ambv/black'
Plug 'andys8/vim-elm-syntax', {'for': ['elm']}
Plug 'cespare/vim-toml'
Plug 'elixir-editors/vim-elixir'
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vimwiki/vimwiki'

call plug#end()

" set vimwiki to use Markdown
let g:vimwiki_list = [{'path': '~/notes', 'syntax': 'markdown', 'ext': 'md'}]

" set airline theme
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
set cursorline           	" underline current line
set backspace=indent,eol,start 	" allow backspace through indents, lines, etc.
set ttyfast  			" speed up scrolling
set clipboard=unnamedplus  	" use system clipboard inside vim (for Linux)

" ----------------------- TABS -------------------
set tabstop=4      " show existing tab with 4 spaces width
set shiftwidth=4   " when indenting with '>', use 4 spaces width
set softtabstop=4  " enable backspace deleting spaces as if they were tabs
set expandtab      " on pressing tab, insert 4 spaces
set shiftround     " make tabs to go regular tab stops

" ---------------- KEY MAPPING -------------------
let mapleader = ","

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
set textwidth=79
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
set nostartofline
set ruler
set scrolloff=5

nmap ; :Buffers<CR>
nmap <Leader>6 :Files<CR>

" ------------------- Ack/Ag/Ripgrep -------------
" set ,a to search files from cwd
nmap <Leader>a :Rg<CR>
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
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

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
    " treat .md files as markdown
    autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
    " --------------------- INDENTATION ---------------------
    autocmd BufNewFile,BufRead *.py set fileformat=unix
    autocmd Filetype html setlocal softtabstop=2 shiftwidth=2 expandtab
    autocmd Filetype htmldjango setlocal softtabstop=2 shiftwidth=2 expandtab
    autocmd Filetype javascript setlocal softtabstop=2 shiftwidth=2 expandtab
    autocmd Filetype css setlocal softtabstop=2 shiftwidth=2 expandtab
    autocmd Filetype Python setlocal softtabstop=4 shiftwidth=4 expandtab
    " get rid of the stupid extra comment on next line
    autocmd FileType * set formatoptions-=r
endif

" Allow saving of files as sudo when I forget to start vim as sudo
cmap w!! w !sudo tee > /dev/null %
