" File: .vimrc
" Author: mongoose
" Description: my vim config

call plug#begin('~/.vim/vim-plugged')

" general syntax support
"Plug 'sheerun/vim-polyglot'

" simplified clipboard functionality for vim
" Plug 'svermeulen/vim-easyclip'

" will configure latter
"Plug 'skywind3000/asyncrun.vim'

"Plug 'vheon/vim-cursormode'

Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes' | Plug '~/.vim/customs/vim-airline'
" Plug 'itchyny/lightline.vim'

"Plug 'romainl/vim-qf'

Plug 'pbrisbin/vim-mkdir'
"usage:
":e this/does/not/exist/file.txt
":w
"will auto mkdir this/does/not/exist

Plug 'jiangmiao/auto-pairs'

"Plug 'will133/vim-dirdiff'

" Plug 'hecal3/vim-leader-guide'

"Plug 'editorconfig/editorconfig-vim'

Plug 'ntpeters/vim-better-whitespace'

"Plug 'Yggdroot/indentLine

"Plug 'thaerkh/vim-indentguides'

Plug 'pbrisbin/vim-restore-cursor'

"Plug 'terryma/vim-multiple-cursors'

" Target text *after* the designated characters
Plug 'junegunn/vim-after-object'
autocmd VimEnter * call after_object#enable('=', ';', '-', '#', ' ')
"usage:
"va= visual after =
"ca= change after =
"da= delete after =
"ya= yank after =

"Plug 'Konfekt/FastFold'

" workspace/session support{{{
Plug 'tpope/vim-obsession'
" Plug 'thaerkh/vim-workspace'
" let g:workspace_session_disable_on_args = 1
" Plug 'xolox/vim-session'
" should configure latter
"}}}

Plug 'junegunn/rainbow_parentheses.vim'
"Plug 'kien/rainbow_parentheses.vim'

" conflict with nerdcommenter <leader>cc
"Plug 'mh21/errormarker.vim'

" plugin for formatting code, will config it later
"Plug 'sbdchd/neoformat'

" missing motion for vim
"Plug 'justinmk/vim-sneak'

" Plug 'drmikehenry/vim-fixkey'

" vim plugin that displays tags in a window, ordered by scope
"Plug 'majutsushi/tagbar'

" Plug 'xolox/vim-easytags'

" swap window without break windows size
"Plug 'wesQ3/vim-windowswap'

" vim easy align
" add some like viga=<CR> function
"Plug 'junegunn/vim-easy-align'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } | Plug '~/.vim/customs/nerdtree'

" snippets {{{
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
"}}}

" lsp support
Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \}

" completion {{{
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
  \ | Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
  \ | Plug '~/.vim/customs/deoplete'
if !has('nvim')
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" python complete for deoplete
"Plug 'zchee/deoplete-jedi'
" jedi-vim
" Plug 'davidhalter/jedi-vim', {
    " \'for': ['python'],
    " \'do': function('InstallJediDeps')
    " \}
"}}}

" commenter {{{
Plug 'scrooloose/nerdcommenter'
" Plug 'tpope/vim-commentary'
" Plug 'tomtom/tcomment_vim'
"}}}

" better numbertoggle {{{
"Plug 'jeffkreeftmeijer/vim-numbertoggle'
"Plug 'myusuf3/numbers.vim'
"Plug 'kennykaye/vim-relativity'
set number
"}}}

" linter ale
Plug 'w0rp/ale' | Plug '~/.vim/customs/ale'

" colorscheme {{{
Plug 'junegunn/seoul256.vim'
"Plug 'chriskempson/base16-vim'
" for dark 233(darkest) ~ 239(lightest)
" for light 253(darkest) ~ 256(lightest)
let g:seoul256_background = 233
"}}}

" lengthmatters: highlight the flooding art of an overly long line
Plug 'whatyouhide/vim-lengthmatters' | Plug '~/.vim/customs/vim-lengthmatters'

" easymotion, <leader><leader>f like function
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'haya14busa/incsearch.vim'
Plug '~/.vim/customs/vim-easymotion'

" vim-anzu: display search status
"Plug 'osyo-manga/vim-anzu' | Plug '~/.vim/customs/vim-anzu'

" fancy fold texts
Plug 'Konfekt/FoldText' | Plug '~/.vim/customs/FoldText'

" fzf
Plug '~/.fzf'| Plug 'junegunn/fzf.vim'| Plug '~/.vim/customs/fzf'

" leader-f
" an asynchronous fuzzy finder which is used to quickly locate files, buffers, mrus, tags, etc. in large project
"Plug 'Yggdroot/LeaderF', { 'do': './install.sh' } | Plug 'Yggdroot/LeaderF-marks' | Plug '~/.vim/customs/LeaderF'

" undotreee
Plug 'mbbill/undotree' | Plug '~/.vim/customs/undotree'

"Plug 'Glench/Vim-Jinja2-Syntax'

