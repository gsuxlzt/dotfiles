" Match color scheme with terminal
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

set nocompatible

call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'preservim/NERDTree'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jiangmiao/auto-pairs'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'HerringtonDarkholme/yats.vim' " TS Syntax
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'
call plug#end()

"dev icons config
set encoding=UTF-8
set guifont=Fira\ Code:h12

" fzf settings
set rtp+=/usr/local/opt/fzf
let g:fzf_preview_window = 'right:50%'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6  }  }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"Nerdtree configs
let g:NERDTreeWinPos = 'right'
" close vim if only nerdtree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Set default arrows in NerdTree
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" NerdTree Icons
let g:NERDTreeGitStatusIndicatorMapCustom = {
\ "Modified" : "✹",
\ "Staged" : "✚",
\ "Untracked" : "✭",
\ "Renamed" : "➜",
\ "Unmerged" : "═",
\ "Deleted" : "✖",
\ "Dirty" : "✗",
\ "Clean" : "✔︎",
\ 'Ignored' : '☒',
\ "Unknown" : "?"
\}

" Enable NerdTree icons
let g:webdevicons_enable_nerdtree = 1
" NerdTree Brackets
let g:webdevicons_enable_nerdtree_brackets = 1
" Amount of space to use after the glych character
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
" Force Extra Padding to line up vertically
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
"Ignore node_modules
let g:NERDTreeIgnore = ['^node_modules$']

" sync open file with NERDTree
" " Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

# highlight open file in Nertree
autocmd BufEnter * call SyncTree()

" color scheme config
syntax on
set t_Co=256
if &term =~ '256color'
    set t_ut=
endif

set cursorline
colorscheme onehalfdark
let g:airline_theme='onehalfdark'
let g:airline_powerline_fonts = 1

" Set tabspaces
set tabstop=4
set softtabstop=4

"GUI options
set number "add numberlines
set relativenumber "show number relative to current line
set cursorline "highlight current line
set wildmenu
set showmatch
set lazyredraw

"Search options
set incsearch "search characters as they are typed
set hlsearch "highlight searched characters

"Folding options
set foldenable
set foldlevelstart=7 "will automatically fold blocks of code 7 levels deep

" coc config
command! -nargs=0 Prettier :CocCommand prettier.formatFile

let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ ]

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


" Keybindings
nnoremap <C-s> :w<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
"++ will be binded to cmd+/ for toggling comments.
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle
