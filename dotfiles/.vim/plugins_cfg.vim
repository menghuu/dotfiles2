" vim:ft=vim:sts=2:sw=2:ts=2
" Author: m
" Mail: m@meng.hu
" Date: 2019-10-07
" Description: configure plugins

command! -nargs=1 LoadCustom 'so ~/.vim/custom/<args>'

call plug#begin('~/.vim/vim-plugged')

Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

" move line down and up
Plug 'matze/vim-move' "| Plug '~/.vim/customs/vim-move-m'
let g:move_map_keys = 0
let g:move_auto_indent = 0
map <A-]> <Plug>MoveLineDown
map <A-[> <Plug>MoveLineUp
vmap <A-]> <Plug>MoveBlocDown
vmap <A-[> <Plug>MoveBlocUp
map <A-Down> <Plug>MoveLineDown
map <A-Up> <Plug>MoveLineUp
vmap <A-Down> <Plug>MoveBlocDown
vmap <A-Up> <Plug>MoveBlocUp

Plug 'aperezdc/vim-template'

" general syntax support
Plug 'sheerun/vim-polyglot'

" simplified clipboard functionality for vim
" Plug 'svermeulen/vim-easyclip'

" will configure latter
"Plug 'skywind3000/asyncrun.vim'

"Plug 'vheon/vim-cursormode'


if !exists("g:gui_oni")
  Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes' "| Plug '~/.vim/customs/vim-airline-m'
  let g:airline#extensions#obsession#enabled = 1
  let g:airline#extensions#obsession#indicator_text = '$'
  let g:airline#extensions#cursormode#enabled = 1
  let g:airline_theme="tomorrow"
endif

" Plug 'itchyny/lightline.vim'

"Plug 'romainl/vim-qf'

"usage:
":e this/does/not/exist/file.txt
":w
"will auto mkdir this/does/not/exist
Plug 'pbrisbin/vim-mkdir'

" 如果使用oni的话，建议将其内置的括号补全功能去除掉,否则两个会冲突
" <M-e> 能将元素从括号中extract出来
" <M-]> 将(|)['hello', 'world'] -> (['hello', 'world'])
" <M-n> 跳到下一个闭合的括号处
" 上述说的都是在插入模式下, 还有其他的做法, 不过感觉有些奇怪
Plug 'jiangmiao/auto-pairs'

"Plug 'will133/vim-dirdiff'

Plug 'editorconfig/editorconfig-vim'

Plug 'ntpeters/vim-better-whitespace'

"Plug 'Yggdroot/indentLine'

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

Plug 'Konfekt/FastFold'

" workspace/session support{{{
Plug 'tpope/vim-obsession'
" Plug 'thaerkh/vim-workspace'
" let g:workspace_session_disable_on_args = 1
" Plug 'xolox/vim-session'
" should configure latter
"}}}
"if !exists("g:gui_oni")
    "Plug 'junegunn/rainbow_parentheses.vim'
Plug 'luochen1990/rainbow'
let g:rainbow_active=1
"Plug 'kien/rainbow_parentheses.vim'
"endif

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

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } | Plug '~/.vim/customs/nerdtree-m'
"Plug 'ryanoasis/vim-devicons'

"Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}

if has('nvim')
  Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
else
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
  Plug 'Shougo/deoplete.nvim'
endif
if (has('win32') || has('win64'))
  Plug 'tbodt/deoplete-tabnine', { 'do': 'powershell.exe .\install.ps1'}
else
  Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
endif
let g:deoplete#enable_at_startup = 1

" vim-lsp
"Plug 'prabirshrestha/async.vim'
"Plug 'prabirshrestha/vim-lsp'
"Plug 'ryanolsonx/vim-lsp-python'
let g:lsp_diagnostics_enabled = 0         " disable diagnostics support
"Plug 'lighttiger2505/deoplete-vim-lsp'
"autocmd Filetype python noremap <buffer><C-]> :<C-U>call lsp#ui#vim#definition()<CR>

" LanguageClient-neovim
"Plug 'autozimu/LanguageClient-neovim', {
    "\ 'branch': 'next',
    "\ 'do': 'bash install.sh',
    "\ }
