" Make zathura default view and latex default tex flavor
let g:tex_flavor='latex'
let g:vimtex_view_method = 'zathura'

" I do not use tags; use C-T to open Vimtex TOC
nnoremap <C-T> <ESC><ESC>:VimtexTocOpen<CR>

setlocal tabstop=2
setlocal shiftwidth=2

" Customize search in tex files
nnoremap gg gg/\\begin{document}<enter>:C<enter>
nnoremap G G$?\\end{document}<enter>:C<enter>

" Preparatory function to use with ref and eqref
fu! MyHandler(_) abort
    call feedkeys("\<c-x>\<c-o>", 'in')
endfu

" Enable folds in vimtex
let g:vimtex_fold_enabled=1

" Runaway whitespace is a fact of life in latex
let g:airline#extensions#whitespace#enabled = 0

" No vimtex indent
let g:vimtex_indent_enabled = 0

" Folding small files
let g:fastfold_minlines = 0

" Use lualatex as default latex compiler
let g:vimtex_compiler_engine = 'lualatex'

" Do not open quickfix window for warnings
let g:vimtex_quickfix_open_on_warning = 0

"Spellchecking on
setlocal spell
setlocal spelllang=en,el

let g:vimtex_compiler_latexmk = {
		\ 'aux_dir' : './.aux',
		\ 'out_dir' : './out',
		\ 'callback' : 1,
		\ 'continuous' : 1,
		\ 'executable' : 'latexmk',
		\ 'hooks' : [],
		\ 'options' : [
		\   '-silent',
		\   '-file-line-error',
		\   '-synctex=1',
		\   '-shell-escape',
		\   '-interaction=nonstopmode',
		\ ],
		\}
