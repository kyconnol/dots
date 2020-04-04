syntax on
colo nord

set mouse=a
set belloff=all
set encoding=utf-8
set fileencoding=utf-8
set wildmode=longest,list,full
set wildmenu
set backspace=indent,eol,start
let mapleader = ","
set omnifunc=sytaxcomplete#Complete
set completeopt=longest,menuone

b:vcm_tab_complete = "omni"

" yaml settings
au! BufNewFile,BufReadPost *.{yaml,yml} setlocal filetype=yaml foldmethod=indent nofoldenable
filetype plugin indent on
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab indentkeys-=<:>


" Leader calls && Functions to deal with whitespace
nnoremap <leader>ss <c-r>ShowSpaces()<CR>
nnoremap <leader>ts <c-r>TrimSpaces()<CR>
nnoremap <leader>a :cclose<CR>

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

