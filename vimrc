set nocompatible

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins {{{
call plug#begin()

" UI {{{
    Plug 'morhetz/gruvbox'                      " Colour theme
    Plug 'itchyny/lightline.vim'                " Light status line
" }}}

" Tools {{{
    Plug 'scrooloose/nerdtree'                  " Tree file manager
    Plug 'majutsushi/tagbar'                    " Modules/classes/methods manager
    Plug 'ctrlpvim/ctrlp.vim'                   " Fuzzy finder
    Plug 'nixprime/cpsm', { 'do': 'env PY3=ON ./install.sh' }  " matcher for CtrlP
    Plug 'dyng/ctrlsf.vim'                      " Fuzzy search
    Plug 'tpope/vim-commentary'                 " Comment out
    Plug 'tpope/vim-surround'                   " Surround with s
    Plug 'Raimondi/delimitMate'                 " Auto close quotes, parenthesis, brackets, etc.
    Plug 'w0rp/ale'                             " Lint engine
    " Plug 'mbbill/undotree'                      " local file changes history
    Plug 'Konfekt/FastFold'                     " Update fold only on events 
    Plug 'easymotion/vim-easymotion'            " Easy motion
" }}}

" Git {{{
    " Plug 'airblade/vim-gitgutter'               " Remove/modify/new line signs for git
    " Plug 'xuyuanp/nerdtree-git-plugin'          " Git changes in tree
    Plug 'tpope/vim-fugitive'                   " Git commands
    Plug 'junegunn/gv.vim'                      " Commit browser with GV command
" }}}

" Snippets {{{
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    
    " c-j c-k for moving in snippet
    smap <c-u> <Plug>(ultisnips_expand)
    let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
    let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
    let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
    let g:UltiSnipsRemoveSelectModeMappings = 0

" }}}

" Autocomplete {{{
    " Plug 'maralla/completor.vim'
    " Plug 'asyncomplete'

    " NCM2 {{{
        Plug 'roxma/vim-hug-neovim-rpc'
        Plug 'ncm2/ncm2'
        Plug 'roxma/nvim-yarp'

        " Highlight match in results
        Plug 'ncm2/ncm2-match-highlight'

        " Sources
        Plug 'ncm2/ncm2-bufword'
        Plug 'ncm2/ncm2-path'
        Plug 'ncm2/ncm2-ultisnips'
        Plug 'filipekiss/ncm2-look.vim'

        " enable ncm2 for all buffers
        autocmd BufEnter * call ncm2#enable_for_buffer()

        " Use tab to navigate through results
        inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
        inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

        " expand snippets
        inoremap <silent> <expr> <CR> ((pumvisible() && empty(v:completed_item)) ?  "\<c-y>\<cr>" : (!empty(v:completed_item) ? ncm2_ultisnips#expand_or("", 'n') : "\<CR>" ))
        imap <expr> <c-u> ncm2_ultisnips#expand_or("\<Plug>(ultisnips_expand)", 'm')
    " }}}

    " show menu for one result, do not select result item, do not insert
    " result item into text
    set completeopt=noinsert,menuone,noselect

    " don't show completion messages
    set shortmess+=c
" }}}

" Python {{{
    Plug 'lambdalisue/vim-pyenv'
    Plug 'davidhalter/jedi-vim'
    " Plug 'dbsr/vimpy'                           " automatic imports
    Plug 'tmhedberg/SimpylFold'                 " Fold python code
    Plug 'vim-scripts/indentpython.vim'
" }}}

" Jinja2 {{{
    Plug 'Glench/Vim-Jinja2-Syntax'
" }}}

" Html {{{
    Plug 'alvan/vim-closetag'                   " Auto close tags in html
    Plug 'othree/html5.vim'                     " Syntax
" }}}

" TypeScript {{{
    Plug 'HerringtonDarkholme/yats.vim'
    " Plug 'leafgarland/typescript-vim'
" }}}

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

" NERDTree {{{
    let NERDTreeIgnore = ['\.pyc$', '\.pyo$', '^__pycache__', 'build', 'venv', 'egg', 'egg-info/', 'dist']
" }}}

" CtrlP {{{
    let g:ctrlp_custom_ignore = '\vbuild/|dist/|venv/|target/|__pycache__/|\.git/\.(o|swp|pyc|egg|pyo)$'
    let g:ctrlp_match_func = { 'match': 'cpsm#CtrlPMatch' }
" }}}

" CtrlSF {{{
let g:ctrlsf_ackprg = '/usr/bin/ag'
nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>
" }}}

" Snippets {{{
    " let g:UltiSnipsExpandTrigger="<C-e>"
    " let g:UltiSnipsJumpForwardTrigger="<c-b>"
    " let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" }}}

" Python {{{
    " turn off completion
    let g:jedi#completions_enabled = 0

    let g:jedi#goto_command = "<leader>d"
    let g:jedi#goto_assignments_command = "<leader>g"
    let g:jedi#documentation_command = "K"
    let g:jedi#usages_command = "<leader>n"
    let g:jedi#rename_command = "<leader>r"

    let g:vimpy_prompt_resolve = 1
    let g:vimpy_remove_unused = 1
" }}}

" ALE {{{
let g:ale_fixers = {
            \   'python': [
            \       'trim_whitespace',
            \       'remove_trailing_lines',
            \       'isort',
            \       'yapf'
            \   ],
            \}
let g:ale_linters = {
            \ 'python': ['flake8']
            \}
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
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
map <Leader>p "+p
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
nnoremap <leader>s :mksession<CR>
" Fuzzy search
nnoremap <leader>f :CtrlSF 
" }}}

" Settings {{{
    
   set clipboard=unnamed,unnamedplus 

" Colors {{{
syntax enable           " enable syntax processing
" set t_Co=256
set background=dark
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_italic='1'
colorscheme gruvbox
" }}}

" Spaces & Tabs {{{
set backspace=indent,eol,start  " make backspace work as usual
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
" set cursorline          " highlight current line
set showmatch           " highlight matching parenthesis
set scrolloff=3         " when scrolling, keep cursor 3 lines away from screen border
set wildmenu              " autocompletion of files and commands behaves like shell
set wildmode=list:longest " (complete only the common part, list the options that match)
set laststatus=2
set noshowmode                  " mode is shown in status line, hide default
set lazyredraw
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

" Spelling {{{
set spelllang=en                " spell checking language
set spellfile=$HOME/.vim/spell/en.utf-8.add     " file to add new words for spell checking
set spell                       " turn on spell checking
hi clear SpellBad
hi SpellBad cterm=underline
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
    autocmd FileType python map <silent> <leader>b oimport pdb; pdb.set_trace()<esc>
    autocmd FileType python  setlocal
                \ tabstop=4
                \ softtabstop=4
                \ shiftwidth=4
                \ textwidth=79
                \ expandtab
                \ autoindent
                \ fileformat=unix
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

augroup html
    autocmd!
    autocmd FileType html setlocal foldmethod=syntax ts=2 sts=2 sw=2 expandtab
augroup END

" }}}

" Custom functions {{{

" strips trailing whitespace at the end of files. This
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

" Commands {{{
    " save as sudo
    ca w!! w !sudo tee "%"
" }}}
