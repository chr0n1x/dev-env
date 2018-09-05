set t_Co=256
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
set tabstop=4
set shiftwidth=2
set softtabstop=2
set expandtab
set gdefault
set number
set mouse=c
set encoding=utf-8
set backspace=indent,eol,start
set ignorecase
set incsearch
set hlsearch
set showmatch
set cursorline
set ttyfast
set ruler
set formatoptions=qrn1
set scrolloff=3
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set guifont=Consolas\ 20
set laststatus=2
set statusline=%<\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)
set foldmethod=indent
set foldlevelstart=99

" default colors
au BufNewFile,BufRead *.timer         set filetype=sh
au BufNewFile,BufRead *.go            set filetype=c
au BufNewFile,BufRead Dockerfile      set filetype=sh

if &compatible
 set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
 call dein#begin('~/.cache/dein')

 call dein#add('~/.cache/dein')
 call dein#add('Shougo/deoplete.nvim')
 if !has('nvim')
   call dein#add('roxma/nvim-yarp')
   call dein#add('roxma/vim-hug-neovim-rpc')
 endif

  call dein#add('easymotion/vim-easymotion')
  call dein#add('ayu-theme/ayu-vim')
  call dein#add('mkarmona/colorsbox')
  call dein#add('bling/vim-airline')
  call dein#add('kien/ctrlp.vim')
  call dein#add('sjl/gundo.vim')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-surround')
  call dein#add('Yggdroot/indentLine')
  call dein#add('gregsexton/MatchTag')
  call dein#add('tpope/vim-markdown')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('Shougo/neocomplete.vim')
  call dein#add('rhysd/vim-crystal')
  call dein#add('elixir-editors/vim-elixir')

  " Goyo & Zenroom
  call dein#add('amix/vim-zenroom2')
  call dein#add('junegunn/goyo.vim')
  let g:goyo_width=100
  let g:goyo_margin_top=4
  let g:goyo_margin_bottom=4
  let g:goyo_linenr=1

  " Nerdtree
  call dein#add('scrooloose/nerdtree')
  let NERDTreeShowBookmarks=1
  let NERDTreeChDirMode=0
  let NERDTreeMouseMode=2
  let NERDTreeShowHidden=1
  let NERDTreeKeepTreeInNewTab=1
  let g:nerdtree_tabs_open_on_gui_startup=0
  autocmd VimEnter * wincmd l

  " Unite
  call dein#add('mileszs/ack.vim')
  call dein#add('thinca/vim-unite-history')
  call dein#add('Shougo/neomru.vim')
  call dein#add('Shougo/unite.vim')
  call dein#add('Shougo/unite-help')
  call dein#add('Shougo/unite-outline')
  call dein#add('Shougo/unite-session')
  call dein#add('Shougo/vimproc', { 'build': {
  \  'windows': 'make -f make_mingw32.mak',
  \  'cygwin': 'make -f make_cygwin.mak',
  \  'mac': 'make -f make_mac.mak',
  \  'unix': 'make -f make_unix.mak',
  \} })
  let g:unite_source_history_yank_enable = 1
  let g:unite_source_grep_default_opts = '-irnHl --exclude-dir "\.git" --exclude-dir "vendor" --exclude-dir "tmp"'

 call dein#end()
 call dein#save_state()
endif

filetype plugin indent on
syntax enable
set termguicolors
let ayucolor='dark'
colorscheme ayu

" key bindings
nnoremap <leader>t :CtrlP<CR>
nnoremap <Leader>s :/\<<C-r><C-w>\>/<CR>
" nmap <Leader>\ :noh<CR>
map <space>n :tabnext<CR>
map <space>b :tabprevious<CR>
map <space>o :tabe<space>
map <space>w :w<CR>
map <space>q :q<CR>

" basic plugins
nnoremap <silent> <leader>z :Goyo<cr>
nnoremap <Leader><tab> :NERDTreeToggle<CR>
nmap <Leader>G :GitGutterLineHighlightsToggle<CR>

nnoremap <leader>l :Limelight!!<CR>
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_default_coefficient = 0.7
let g:limelight_paragraph_span = 1
let g:limelight_priority = -1

" unite
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#custom#source('file_rec,file_rec/async,file_mru,file,buffer,grep', 'ignore_globs', split(&wildignore, ','))
nnoremap <leader>g :<C-u>Unite -auto-preview -default-action=tabopen               grep:.<CR>
nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline -default-action=open outline<CR>
nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=mru -default-action=vsplit   file_mru<CR>
nnoremap <leader>y :<C-u>Unite -buffer-name=yank -default-action=vsplit            history/yank<CR>

" neocomplete
let g:neocomplete#enable_at_startup = 1
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" python
let s:python = system("which python")
if !empty(s:python)
  map <Leader>j :%!python -m json.tool<CR>
endif

" force ctrlp to cache results AND use silver-searcher
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
