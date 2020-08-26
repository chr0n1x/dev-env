" Shell/Env-Specific Settings

" usage of these is dependent on whether specific tools are installed in your
" shell env

" pipes an entire file into the python3 JSON tool, pretty-formatting it
let s:python = system("which python3")
if !empty(s:python)
  map <Leader>j :%!python3 -m json.tool<CR>
endif
