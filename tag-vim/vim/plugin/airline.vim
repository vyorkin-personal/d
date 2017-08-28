let airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

let g:airline#extensions#tabline#enabled = 1

if &background=="dark"
  let g:airline_theme="gruvbox"
else
  let g:airline_theme="tomorrow"
endif
