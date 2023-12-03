nnoremap <SPACE> <Nop>
autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType c setlocal shiftwidth=4 softtabstop=4 expandtab

let mapleader=" "

set rtp+=/usr/bin/fzf
set rnu
set nocompatible
filetype on
filetype indent on
filetype plugin on
syntax on
set shiftwidth=4
set tabstop=4
set nobackup
set scrolloff=8
set nowrap
set incsearch
set ignorecase
set history=1000
set list
set listchars=eol:↴,trail:~
set mps+=<:>

" quick exit
inoremap jk <ESC>
inoremap JK <ESC>
" copy to system clipboard
nnoremap <leader>y [["+y]]
vnoremap <leader>y [["+Y]]
" line move
vnoremap J :m '>+1<CR>gv=gvzz
vnoremap K :m '<-2<CR>gv=gvzz
" fast indent
vnoremap < <gv
vnoremap > >gv
" browser netwr
nnoremap <leader>pv :Ex!<CR>
" fuzzy finder search
nnoremap <leader>ff :FZF<CR>
" center navigation
nnoremap n nzz
nnoremap N Nzz
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
" replace current text
nnoremap <leader>s [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]
nnoremap <silent> <leader>x :!chmod +x %<CR>
" don't copy deleted text with x
nnoremap x "_x
" undotree
nnoremap <leader>u :UndotreeToggle<CR>

colors deus


if has("persistent_undo")
   let target_path = expand('~/.undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif



" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