"let g:LanguageClient_diagnosticsEnable = 0
"let g:LanguageClient_serverCommands = {}
"let g:LanguageClient_serverCommands['python'] = ["pyls"]
"function LC_maps()
  "if has_key(g:LanguageClient_serverCommands, &filetype)
    "nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<cr>
    ""nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>
    ""nnoremap <buffer> <silent> gd :ALEGoToDefinitionInVSplit <CR>
    ""nnoremap <buffer> <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
  "endif
"endfunction

"autocmd FileType * call LC_maps()

"nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

"autocmd Filetype python noremap <buffer><C-]> :<C-U>call lsp#ui#vim#definition()<CR>
"Plug '~/.vim/customs/deoplete-m'

"Plug 'zchee/deoplete-jedi', {'for': ['python']}

"Plug 'davidhalter/jedi-vim', {'for': ['python'] }

" vim 的deoplete补全
"Plug 'Shougo/neco-vim'

" snippets {{{
"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
" 此选项关系到是否隐藏掉某些占位符
" 0代表着完全显示出来
" 3代表着无论如何都会被隐藏掉
if has('conceal')
  set conceallevel=0 concealcursor=""
endif
"let g:vim_markdown_conceal = 0
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_conceal = 0

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
"}}}

" linter ale using lsp
" I really don't like the other lsp function in this
" I just want to using its linter and formmat function
Plug 'w0rp/ale'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
"let g:pymode_rope_completion = 0

" disable ale completion, using other completion engine
let g:ale_completion_enabled = 0
let ale_linters = {}
"let g:ale_linters['python'] = ['pyls']

"let g:ale_fixers = {
  "\ 'python': [
    "\ 'remove_trailing_lines',
    "\ 'trim_whitespace',
    "\ 'yapf'
  "\ ],
   "'vim': [
    "\ 'remove_trailing_lines',
    "\ 'trim_whitespace'
  "\]
"\}

nnoremap <buffer> <silent> gd :ALEGoToDefinition <CR>
nnoremap <buffer> <silent> <C-w>gd :ALEGoToDefinitionInVSplit<CR>

"colorscheme {{{
Plug 'joshdick/onedark.vim'
Plug 'junegunn/seoul256.vim'
Plug 'chriskempson/base16-vim'
" for dark 233(darkest) ~ 239(lightest)
" for light 253(darkest) ~ 256(lightest)
let g:seoul256_background = 233
"}}}

" lengthmatters: highlight the flooding art of an overly long line
Plug 'whatyouhide/vim-lengthmatters'

let g:lengthmatters_on_by_default=1
let g:lengthmatters_excluded = [
    \'fzf',
    \'unite',
    \'tagbar',
    \'startify',
    \'gundo',
    \'vimshell',
    \'w3m',
    \'nerdtree',
    \'help',
    \'qf',
    \'dirvish',
    \'denite',
    \'gitcommit',
    \'json',
    \'markdown'
    \]

" easymotion, <leader><leader>f like function
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'haya14busa/incsearch.vim'
Plug '~/.vim/customs/vim-easymotion-m'

" vim-anzu: display search status
"Plug 'osyo-manga/vim-anzu' | Plug '~/.vim/customs/vim-anzu-m'

" fancy fold texts
Plug 'Konfekt/FoldText' | Plug '~/.vim/customs/FoldText-m'

" fzf
" fzf 在windows下其实并不是特别好，但是它的功能最全面，也不需要怎么配置，适合我这样的懒人
" 在windows下不能使用HelpTag,使用denite来替代，说实话，不太会用
Plug 'junegunn/fzf.vim'
if (!has("win32") && !has("win64"))
    Plug '~/.fzf', {'do': './install --all' }
else
    Plug 'junegunn/fzf', { 'dir': '~/.fzf'}
    Plug 'Shougo/denite.nvim'
    command! -nargs=* HelpTags exec 'Denite help <args>'
endif
noremap <C-p> :<C-u>Commands<CR>
noremap <C-f> :<C-u>FZF<CR>

noremap <C-j>b :<C-u>Buffers<CR>
noremap <C-j><C-b> :<C-u>Buffers<CR>

noremap <C-j>m :<C-u>Maps<CR>
noremap <C-j><C-m> :<C-u>Maps<CR>

noremap <C-j>h :<C-u>History<CR>
noremap <C-j><C-h> :<C-u>History<CR>

noremap q: :<C-u>History:<CR>

noremap <C-j>/ :<C-u>History/<CR>
noremap <C-j><C-/> :<C-u>History/<CR>

