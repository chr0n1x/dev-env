filetype indent on
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
set nocompatible
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
set wildmenu
set wildmode=list:longest

" default colors
au BufNewFile,BufRead *.timer    set filetype=sh
au BufNewFile,BufRead *.go       set filetype=c
au BufNewFile,BufRead Dockerfile set filetype=sh
au BufNewFile,BufRead *.cr       set filetype=ruby

" Dein Plugin Setup & Config
" For some reason, these cannot be imported in nvim
if &compatible
 set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#add('~/.cache/dein')
  " vim 8+ autocomplete & fuzzy
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
  call dein#add('dense-analysis/ale')
  call dein#add('easymotion/vim-easymotion')
  call dein#add('elixir-editors/vim-elixir')
  call dein#add('gregsexton/MatchTag')
  call dein#add('kien/ctrlp.vim')
  call dein#add('mkarmona/colorsbox')
  call dein#add('sjl/gundo.vim')
  " NOTE: fugitive slows down docker-based envs
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-markdown')
  call dein#add('tpope/vim-surround')
  call dein#add('Yggdroot/indentLine')
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
 call dein#end()
 call dein#save_state()
endif

" key bindings
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*
nnoremap <Leader>s :/\<<C-r><C-w>\>/<CR>
nnoremap <Leader>p "*P<CR>
" nmap <Leader>\ :noh<CR>
map <space>n :tabnext<CR>
map <space>b :tabprevious<CR>
map <space>o :tabe<space>
map <space>w :w<CR>
map <space>q :q<CR>

" imports of other things
source ~/.vimrcs/shell-bindings.vim

if (has("termguicolors"))
  set termguicolors
endif
silent! colorscheme nord

nnoremap <silent> <leader>z :Goyo<cr>
nnoremap <Leader><tab> :NERDTreeToggle<CR>
nmap <Leader>G :GitGutterLineHighlightsToggle<CR>

" limelight
nnoremap <leader>l :Limelight!!<CR>
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_default_coefficient = 0.7
let g:limelight_paragraph_span = 1
let g:limelight_priority = -1

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
nnoremap <leader>t :CtrlP<CR>
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
