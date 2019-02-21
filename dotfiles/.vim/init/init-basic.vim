set encoding=UTF-8
scriptencoding utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
" Use Unix as the standard file type
set fileformats=unix,dos,mac
set fileencoding=UTF-8

set autoread

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
set softtabstop=2
set shiftwidth=2
filetype on
syntax on
set number relativenumber
set ignorecase
set smartcase

if has('smartindent')
    set smartindent
endif

if has('linebreak')
  set linebreak
  let &showbreak='↳↳'              " DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)
endif
if has('windows')
  set fillchars=vert:┃              " BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
  set fillchars+=fold:·             " MIDDLE DOT (U+00B7, UTF-8: C2 B7)
endif
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo

" modeline 用于指示这个范围内的set之类的起作用
set modeline
set modelines=5

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
set lazyredraw

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

set suffixes=.bak,~,.o,.lo,.h,.info,.swp,.obj,.pyc,.pyo,.egg-info,.class

set wildignore=*.o,*.lo,*.obj,*~,*.exe,*.a,*.pdb,*.lib "stuff to ignore when tab completing
set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex,*.svn
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz    " MacOSX/Linux
set wildignore+=*DS_Store*,*.ipch
set wildignore+=*.gem
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.zip,*/.Trash/**,*.pdf,*.dmg,*/.rbenv/**
set wildignore+=*/.nx/**,*.app,*.git,.git
set wildignore+=*.wav,*.mp3,*.ogg,*.pcm
set wildignore+=*.mht,*.suo,*.sdf,*.jnlp
set wildignore+=*.chm,*.epub,*.pdf,*.mobi,*.ttf
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*.ppt,*.pptx,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
set wildignore+=*.msi,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu
set wildignore+=*.gba,*.sfc,*.078,*.nds,*.smd,*.smc
set wildignore+=*.linux2,*.win32,*.darwin,*.freebsd,*.linux,*.android

" Puts new vsplit windows to the right of the current
set splitright
" Puts new split windows to the bottom of the current
set splitbelow
" Avoid the pop up menu occupying the whole scree
"set pumheight=20

"set shortmess=atOI

" 左下角显示当前vim模式
set showmode

" 在上下移动光标时，光标的上方或下方至少会保留显示的行数
set scrolloff=7

" 命令行（在状态行下）的高度，默认为1，这里是2
"set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P

" 括号配对情况, 跳转并高亮一下匹配的括号
set showmatch
" How many tenths of a second to blink when matching brackets
set matchtime=2

" 设置代码折叠
if has('folding')
" 允许代码折叠
    set foldenable
    " 代码折叠默认使用缩进
    set fdm=indent
    " 默认打开所有缩进
    set foldlevel=99
endif

" A buffer becomes hidden when it is abandoned
set hidden
set wildmode=longest,list,full

augroup generalSetting
    autocmd!
    " vimrc文件修改之后自动加载, windows
    " autocmd! bufwritepost _vimrc source %
    " vimrc文件修改之后自动加载, linux
    autocmd! bufwritepost .vimrc source %
    " 离开插入模式后自动关闭预览窗口
    "autocmd InsertLeave * if pumvisible() == 0|pclose|endif
    " command-line window
    "autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>

    " 打开自动定位到最后编辑的位置, 需要确认 .viminfo 当前用户可写
    "autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

    "autocmd TabLeave * let g:last_active_tab = tabpagenr()
augroup END

let g:python3_host_prog='python'
