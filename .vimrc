set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'markonm/traces.vim'
Plugin 'lervag/vimtex'
Plugin 'SirVer/ultisnips'
Plugin 'machakann/vim-sandwich'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/limelight.vim'
Plugin 'junegunn/goyo.vim'
Plugin 'junegunn/vim-easy-align'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Konfekt/FastFold'
Plugin 'tpope/vim-fugitive'
Plugin 'easymotion/vim-easymotion'
call vundle#end()

" Enable familiar backspace settings
set backspace=indent,eol,start

" Activate syntax highlighting
syntax on

" Narrow textwidth for compatibility with
" typesetting guidelines; not too great with
" monospace fonts, experiment.
set textwidth=67

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Cursor switching between normal and insert modes;
" Functionality depends on term emulator, not portable.
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

set t_RB= t_RF= t_RV= t_u7=

" Keybindings for UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let UltiSnipsJumpForwardTrigger = "<c-Right>"
let UltiSnipsJumpBackwardTrigger = "<c-Left>"
let g:UltiSnipsEditSplit="vertical"

" Insert newlines without leaving normal mode
nnoremap oo o<Esc>
nnoremap OO O<Esc>j

" Backup and undo settings
if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set nobackup		" do not keep a backup file (alt. : restore to previous version)
  set undofile		" keep an undo file (undo changes after closing)
endif

" keep 500 lines of command line history
set history=500		

" show the cursor position all the time
set ruler		

" display incomplete commands
set showcmd	

" do incremental searching
set incsearch		

" Quick Unicode insert with ctrl-shift-u
" This should probably be replaced with
" a menu-style plugin.
inoremap <C-U> <C-G>u<C-U>

" Mouse settings
if has('mouse')
  set mouse=a
endif

" Activate indent and plugins
if has("autocmd")

  filetype plugin indent on

  augroup vimrcEx
  au!

  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else
set autoindent	" always set autoindenting on
endif " has("autocmd")

" Turn on tex settings for lit files
 autocmd BufNewFile,BufRead *.lit setfiletype tex

" Diff settings for viewing file changes
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
  \ | wincmd p | diffthis
endif

"Compatibility check
if has('langmap') && exists('+langnoremap')
  set langnoremap
endif

" Auto re-source vimrc on write
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

" I need alt keys for stuff
set winaltkeys=no

" Clear search highlight; there really should be a better way.
command! C let @/=""

" Line number options
set number
set rnu

" Make zathura default view and latex default tex flavor
let g:tex_flavor='latex'
let g:vimtex_view_method = 'zathura'

" Default UltiSnips folder
let g:UltiSnipsSnippetDirectories = [$HOME.'/UltiSnips']

" Do not loop back to beginning when scanning
set nowrapscan

" Preparatory function to use with ref and eqref
fu! MyHandler(_) abort
    call feedkeys("\<c-x>\<c-o>", 'in')
endfu

" Custom colorscheme
colorscheme habiMath

" Powerline config
set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/

" Always show statusline
set laststatus=2

set tabstop=2
set shiftwidth=2  " Indents will have a width of 2

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
nnoremap <leader>nt :call NumberToggle()<cr>

" I do not use tags; use C-T to open Vimtex TOC
nnoremap <C-T> <ESC><ESC>:VimtexTocOpen<CR>

" Fold motions using arrow keys
nnoremap z<down> zj
nnoremap z<up> zk

" Ban swapfiles
set noswapfile

" Enable folds in vimtex
let g:vimtex_fold_enabled=1

" Runaway whitespace is a fact of life in latex
let g:airline#extensions#whitespace#enabled = 0

" Custom airline theme
let g:airline_theme='gruvnone'

" Mysterious code to fix issues with Airline.
" Please someone make this redundant, this is ridiculous.
let s:saved_theme = []
let g:airline_theme_patch_func = 'AirlineThemePatch'
function! AirlineThemePatch(palette)
    for colors in values(a:palette)
        if has_key(colors, 'airline_c') && len(s:saved_theme) ==# 0
            let s:saved_theme = colors.airline_c
        endif
        if has_key(colors, 'airline_term')
            let colors.airline_term = s:saved_theme
        endif
    endfor
endfunction

" Colorscheme deficiencies made me write this here
highlight VertSplit ctermfg=1 ctermbg=NONE cterm=NONE

" Make vertical filling char invisible
set fillchars=vert:\ "Trailing space

" Airline theme settings; declutter.
let g:airline_powerline_fonts = 1
let g:airline_right_sep=''
let g:airline_left_sep=''
let g:airline_left_alt_sep=''
let g:airline_right_alt_sep=''
let g:airline#extensions#branch#enabled=1

" Push auxiliary latex files into a build folder
let g:vimtex_compiler_latexmk = { 'build_dir' : './build'}

" No vimtex indent due to clashes with my principles.
let g:vimtex_indent_enabled = 0

" Folding small files
let g:fastfold_minlines = 0

augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END

" Line breaks are a must
set linebreak
" Activate highlight search
set hlsearch
"Small timeout
set ttimeoutlen=100
set timeoutlen=500

"Make fold demarcations pretty like nvim
set fillchars=fold:\.

" fzf preview settings
let g:fzf_preview_window = 'right:60%'

" Color for out of focus sections with limelight
let g:limelight_conceal_ctermfg = 'gray'

" Regex for limelight to include % demarcations
let g:limelight_bop = '\(^\s*$\n\|^\s*%$\n\)\zs'
let g:limelight_eop = '\ze\(^$\|^\s*%$\)'

" hi pri
let g:limelight_priority = -1

" Goyo 1 + textwidth
let g:goyo_width = 68

" Preformatting and window styling for comfy latex typing.
noremap <silent> <F2> <esc><esc>:Goyo<CR>
noremap <silent> <F3> <esc><esc>:call ScrollOffToggle()<CR>:Limelight!!<CR>
noremap <silent> <F5> <esc><esc>gg49O<esc>G49o<esc>50%<cr>

"Make CTRL-L fix typo; surprisingly useless :(
inoremap <C-L> <C-G>u<Esc>[s1z=``a<C-G>u

"Make CTRL-B insert word in dictionary; useful.
inoremap <C-B> <C-G>u<Esc>[s1zg``a<C-G>u

"Spellchecking on
set spell

" Automatically change pwd to current file
set autochdir

" Comfortable easymotion bindings
nmap  <Space> <Plug>(easymotion-bd-W)
map <C-Left> <Plug>(easymotion-linebackward)
map <C-Right> <Plug>(easymotion-lineforward)
map <C-Up> <Plug>(easymotion-k)
map <C-Down> <Plug>(easymotion-j)

" Remappings for the optimistic typist
"inoremap <Backspace> <C-w>
"inoremap <S-Right> <esc>Ea
"inoremap <S-Left> <esc>gEa
"inoremap <Right> <esc>ea
"inoremap <Left> <esc>gea
