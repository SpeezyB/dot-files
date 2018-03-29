" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by[1;13C]
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim
execute pathogen#infect()
" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
set nocompatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)
colorscheme desert256
set expandtab
set ruler
set number
set cursorline
set noshowmode
set nomodeline
set tabstop=2
set shiftwidth=2
set shiftround
set autoindent
set backspace=indent,eol,start

let g:conoline_auto_enable = 1
let NERDTreeDirArrows=1
let NERDTreeShowHidden=1
let NERDTreeSortHiddenFirst=1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

let g:airline#extensions#tabline#enabled = 1
hi TabLine      ctermfg=Black  ctermbg=Green     cterm=NONE
hi TabLineFill  ctermfg=Black  ctermbg=Green     cterm=NONE
hi TabLineSel   ctermfg=White  ctermbg=DarkBlue  cterm=NONE

" Source a global configuration file if available
"if filereadable("/etc/vim/vimrc.local")
"  source /etc/vim/vimrc.local
"endif

" Indent makers
"let g:indent_guides_enable_on_vim_startup =1
"set list lcs=tab:\|\ 
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣

let mapleader = " "
nnoremap <leader>m <C-W><C-W>
map <leader>n :NERDTreeToggle<CR>
map <leader>w :w<CR>
map <leader>a :qa!<CR>
map <leader>q ZQ
map <leader>z ZZ
map <leader><TAB> :bnext!<CR>
map <leader><S-TAB> :bprev!<CR>
map <leader>` :enew<CR>
map <leader>~ :bd<CR>
map <leader>l :ls<CR>
map <leader>h :ConoLineToggle<CR>
map <leader>0 :set number!<CR>
map <leader>1 :set list!<CR>
map <leader>k :set relativenumber!<CR>

cmap w!! w !sudo tee % >/dev/nul 