Plug 'tmux-plugins/vim-tmux'

" vim tmux navigator
Plug 'christoomey/vim-tmux-navigator' | Plug '~/.vim/customs/vim-tmux-navigator'

" add/del/chagne surround like "/[/]/</>
Plug 'tpope/vim-surround'

" add some [oi like function
Plug 'tpope/vim-unimpaired'

Plug 'tpope/vim-fugitive'

" add Delete Rename Chmod SudoWtrite SudoEdit etc. function
Plug 'tpope/vim-eunuch'

Plug 'tpope/vim-repeat'

" easyily search for, substitute, and abbreviate multiple variants of a word
Plug 'tpope/vim-abolish'

" enable repeating supported plugin maps with "."
Plug 'tpope/vim-repeat'

" Asynchronous build and test dispatcher 发报机
Plug 'tpope/vim-dispatch'

Plug 'tpope/vim-dotenv'

" directory viewer for vim
Plug 'justinmk/vim-dirvish' | Plug '~/.vim/customs/vim-dirvish'

" project configuration
Plug 'tpope/vim-projectionist'

" dirvish support for tpope's plug "projectionist"
" should install tpope's plug 'projectionist'
Plug 'fsharpasharp/vim-dirvinist'

" many vim function helper
"Plug 'LucHermitte/lh-vim-lib'
" add project-specify vimrc support
" currently it is actually supporting each file local vimrc not project
" so it runs every file buffer in the sub dir of the _vimrc_local.vim
" althernatives: embear/vim-localvimrc, tpope/projectionist (should be configured extra)
"Plug 'LucHermitte/local_vimrc'

" Plug 'direnv/direnv.vim'


"Plug 'vim-ruby/vim-ruby', {'for': ['ruby']}

Plug 'WolfgangMehner/bash-support', {'for': 'sh'}

" python {{{
Plug 'python-mode/python-mode', { 'for' : 'python' , 'branch': 'develop'} | Plug '~/.vim/customs/python-mode'


Plug 'vim-python/python-syntax', {'for': 'python'}

" conda support
Plug 'cjrh/vim-conda'| Plug '~/.vim/customs/vim-conda'

Plug 'tmhedberg/SimpylFold', {'for': 'python'}
" }}}

Plug 'plasticboy/vim-markdown'

" vim-textobj {{{
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] }
Plug 'sgur/vim-textobj-parameter'
" }}}

" ansibel support
" Plug 'pearofducks/ansible-vim'

" .tmux support like: K for `man tmux`; :make for source; g! and g!! for run as tmux commands
Plug 'tmux-plugins/vim-tmux'

" dockerfile syntax support and snippets for dockerfile
"Plug 'ekalinin/Dockerfile.vim'

" move line down and up
Plug 'matze/vim-move' | Plug '~/.vim/customs/vim-mode'

call plug#end()

let g:mapleader=','
set softtabstop=2
set shiftwidth=2
filetype on
syntax on
"set number relativenumber
set ignorecase
set smartcase

if has('smartindent')
    set smartindent
endif
" modeline 用于指示这个范围内的set之类的起作用
set modeline
set modelines=5

" default split window position
set splitright
set splitbelow

" 高亮鼠标所在的行
set cursorline
" 高亮鼠标所在的列
set cursorcolumn

set mouse=a
" config list whitespace {{{
set list                              " show whitespace
set listchars=nbsp:⦸                  " CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
set listchars+=tab:▷┅                 " WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7)
                                     " + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505, UTF-8: E2 94 85)
set listchars+=extends:»              " RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
set listchars+=precedes:«             " LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
set listchars+=trail:•                " BULLET (U+2022, UTF-8: E2 80 A2)
" }}}
set nojoinspaces                      " don't autoinsert two spaces after '.', '?', '!' for join command

" lazydraw, can use ctrl_L to redraw
"set lazyredraw

set previewheight=5

set scrolloff=3
set sidescrolloff=2

set wrap
if has('linebreak')
    set linebreak
    let &showbreak='↳↳'              " DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)
endif
if has('windows')
    set fillchars=vert:┃              " BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
    set fillchars+=fold:·             " MIDDLE DOT (U+00B7, UTF-8: C2 B7)
endif
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo

"noremap <C-c> :<C-u>q<cr>
"noremap <C-q> :<C-u>q!<cr>

if !has('nvim')
    syntax on
    filetype plugin indent on
    set autoindent
    set autoread
    set backspace=indent,eol,start
    set belloff=all
    set complete-=i
    set display=lastline
    set formatoptions=tcqj
    set history=10000
    set hlsearch
    set incsearch
    set langnoremap
    set laststatus=2
    set nocompatible
    set nrformats=bin,hex
    set ruler
    set sessionoptions-=options
    set showcmd
    set smarttab
    set tabpagemax=50
    set tags=./tags;,tags
    set ttyfast
    set viminfo+=!
    set wildmenu
endif
colo seoul256
