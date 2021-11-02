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
