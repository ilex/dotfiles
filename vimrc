set nocompatible

" Plugins {{{
" Use Vim Plug to manage plugins
" Install it with follow
" $ curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin()
" Theme
Plug 'altercation/vim-colors-solarized'
" Status line and tab line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Lokaltog/powerline'                   " Powerline fonts plugin
" Tools
Plug 'scrooloose/nerdtree'                  " Tree file manager
Plug 'majutsushi/tagbar'                    " Modules/classes/methods manager
Plug 'ctrlpvim/ctrlp.vim'                   " Fuzzy finder
Plug 'dyng/ctrlsf.vim'                      " Fuzzy search 
Plug 'tpope/vim-commentary'                 " Comment out
Plug 'tpope/vim-surround'                   " Surround with s
Plug 'maralla/validator.vim'                " Code validation
" Git
Plug 'airblade/vim-gitgutter'               " Remove/modify/new line signs for git
Plug 'xuyuanp/nerdtree-git-plugin'          " Git changes in tree
Plug 'tpope/vim-fugitive'                   " Git commands
" Html 
Plug 'rstacruz/sparkup'                     " expand html from css like syntax
call plug#end()
" }}}

" Plugins Options {{{

" Airline {{{
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#tabline#left_sep = ' '
    let g:airline#extensions#tabline#left_alt_sep = '|'
    let g:airline#extensions#branch#format = 2
    set laststatus=2
" }}}

" Completer {{{
    let g:validator_permanent_sign = 1
" }}}
 
" Gitgutter {{{
if exists('&signcolumn')  " Vim 7.4.2201
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif
" }}}
" }}}

" Keys mapping {{{
    " move through windows
    map <C-l> <c-w>l
    map <C-h> <c-w>h
    map <C-k> <c-w>k
    map <C-j> <c-w>j
    " move vertically by visual line
    nnoremap j gj
    nnoremap k gk
    " map ESC to jj
    imap jj <Esc>
    " open file tree manager with F2
    map <F2> :NERDTreeToggle<CR>
    " open tags manager with F3
    map <F3> :TagbarToggle<CR>
" }}}

" Leader Shortcuts {{{
let mapleader=","
" paste from external buffer
map <Leader>p "*p
" save file
map <leader>w :w<CR>
" quit file
map <leader>x :q<CR>
" quit all
map <leader>q :qa<CR>
" }}}
" Settings {{{

" Colors {{{
syntax enable           " enable syntax processing
set t_Co=256
let g:solarized_termcolors=256
set background=dark
colorscheme solarized
" }}}

" Misc {{{
set ttyfast                     " faster redraw
set lazyredraw
set backspace=indent,eol,start  " make backspace work as usual
set updatetime=1000             " update to show git gutters
set autochdir 			        " automatically change window's cwd to file's dir
set spelllang=en                " spell checking language
set spellfile=$HOME/.vim/spell/en.utf-8.add     " file to add new words for spell checking
set spell                       " turn on spell checking
" }}}

" Spaces & Tabs {{{
set tabstop=4           " 4 space tab
set expandtab           " use spaces for tabs
set softtabstop=4       " 4 space tab
set shiftwidth=4
set modelines=1      	" set options for particular file (ex.: " vim: tabstop:2)
filetype indent on
filetype plugin on
set autoindent
" }}}

" UI Layout {{{
set number              " show line numbers
set showcmd             " show command in bottom bar
set cursorline          " highlight current line
set showmatch           " higlight matching parenthesis
set scrolloff=3         " when scrolling, keep cursor 3 lines away from screen border
set wildmenu              " autocompletion of files and commands behaves like shell
set wildmode=list:longest " (complete only the common part, list the options that match)
" }}}

" Searching {{{
set ignorecase          " ignore case when searching
set incsearch           " search as characters are entered
" set hlsearch            " highlight all matches
" }}}

" Folding {{{
set foldmethod=indent   " fold based on indent level
set foldnestmax=10      " max 10 depth
set foldenable          " don't fold files by default on open
" nnoremap <space> za
set foldlevelstart=10    " start with fold level of 1
" }}}
" }}}

" AutoGroups {{{
augroup config_group
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd FileType vim setlocal foldmethod=marker 
    autocmd BufRead .vimrc setlocal foldlevel=0 
augroup END
" }}}
