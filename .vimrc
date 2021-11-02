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
 call dein#end()
 call dein#save_state()
endif

" imports of other things
source ~/.vimrcs/colors.vim
source ~/.vimrcs/denite.vim
source ~/.vimrcs/deoplete.vim
source ~/.vimrcs/nerdtree.vim
source ~/.vimrcs/shell-bindings.vim

" sweet-spot configuration to make sure that syntax + colors does not cause
" lag when moving around in the buffer
set regexpengine=1
syntax on

" key bindings
nmap <leader>s       :/\<<C-r><C-w>\>/<CR>
nmap <leader>t       :CtrlP<CR>
nmap <leader><tab>   :NERDTreeToggle<CR>
nmap <leader><space> :noh <bar> e<CR>
nmap <leader>G       :GitGutterLineHighlightsToggle<CR>
nmap <leader>g       :<C-u>DeniteProjectDir grep<CR>
nmap <leader>o       :<C-u>Denite outline<CR>
map  <space>n        :tabnext<CR>
map  <space>b        :tabprevious<CR>
map  <space>o        :tabe<space>
map  <space>w        :w<CR>
map  <space>q        :q<CR>
