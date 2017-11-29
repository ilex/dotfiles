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
" Plug 'maralla/validator.vim'                " Code validation
" Plug 'https://github.com/idanarye/vim-vebugger'   -- consider to use
Plug 'w0rp/ale'                             " Code validation
Plug 'Raimondi/delimitMate'                 " Auto close quotes, parenthesis, brackets, etc.
Plug 'gko/vim-coloresque'
" Plug 'shmargum/vim-sass-colors'             " Show colors in css, sass

" Git
Plug 'airblade/vim-gitgutter'               " Remove/modify/new line signs for git
Plug 'xuyuanp/nerdtree-git-plugin'          " Git changes in tree
Plug 'tpope/vim-fugitive'                   " Git commands
" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Html 
Plug 'rstacruz/sparkup'                     " expand html from css like syntax
" Autocomplete
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'
Plug 'felixfbecker/php-language-server', {'do': 'composer install && composer run-script parse-stubs'}
" Vim
" Plug 'pseewald/vim-anyfold'                 " Fold code blocks with za, ..., move with ]], etc
Plug 'junegunn/vader.vim'                   " vim test framework
" Python
Plug 'Vimjas/vim-python-pep8-indent'        " Indent python code
Plug 'vim-python/python-syntax'             " highlight python code
Plug 'tmhedberg/SimpylFold'                 " Properly fold python code
" Jinja2
Plug 'Glench/Vim-Jinja2-Syntax'
call plug#end()
" }}}

" Plugins Options {{{

" Airline {{{
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#tabline#left_sep = ' '
    let g:airline#extensions#tabline#left_alt_sep = '|'
    let g:airline#extensions#branch#format = 2
    " hide spell
    let g:airline_detect_spell=0
    " hide encoding
    let g:airline_section_y=''
    set laststatus=2
" }}}

" Autocomplete {{{
    set completeopt=menuone,menu,longest,preview
    let g:asyncomplete_remove_duplicates = 1
    " Python 
    if executable('pyls')
        " pip install python-language-server
        au User lsp_setup call lsp#register_server({
            \ 'name': 'pyls',
            \ 'cmd': {server_info->['pyls']},
            \ 'priority': 3,
            \ 'whitelist': ['python'],
            \ })
    endif
    " Snippets
    call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
        \ 'name': 'ultisnips',
        \ 'whitelist': ['*'],
        \ 'priority': 1,
        \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
        \ }))
    " Buffer
    call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
        \ 'name': 'buffer',
        \ 'whitelist': ['*'],
        \ 'blacklist': ['go'],
        \ 'priority': 2,
        \ 'completor': function('asyncomplete#sources#buffer#completor'),
        \ })) 
    " php
    au User lsp_setup call lsp#register_server({                                    
        \ 'name': 'php-language-server',                                            
        \ 'cmd': {server_info->['php', expand('~/.vim/plugged/php-language-server/bin/php-language-server.php')]},
        \ 'whitelist': ['php'],                                                     
        \ })
    " Use Tab to navigate    
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
" }}}

" Ale {{{
    let g:airline#extensions#ale#enabled = 1
    let g:ale_lint_delay = 1000
" }}}

" Snippets {{{
    let g:UltiSnipsExpandTrigger="<c-e>"
" }}}

" Python syntax {{{
let g:python_highlight_all = 1
" }}}

" Git {{{
" turn off git signs
let g:gitgutter_enabled = 0
" }}}

" NERDTree {{{
    let NERDTreeIgnore = ['\.pyc$', '\.pyo$', '^__pycache__', 'build', 'venv', 'egg', 'egg-info/', 'dist']
" }}}

" CtrlP {{{
    let g:ctrlp_custom_ignore = '\vbuild/|dist/|venv/|target/|\.git/\.(o|swp|pyc|egg)$'
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
    " toggle file tree manager with F2
    map <F2> :NERDTreeToggle<CR>
    " toggle tags manager with F3
    map <F3> :TagbarToggle<CR>
    " fold/unfold
    nnoremap <space> za
    " ale go to next/previous error or warning
    nmap <silent> [e <Plug>(ale_previous_wrap)
    nmap <silent> ]e <Plug>(ale_next_wrap)
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
set showmatch           " highlight matching parenthesis
set scrolloff=3         " when scrolling, keep cursor 3 lines away from screen border
set wildmenu              " autocompletion of files and commands behaves like shell
set wildmode=list:longest " (complete only the common part, list the options that match)
" }}}

" Searching {{{
set ignorecase          " ignore case when searching
set incsearch           " search as characters are entered
" set hlsearch            " highlight all matches
noremap <leader>h :set hlsearch!<CR>
nnoremap / :set hlsearch<CR>/
" }}}

" Folding {{{
set foldmethod=indent   " fold based on indent level
set foldnestmax=10      " max 10 depth
set foldenable          " don't fold files by default on open
set foldlevelstart=10    " start with fold level of 1
" }}}
" }}}

" AutoGroups {{{
augroup config_group
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd FileType vim setlocal foldmethod=marker 
    autocmd BufRead .vimrc setlocal foldlevel=0 
    autocmd BufWritePre *.py,*.php,*.js,*.txt,*.hs,*.java,*.md,*.rb,*.css,*.jinja2,*.html :call <SID>StripTrailingWhitespaces()
augroup END

augroup python_group
    autocmd!
    autocmd FileType python setlocal signcolumn=yes
    " autocmd InsertLeave *.py :call <SID>StripTrailingWhitespaces()
    autocmd FileType python map <silent> <leader>b oimport pdb; pdb.set_trace()<esc>
augroup END

augroup jinja2_group
    autocmd!
    autocmd BufNewFile,BufRead *.html,*.jinja2 setlocal filetype=jinja
    autocmd FileType jinja setlocal autoindent smartindent ts=2 sts=2 sw=2 expandtab
augroup END

augroup yaml_group
    autocmd!
    autocmd FileType yaml setlocal autoindent smartindent ts=2 sts=2 sw=2 expandtab
augroup END

augroup sass_group
    autocmd!
    autocmd FileType scss setlocal autoindent smartindent ts=2 sts=2 sw=2 expandtab
augroup END
" }}}

" Commands {{{
" save as sudo
ca w!! w !sudo tee "%"
" }}} 

" Custom functions {{{

" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

" }}}
