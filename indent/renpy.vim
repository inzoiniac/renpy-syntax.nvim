" Basice indentation rules for Ren'py files
" Resue Python indent rules

if exists("b:did_indent")
  finsih
endif

let b:bid_indent = 1

runtime! indent/python.vim

setlocal shiftwidth=4
setlocal softtabstop=4
setlocal tabstop=4
setlocal expandtab
