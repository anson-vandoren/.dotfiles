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
Plug 'github/copilot.vim'
Plug 'lambdalisue/suda.vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'sainnhe/gruvbox-material'
Plug 'ayu-theme/ayu-vim'
Plug 'joshdick/onedark.vim'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'pangloss/vim-javascript'
Plug 'easymotion/vim-easymotion'
Plug 'APZelos/blamer.nvim'

call plug#end()
set termguicolors
let ayucolor="dark"
colorscheme gruvbox-material

" make Copilot work nicely with another tab-using completion system
let g:copilot_assume_mapped = v:true
imap <silent><expr> <C-J> copilot#Accept("<CR>")
imap <silent><expr> <C-H> copilot#Previous()
imap <silent><expr> <C-L> copilot#Next()

" ----------- folding -----------
set foldmethod=syntax


" ---------------- KEY MAPPING -------------------
let mapleader = ","

nmap <C-n> :NERDTreeFind<CR>

"""""""""""""""""""" coc setup """"""""""""""""""""
let g:coc_global_extensions = ['coc-tsserver', 'coc-json', 'coc-prettier', 'coc-vimlsp', 'coc-eslint']
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Symbol renaming.
nmap <Leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <Leader>f  <Plug>(coc-format-selected)
nmap <Leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>do  <Plug>(coc-codeaction-selected)
nmap <leader>do  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>do  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

""""""""""""""""""""""""""""" end coc setup """""""""""""""""""""""""""""

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
set nostartofline
set ruler
set scrolloff=10

nmap ; :Buffers<CR>
nmap <Leader>6 :Files<CR>
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
    autocmd Filetype Python setlocal softtabstop=4 shiftwidth=4 expandtab
    " get rid of the stupid extra comment on next line
    autocmd FileType * set formatoptions-=r
    " save on lose focus
    autocmd BufLeave,FocusLost * silent! wall
    " don't open files in NERDTree
    autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif
    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')
endif

" don't let vim-plug from NERDTree
let g:plug_window = 'noautocmd vertical topleft new'

" Allow saving of files as sudo when I forget to start vim as sudo
cmap w!! w !sudo tee > /dev/null %
