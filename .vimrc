set t_Co=256
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
set nocompatible
set smartindent
set autoindent
filetype indent on

" default colors
au BufNewFile,BufRead *.timer         set filetype=sh
au BufNewFile,BufRead *.go            set filetype=c
au BufNewFile,BufRead Dockerfile      set filetype=sh

if &compatible
 set nocompatible
endif

" key bindings
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*
nnoremap <Leader>s :/\<<C-r><C-w>\>/<CR>
" nmap <Leader>\ :noh<CR>
map <space>n :tabnext<CR>
map <space>b :tabprevious<CR>
map <space>o :tabe<space>
map <space>w :w<CR>
map <space>q :q<CR>

" imports of other things
source ~/.vimrcs/shell-bindings.vim
source ~/.vimrcs/dein-plugins.vim

" sweet-spot configuration to make sure that syntax + colors does not cause
" lag when moving around in the buffer
set regexpengine=1
syntax on

" to get this to work - had to:
"
"   brew install ruby
"
" - make sure that macOS ruby is >= 2.4
" - then make sure that this version of ruby is in the user PATH:
"
"   export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/3.0.0/bin:$PATH"
"
" (yes, that's sadge-times)
"
" THEN install rubocop and related gems...
"
"   gem install rubocop rubocop-rails
let g:ale_linters = { 'ruby': [ 'rubocop' ] }
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
