let g:tsuquyomi_disable_quickfix = 1
let g:tsuquyomi_completion_detail = 1
let g:tsuquyomi_completion_preview = 1

nn ,te :TsuGeterr<CR>
nn ,ti :TsuImport<CR>

autocmd FileType typescript nmap <buffer> <leader>tr <Plug>(TsuquyomiRenameSymbol)
autocmd FileType typescript nmap <buffer> <leader>tR <Plug>(TsuquyomiRenameSymbolC)

autocmd FileType typescript nmap <buffer> <C-l> <Plug>(TsuquyomiDefinition)
autocmd FileType typescript nmap <buffer> <C-h> <Plug>(TsuquyomiGoBack)

autocmd FileType typescript nmap <buffer> <leader>k :TsuquyomiReferences<CR>
