" Dein Plugin Setup & Config

" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#add('~/.cache/dein')

  " vim 8+ autocomplete & fuzzy
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')
  let g:deoplete#enable_at_startup = 1
  " denite
  call dein#add('Shougo/denite.nvim')
  let g:denite_source_history_yank_enable = 1
  let g:denite_source_grep_default_opts = '-irnHl --exclude-dir "\.git"'

  " basic editor flair
  call dein#add('airblade/vim-gitgutter')
  call dein#add('arcticicestudio/nord-vim')
  call dein#add('bling/vim-airline')
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

" deite
" call denite#filters#matcher_default#use(['matcher_fuzzy'])
" Define mappings
autocmd FileType denite call s:denite_mappings()
function! s:denite_mappngs() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
endfunction
" call denite#custom#source('file_rec,file_rec/async,file_mru,file,buffer,grep', 'ignore_globs', split(&wildignore, ','))
" nnoremap <leader>g :<C-u>Unite -auto-preview -default-action=tabopen               grep:.<CR>
" nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline -default-action=open outline<CR>
" nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=mru -default-action=vsplit   file_mru<CR>
" nnoremap <leader>y :<C-u>Unite -buffer-name=yank -default-action=vsplit            history/yank<CR>

" ctrlp settings
nnoremap <leader>t :CtrlP<CR>
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
