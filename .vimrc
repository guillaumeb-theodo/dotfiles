" if has('nvim_starting')
  set nocompatible               " Be iMproved
  set runtimepath+=~/.vim/bundle/neobundle.vim/
" endif

filetype plugin indent off
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" Global
" Commentaires
NeoBundle "tomtom/tcomment_vim"
" Commandes Unix
NeoBundle "tpope/vim-eunuch"
" Analyseur syntaxique
NeoBundle "scrooloose/syntastic"
" Barre de status
NeoBundle 'bling/vim-airline'
" Barre de tags
NeoBundle "majutsushi/tagbar"
" Intégration avec tmux
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'edkolev/tmuxline.vim'
" Intégration avec Git
NeoBundle "tpope/vim-fugitive"
" Search with ag
NeoBundle 'rking/ag.vim'
" Cptrlp
NeoBundle 'kien/ctrlp.vim'
" Thème de couleurs
NeoBundle "brafales/vim-desert256"

call neobundle#end()
NeoBundleCheck
filetype plugin indent on
syntax on

" Autocmd
if exists("b:autocmd_loaded")
else
  let b:autocmd_loaded=1
  " Auto reload vimrc
  autocmd bufwritepost .vimrc source $MYVIMRC
  " Actualise xresources
  autocmd bufwritepost *Xresource* !xrdb ~/.Xresources
endif

" Options diverses
" Encodage
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" Mappage du leader
let mapleader=","
let maplocalleader=";"

" Tabs et indentation
set expandtab
set bs=2
set smarttab
set shiftwidth=2
set smartindent
set autoindent
set shiftround

" Backup et swap
set writebackup
set noswapfile

" Recherche
set hlsearch
set incsearch

" Divers
set mouse=a
set hidden
set autochdir

" Affichage
set showmode
set showcmd
set display=lastline
set background=dark
colorscheme desert256

" Folding
set foldenable
set foldmethod=syntax

" insertion d'un caractère
nmap <Space> i_<Esc>r

" aspell
set spelllang =fr
set spellsuggest =5
let g:tex_comment_nospell= 1
set nospell " Pas de correction par défaut

" Set to auto read when a file is changed from the outside
set autoread

" Wild (auto-complétion du mode commande)
set wildignore+=*.pdf,*.native,*.byte,*.class,*.o,*.hi
set wildignorecase
set wildmenu
set wildmode=list:longest,full

"Always show current position
set ruler

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" j et k respectent le line wrapping
" nnoremap j gj
" nnoremap k gk

" Clear buffer search when pressing ",/"
nmap <silent> <leader>/ :nohlsearch<CR>

" statusline
set statusline=%<%f\    " Filename
set statusline+=%w%h%m%r " Options
set statusline+=%{fugitive#statusline()} "  Git Hotness
set statusline+=\ [%{getcwd()}]          " current dir
set statusline+=%=%-14.((%l,%c)/%L%V%)\ %p%%  " Right aligned file nav info
set laststatus=2
let g:airline_theme = 'serene'
let g:airline_powerline_fonts = 1
let g:airline_enable_branch = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" Relative numbers oncommand mode
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber
set number
set relativenumber

" Sudo save
command! WW :execute ':silent w !sudo tee % > /dev/null' | :edit!
command! WQ :execute ':silent w !sudo tee % > /dev/null' | :q!

" Increase history
set history=1000

" linebreak
set linebreak
set showbreak=\|

" Diff a buffer with the corresponding saved file
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" CtrlP
map ,b :CtrlPBuffer<CR>
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|tox)$'
let g:ctrlp_user_command = "find %s -type f | grep -Ev '"+ g:ctrlp_custom_ignore +"'"

"Ack
let g:ackprg = 'ag'
let g:ack_wildignore = 0

" make
map [21~ :w \| mak<CR>

" Syntastic
let g:syntastic_always_populate_loc_list=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'
let g:syntastic_auto_loc_list=1
let g:syntastic_aggregate_errors = 1
let g:airline_enable_syntastic = 1

" Tagbar
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" Save
imap ,w <ESC>:w<CR>a
map ,w :w<CR>
