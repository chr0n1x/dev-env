filetype indent on
set autoread
set autoindent
set backspace=indent,eol,start
set cursorline
set encoding=utf-8
set expandtab
set formatoptions=qrn1
set foldlevelstart=99
set foldmethod=indent
set gdefault
set guifont=Consolas\ 20
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set mouse=c
set number
set ruler
set shiftwidth=2
set softtabstop=2
set showmatch
set scrolloff=3
set showmode
set showcmd
set statusline=%<\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)
set smartindent
set t_Co=256
set tabstop=4
set ttyfast
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*
set wildmenu
set wildmode=list:longest
au BufNewFile,BufRead Dockerfile set filetype=sh
if &compatible
 set nocompatible
endif

" Dein Plugin Setup & Config
" For some reason, these cannot be imported in nvim
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#add('~/.cache/dein')

  " vim 8+ or neovim autocomplete & fuzzy
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
  call dein#add('Shougo/denite.nvim')
  call dein#add('mileszs/ack.vim')

  " basic editor flair
  call dein#add('airblade/vim-gitgutter')
  call dein#add('arcticicestudio/nord-vim')
  call dein#add('bling/vim-airline')
  call dein#add('gregsexton/MatchTag')
  call dein#add('kien/ctrlp.vim')
  "" NOTE: fugitive slows down docker-based envs
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-surround')
  call dein#add('Yggdroot/indentLine')

  " Nerdtree
  call dein#add('scrooloose/nerdtree')
  let NERDTreeShowBookmarks=1
  let NERDTreeChDirMode=0
  let NERDTreeMouseMode=2
  let NERDTreeShowHidden=1
  let NERDTreeKeepTreeInNewTab=1
  let g:nerdtree_tabs_open_on_gui_startup=0
 call dein#end()
 call dein#save_state()
endif

" imports of other things
source ~/.vimrcs/shell-bindings.vim

if (has("termguicolors"))
  set termguicolors
endif
silent! colorscheme nord

" startup deoplete
let g:deoplete#enable_at_startup = 1
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" denite startup configs
let g:denite_source_history_yank_enable = 1
let g:denite_source_grep_default_opts = '-irnHl --exclude-dir "\.git"'

" denite mappings
autocmd FileType denite call s:denite_buffer_mappings()
function! s:denite_buffer_mappings() abort
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')

  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')

  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'

  " opening buffer results and whatnot
  nnoremap <silent><buffer><expr> t
  \ denite#do_map('do_action', 'tabopen')
  nnoremap <silent><buffer><expr> s
  \ denite#do_map('do_action', 'vsplit')
endfunction
nnoremap <leader>g :<C-u>DeniteProjectDir grep<CR>
nnoremap <leader>o :<C-u>Denite outline<CR>

" ctrlp settings
nmap <leader>t :CtrlP<CR>
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'

" silver_searcher specific settings
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ackprg = 'ag --vimgrep --ignore-dir log'
endif

" sweet-spot configuration to make sure that syntax + colors does not cause
" lag when moving around in the buffer
set regexpengine=1
syntax on

" key bindings
nmap <leader>s       :/\<<C-r><C-w>\>/<CR>
nmap <leader><tab>   :NERDTreeToggle<CR>
nmap <leader><space> :noh <bar> e<CR>
nmap <leader>G       :GitGutterLineHighlightsToggle<CR>
map  <space>n       :tabnext<CR>
map  <space>b       :tabprevious<CR>
map  <space>o       :tabe<space>
map  <space>w       :w<CR>
map  <space>q       :q<CR>
