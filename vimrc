nnoremap <SPACE> <Nop>
autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType c setlocal shiftwidth=4 softtabstop=4 expandtab

call plug#begin()

Plug 'wakatime/vim-wakatime'
Plug 'morhetz/gruvbox'
Plug 'ghifarit53/tokyonight-vim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-commentary'

call plug#end()

let mapleader=" "

set rtp+=/usr/bin/fzf
set rnu
set nu
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
set listchars=tab:▸\ ,trail:·,extends:>,precedes:<,eol:↴

" quick exit
inoremap jk <ESC>
inoremap JK <ESC>
" copy to system clipboard
nnoremap <leader>y [["+y]]
vnoremap <leader>y [["+Y]]
nnoremap <leader>gf :!go fmt %<CR>
" line move
vnoremap J :m '>+1<CR>gv=gvzz
vnoremap K :m '<-2<CR>gv=gvzz
" fast indent
vnoremap < <gv
vnoremap > >gv
" browser netwr
nnoremap <leader>pv :Ex!<CR>
" fuzzy finder search
nnoremap <leader><leader> :GFiles<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>/ :Rg<CR>
" center navigation
nnoremap n nzz
nnoremap N Nzz
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
" replace current text
nnoremap <leader>s :keepjumps %s/\<<C-r><C-w>\>/<C-r><C-w>/g<Left><Left>
nnoremap <silent> <leader>x :!chmod +x %<CR>
nnoremap <leader>gg :Git!<CR>
nnoremap <leader>gr :Rg <C-r><C-w><CR>
" don't copy deleted text with x
nnoremap x "_x
" undotree
nnoremap <leader>u :UndotreeToggle<CR>

set termguicolors

" let g:tokyonight_style = 'night' " available: night, storm
" let g:tokyonight_enable_italic = 1
" let g:tokyonight_transparent_background = 1
"
" colorscheme tokyonight
let g:gruvbox_italic=1
autocmd vimenter * ++nested colorscheme gruvbox
set background=dark    " Setting dark mode

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

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX) && getenv('TERM_PROGRAM') != 'Apple_Terminal')
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
Plug 'wakatime/vim-wakatime'
