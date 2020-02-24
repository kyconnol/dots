syntax on
colo nord

set mouse=a
set belloff=all
set encoding=utf-8
set fileencoding=utf-8

" yaml settings
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent nofoldenable
filetype plugin indent on
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab setl indentkeys-=<:>

set backspace=indent,eol,start
let mapleader = ","

nnoremap <leader>ss `:ShowSpaces<CR>`
nnoremap <leader>ts m`:TrimSpaces<CR>`

function ShowSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

function TrimSpaces() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction

