" Activate syntax highlighting
syntax on

" Activate filetype plugin
filetype plugin on

" ~/.vim/pack/vendor/start/{FastFold,fzf,fzf.vim,goyo.vim,limelight.vim,      \
" traces.vim,ultisnips,vim-easy-align,vim-easymotion,vim-fugitive,vim-pencil, \
" vim-sandwich,vimtex}
"
" ~/.vim/pack/vendor/opt/unicode.vim

" set defaults
set nocompatible        " turn off vi compatibility mode
set history=5000        " keep 5000 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set incsearch           " enable incremental searching
set number              " enable line numbers
set rnu                 " set relative line numbers
set encoding=utf8       " set utf8 encoding
set textwidth=100       " set text width to 100 chars
set nowrapscan          " do not loop back to beginning when scanning
set winaltkeys=no       " do not capture alt keys
set laststatus=2        " always show statusline
set noswapfile          " ban swapfiles
set tabstop=4           " set four spaces per tab
set shiftwidth=4        " set indent width to 4
set linebreak           " line breaks are a must
set hlsearch            " Activate highlight search
set ttimeoutlen=100     " Set small timeout
set timeoutlen=500      " Set small timeout
set fillchars+=fold:\.  " Make fold demarcations pretty
set autochdir           " automatically change pwd to current file
set spelllang=en,el     " set global spelling languages
set fillchars+=vert:\   " Trailing space; make invisible
set fillchars+=vert:\║  " pretty separators
set fillchars+=stl:═    " pretty separators
set fillchars+=stlnc:═  " pretty separators
set fillchars+=eob:\.   " pretty separators
set belloff=all         " shut up for the love of fuck
set nobackup            " do not keep a backup file
set undofile            " keep an undo file (undo changes after closing)
set background=light    " set light preference
set backspace=indent,eol,start " Enable familiar backspace settings
set t_RB= t_RF= t_RV= t_u7=

" Cursor switching between normal and insert modes
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Mouse settings
if has('mouse')
	set mouse=a
endif

" Diff settings for viewing file changes
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
	\ | wincmd p | diffthis
endif

"Compatibility check
if has('langmap') && exists('+langnoremap')
	set langnoremap
endif

if has("autocmd")
	augroup vimrcExecute
		autocmd!
		autocmd! BufReadPost *
		\ if line("'\"") >= 1 && line("'\"") <= line("$") |
		\   exe "normal! g`\"" |
		\ endif

		" Turn on tex settings for lit files
		autocmd! BufNewFile,BufRead *.lit setfiletype tex

		"Re-source vimrc files on write
		autocmd! BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif

	augroup END
endif

" Commands
command! C let @/ = "" " Clear highlighting
command! Hidetab set nolist  " Hide all list markers
command! Showtab set list | set listchars=eol:·,tab:⍿·,trail:× " Show tabs and other markers

" Default UltiSnips folder
let g:UltiSnipsSnippetDirectories = [$HOME.'/.vim/UltiSnips']

" Keybindings for UltiSnips
let g:UltiSnipsExpandTrigger       = "<tab>"
let g:UltiSnipsJumpForwardTrigger  = "<c-Right>"
let g:UltiSnipsJumpBackwardTrigger = "<c-Left>"
let g:UltiSnipsEditSplit           = "vertical"

" Custom colorscheme
colorscheme habiShell

" Transparent Statusline and separators
hi StatusLine       cterm=NONE ctermfg=NONE ctermbg=NONE
hi StatusLineNC     cterm=NONE ctermfg=NONE ctermbg=NONE
hi StatusLineTerm   cterm=NONE ctermfg=NONE ctermbg=NONE
hi StatusLineTermNC cterm=NONE ctermfg=NONE ctermbg=NONE
hi VertSplit        cterm=NONE ctermfg=NONE ctermbg=NONE

" Toggle relative numbers
function! NumberToggle()
	if(&relativenumber == 1)
		set rnu!
	else
		set rnu
	endif
endfunc

"Toggle vertical centering of cursor
function! ScrollOffToggle()
	if(&scrolloff == 999)
		set scrolloff=0
	else
		set scrolloff=999
	endif
endfunc

" Color for out of focus sections with limelight
let g:limelight_conceal_ctermfg = 'gray'

" Regex for limelight to include % demarcations
let g:limelight_bop = '\(^\s*$\n\|^\s*%$\n\)\zs'
let g:limelight_eop = '\ze\(^$\|^\s*%$\)'

" hi priority limelight
let g:limelight_priority = -1

" goyo 1 + textwidth
let g:goyo_width = 1 + &textwidth

set statusline=
set statusline+=%#LineNr#
set statusline+=═
set statusline+=═╡\ %f\ ╞═
set statusline+=%m
set statusline+=%=╡
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ ╞══

" Preformatting and window styling for comfy typing.
noremap <silent> <F2> <esc><esc>:Goyo<CR>
noremap <silent> <F3> <esc><esc>:call ScrollOffToggle()<CR>
noremap <silent> <F4> <esc><esc>:Limelight!!<CR>
"noremap <silent> <F5> <esc><esc>gg49O<esc>G49o<esc>50%<cr>

"Make CTRL-B insert word in dictionary; useful.
inoremap <C-B> <C-G>u<Esc>[s1zg``a<C-G>u

" Set CTRL-F to correct last spelling mistake
" with independent undo from the rest of the document.
imap <c-f> <c-g>u<Esc>[s1z=`]a<c-g>u
nmap <c-f> [s1z=<c-o>

xmap ga <Plug>(EasyAlign) " Start interactive EasyAlign in visual mode (e.g. vipga)
nmap ga <Plug>(EasyAlign) " Start interactive EasyAlign for a motion/text object (e.g. gaip)

" Comfortable easymotion binding
nmap <Space> <Plug>(easymotion-bd-W)

" Fold motions using arrow keys
nnoremap z<down> zj
nnoremap z<up> zk

" Insert newlines without leaving normal mode
nnoremap oo o<Esc>
nnoremap OO O<Esc>j

" Quick Unicode insert with ctrl-shift-u
" This should probably be replaced with
" a table-menu-style plugin.
inoremap <C-U> <C-G>u<C-U>
