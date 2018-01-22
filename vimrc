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
Plug 'itchyny/lightline.vim'                " Light status line
" Tools
Plug 'scrooloose/nerdtree'                  " Tree file manager
Plug 'majutsushi/tagbar'                    " Modules/classes/methods manager
Plug 'ctrlpvim/ctrlp.vim'                   " Fuzzy finder
Plug 'dyng/ctrlsf.vim'                      " Fuzzy search
Plug 'tpope/vim-commentary'                 " Comment out
Plug 'tpope/vim-surround'                   " Surround with s
" Plug 'https://github.com/idanarye/vim-vebugger'   -- consider to use
Plug 'w0rp/ale'                             " Code validation
Plug 'Raimondi/delimitMate'                 " Auto close quotes, parenthesis, brackets, etc.
" Plug 'gko/vim-coloresque'                   " Colorize colors in css
" Plug 'thaerkh/vim-workspace'                " Session and autosave
" Plug 'shmargum/vim-sass-colors'             " Show colors in css, sass
" Git
Plug 'airblade/vim-gitgutter'               " Remove/modify/new line signs for git
Plug 'xuyuanp/nerdtree-git-plugin'          " Git changes in tree
Plug 'tpope/vim-fugitive'                   " Git commands
Plug 'junegunn/gv.vim'                      " Commit browser with GV command
" Snippets
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
" Html
Plug 'rstacruz/sparkup'                     " expand html from css like syntax
" Plug 'valloric/matchtagalways'              " match html tags
" Autocomplete
Plug 'ilex/aiocomplete.vim'
" Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp'
" Plug 'prabirshrestha/asyncomplete-lsp.vim'
" Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
" Plug 'prabirshrestha/asyncomplete-buffer.vim'
" Plug 'felixfbecker/php-language-server', {'do': 'composer install && composer run-script parse-stubs'}
" Plug 'maralla/completor.vim'
" Vim
" Plug 'pseewald/vim-anyfold'                 " Fold code blocks with za, ..., move with ]], etc
" Plug 'junegunn/vader.vim'                   " vim test framework
" Python
Plug 'Vimjas/vim-python-pep8-indent'        " Indent python code
" Plug 'vim-python/python-syntax'             " highlight python code
Plug 'tmhedberg/SimpylFold'                 " Properly fold python code
" Plug 'davidhalter/jedi-vim'                 " Jedi vim 
Plug 'lambdalisue/vim-pyenv'                " pyenv
" Jinja2
Plug 'Glench/Vim-Jinja2-Syntax'
" PHP
" Plug 'StanAngeloff/php.vim'                 " Php syntax (try)
" Plug 'tobyS/pdv'                            " Php documenter (try)
call plug#end()
" }}}

" Plugins Options {{{

" LightLine {{{
    let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }
" }}}

" Autocomplete {{{
    " Use Tab to navigate
    inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
    set completeopt=menu,menuone,noselect

    let s:completors = {}
    let s:completors['buffer'] = {
                \ 'exclude': ['python'],
                \ 'invoke_pattern': '\h\w*$'
                \ }

    let s:completors['jedi'] = {
                \ 'include': ['python'],
                \ 'priority': 0,
                \ }

    let s:completors['neosnippet'] = {
                \ 'include': ['*'],
                \ 'priority': 1,
                \ }

    call aiocomplete#init({
                \ 'completors': s:completors,
                \ 'debounce_delay': 200
                \ })
" }}}

" Ale {{{
    let g:airline#extensions#ale#enabled = 1
    let g:ale_lint_delay = 1000
" }}}

" Snippets {{{
    " let g:UltiSnipsExpandTrigger="<c-e>"
    imap <C-e>     <Plug>(neosnippet_expand_or_jump)
    smap <C-e>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-e>     <Plug>(neosnippet_expand_target)
" }}}

" Python {{{
let g:python_highlight_all = 1
let g:jedi#completions_enabled = 0
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
" Yank and put helpers. (try)
noremap <leader>y :let @0=getreg('*')<CR>
" noremap <leader>p        "0]p
noremap <leader>P "0]P'
" Session start
nnoremap <leader>s :ToggleWorkspace<CR>
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
set laststatus=2
set noshowmode                  " mode is shown in status line, hide default
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

" augroup phpSyntaxOverride
"    autocmd!
"    autocmd FileType php call PhpSyntaxOverride()
" augroup END

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

function! PhpSyntaxOverride()
    hi! def link phpDocTags  phpDefine
    hi! def link phpDocParam phpType
endfunction

" }}}
