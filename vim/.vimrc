set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
let g:ucm_global_ucm_extra_conf = '/usr/share/vim/vimfiles/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ucm_server_python_interpreter = '/usr/local/bin/python'
let g:neocomplete#enable_at_startup = 1
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
execute pathogen#infect()
" Put your non-Plugin stuff after this line

"filetype plugin on
"set omnifunc=syntaxcomplete#Complete

" Get some cool plugins at http://vimawesome.com/

set tabstop=2
syntax on
set mouse=a
set number
set showmatch
set noshowmode
set shiftwidth=2
set shiftround
set expandtab
set autoindent
set cursorline
set ruler
set background=dark
colorscheme desert256
let g:hybrid_custom_term_colors = 1
"colorscheme hybrid
set backspace=indent,eol,start
" Below is to show all chars!
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
" These are setting the backup dirs
set backupdir=~/.vimbackups/swap,/tmp
set directory=~/.vimbackups/backups,/tmp
set udf
set udir=~/.vimbackups/undo,/tmp

let g:airline#extensions#tabline#enabled = 1
let NERDTreeDirArrows=1
let NERDTreeShowHidden=1 
let NERDTreeSortHiddenFirst=1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:conoline_auto_enable = 1

let g:vim_pbcopy_local_cmd = "pbcopy"

hi TabLine      ctermfg=Black  ctermbg=Green     cterm=NONE
hi TabLineFill  ctermfg=Black  ctermbg=Green     cterm=NONE
hi TabLineSel   ctermfg=White  ctermbg=DarkBlue  cterm=NONE
let g:tablineclosebutton=1

set ts=2 sw=2 et
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

let mapleader= " "
let g:indent_guides_enable_on_vim_startup = 0
"set list lcs=tab:\|\ 
nnoremap <leader>m <C-W><C-W>
map <leader>n :NERDTreeToggle<CR>
map <leader>a :qa!<CR>
map <leader>q ZQ
map <leader>z ZZ
map <leader>w :w<CR>
map <leader><TAB> :bnext!<CR>
map <leader><S-TAB> :bprev!<CR>
map <leader>` :enew<CR>
map <leader>~ :bd<CR>
map <leader>l :ls<CR>
map <leader>1 :set list!<CR>
map <leader>0 :set number!<CR>
map <leader>h :ConoLineToggle<CR>
map <leader>s :Gstatus<CR>
map <leader>k :set relativenumber!<CR>
map <leader>t :terminal<CR>
map <leader>i :IndentGuidesToggle<CR>
"map <leader>ig :IndentGuidesToggle<CR>

hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey

cmap w!! w !sudo tee % >/dev/nul
