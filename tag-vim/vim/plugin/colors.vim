hi Conceal guibg=NONE ctermbg=NONE
hi VertSplit gui=NONE guifg=NONE guibg=NONE cterm=NONE term=NONE ctermfg=NONE ctermbg=NONE
hi SignColumn guifg=NONE guibg=NONE cterm=NONE term=NONE ctermfg=NONE ctermbg=NONE
hi ColorColumn ctermbg=NONE guibg=NONE

augroup colors
  autocmd!
  au ColorScheme * so ~/.vim/plugin/colors.vim
augroup END