noremap <C-j>l :<C-u>Lines<CR>
noremap <C-j><C-l> :<C-u>Lines<CR>

noremap <C-j>w :<C-u>Windows<CR>
noremap <C-j><C-w> :<C-u>Windows<CR>
let g:fzf_commands_expect = 'space'
"Plug '~/.vim/customs/fzf-m'

"Plug 'Shougo/deol.nvim'

" undotreee
Plug 'mbbill/undotree' | Plug '~/.vim/customs/undotree-m'

"Plug 'Glench/Vim-Jinja2-Syntax'

Plug 'tmux-plugins/vim-tmux'

"Plug 'takac/vim-hardtime'
"let g:hardtime_default_on = 1

" vim tmux navigator
Plug 'christoomey/vim-tmux-navigator' | Plug '~/.vim/customs/vim-tmux-navigator-m'
" add/del/chagne surround like "/[/]/</>
" cs]) replace [] to ()
Plug 'tpope/vim-surround'

" add some [oi like function
Plug 'tpope/vim-unimpaired'

" git support
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'

" add Delete Rename Chmod SudoWtrite SudoEdit etc. function
Plug 'tpope/vim-eunuch'

" easyily search for, substitute, and abbreviate multiple variants of a word
Plug 'tpope/vim-abolish'

" enable repeating supported plugin maps with "."
Plug 'tpope/vim-repeat'

"
Plug 'svermeulen/vim-cutlass'
nnoremap x d
xnoremap x d
nnoremap xx dd
xnoremap X D
" 把之前映射的m键给找回来
nnoremap m m
xnoremap m m
nnoremap mm mm
xnoremap M M

Plug 'mhinz/vim-startify'

"Plug 'svermeulen/vim-yoink'
"nmap <c-n> <plug>(YoinkPostPasteSwapBack)
"nmap <c-p> <plug>(YoinkPostPasteSwapForward)

"Plug 'svermeulen/vim-subversive'
" s for substitute
"nmap s <plug>(SubversiveSubstitute)
"nmap ss <plug>(SubversiveSubstituteLine)
"nmap S <plug>(SubversiveSubstituteToEndOfLine)
"nmap <leader>s <plug>(SubversiveSubstituteRange)
"xmap <leader>s <plug>(SubversiveSubstituteRange)
"nmap <leader>ss <plug>(SubversiveSubstituteWordRange)

Plug 'tpope/vim-dotenv'

" directory viewer for vim
"Plug 'justinmk/vim-dirvish' | Plug '~/.vim/customs/vim-dirvish-m'

" many vim function helper
"Plug 'LucHermitte/lh-vim-lib'
" add project-specify vimrc support
" currently it is actually supporting each file local vimrc not project
" so it runs every file buffer in the sub dir of the _vimrc_local.vim
" althernatives: embear/vim-localvimrc, tpope/projectionist (should be configured extra)
"Plug 'LucHermitte/local_vimrc'

Plug 'WolfgangMehner/bash-support', {'for': 'sh'}

"Plug 'vim-python/python-syntax', {'for': 'python'}

" conda support
"Plug 'cjrh/vim-conda'| Plug '~/.vim/customs/vim-conda-m'

Plug 'tmhedberg/SimpylFold', {'for': 'python'}

" vim-textobj {{{
Plug 'kana/vim-textobj-user'
" dii delete inter `i`ndent
Plug 'kana/vim-textobj-indent'
" diy delete inter syntax-hightlighted item
" 还是不错的，将所选择的内容交给hightlight插件来做，主要是，看着直观
Plug 'kana/vim-textobj-syntax'
" 通过 dif 删除function，但是只支持下面这几种语言
Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] }
" 通过 di, 注意有个逗号，删除参数
Plug 'sgur/vim-textobj-parameter'
" tab键上面那个
Plug 'fvictorio/vim-textobj-backticks'
" cic 修改commends
Plug 'glts/vim-textobj-comment'
" daf delete function in python
" dac delete class in python
" [pf / ]pf move to next/previous python function
" [pc 类似上面，但是用在class上
Plug 'bps/vim-textobj-python', { 'for': ['python'] }
" }}}

" .tmux support like: K for `man tmux`; :make for source; g! and g!! for run as tmux commands
Plug 'tmux-plugins/vim-tmux'

Plug 'cespare/vim-toml'

call plug#end()

colo seoul256
"colo onedark
