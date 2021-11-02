let g:deoplete#enable_at_startup = 1

" deoplete specific bindings for the pop-up pane
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
