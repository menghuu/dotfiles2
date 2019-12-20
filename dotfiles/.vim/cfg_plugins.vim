" vim:ft=vim:sts=2:sw=2:ts=2
" Author: m
" Mail: m@meng.hu
" Date: 2019-10-07
" Description: configure plugins

call plug#begin('~/.vim/vim-plugged')

Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

" move line down and up
Plug 'matze/vim-move'
" vim-move settings {{{
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
" }}}

Plug 'aperezdc/vim-template'

" general syntax support
Plug 'sheerun/vim-polyglot'

" simplified clipboard functionality for vim
" Plug 'svermeulen/vim-easyclip'

" will configure latter
"Plug 'skywind3000/asyncrun.vim'

"Plug 'vheon/vim-cursormode'

Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
" vim-airline settings {{{
let g:airline#extensions#obsession#enabled = 1
let g:airline#extensions#obsession#indicator_text = '$'
let g:airline#extensions#cursormode#enabled = 1
let g:airline_theme="tomorrow"
" }}}

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

Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'neoclide/coc-python', {'for': ['python']}
" coc.nvim settings {{{
" format
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" }}}

"if has('nvim')
  "Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
"else
  "Plug 'roxma/nvim-yarp'
  "Plug 'roxma/vim-hug-neovim-rpc'
  "Plug 'Shougo/deoplete.nvim'
"endif
"if (has('win32') || has('win64'))
  "Plug 'tbodt/deoplete-tabnine', { 'do': 'powershell.exe .\install.ps1'}
"else
  "Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
"endif
"let g:deoplete#enable_at_startup = 1

"Plug 'zchee/deoplete-jedi', {'for': ['python']}

"Plug 'davidhalter/jedi-vim', {'for': ['python'] }
"Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
" python-mode settings {{{
"let g:pymode = 1
"let g:pymode_options = 1
"let g:pymode_trim_whitespaces = 1
"let g:pymode_rope_completion = 1
"let g:pymode_rope_complete_on_dot = 1
"let g:pymode_rope = 1
"let g:pymode_python = 'python3'
" }}}

" vim 的deoplete补全
"Plug 'Shougo/neco-vim'

"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
" neosnippet settings {{{
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
" }}}

" For conceal markers.
" 此选项关系到是否隐藏掉某些占位符
" 0代表着完全显示出来
" 3代表着无论如何都会被隐藏掉
if has('conceal')
  set conceallevel=0 concealcursor=""
endif
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_conceal = 0

Plug 'scrooloose/nerdcommenter'
" Plug 'tpope/vim-commentary'
" Plug 'tomtom/tcomment_vim'

" better numbertoggle {{{
"Plug 'jeffkreeftmeijer/vim-numbertoggle'
"Plug 'myusuf3/numbers.vim'
"Plug 'kennykaye/vim-relativity'
"}}}

"Plug 'w0rp/ale'
" ale settings {{{
" disable ale completion, using other completion engine
let g:ale_completion_enabled = 0
"let ale_linters = {}
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

"nnoremap <buffer> <silent> gd :ALEGoToDefinition <CR>
"nnoremap <buffer> <silent> <C-w>gd :ALEGoToDefinitionInVSplit<CR>
" }}}

Plug 'joshdick/onedark.vim'
Plug 'junegunn/seoul256.vim'
Plug 'chriskempson/base16-vim'
Plug 'dracula/vim', { 'as': 'dracula' }
" for dark 233(darkest) ~ 239(lightest)
" for light 253(darkest) ~ 256(lightest)
let g:seoul256_background = 233

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

" easymotion, <leader><leader>f like function{{{
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'haya14busa/incsearch.vim'
Plug '~/.vim/customs/vim-easymotion-m'
"}}}
" vim-anzu: display search status
"Plug 'osyo-manga/vim-anzu' | Plug '~/.vim/customs/vim-anzu-m'

Plug 'Konfekt/FoldText' | Plug '~/.vim/customs/FoldText-m'
" fancy fold texts{{{
" setting foldtext {{{
let g:vimsyn_folding='af'
let g:tex_fold_enabled=1
let g:xml_syntax_folding = 1
let g:clojure_fold = 1
let ruby_fold = 1
let perl_fold = 1
let perl_fold_blocks = 1
"}}}
" zr: 打开一层折叠
nnoremap <silent> zr zr:<c-u>setlocal foldlevel?<CR>
" zm: 关闭一些折叠
nnoremap <silent> zm zm:<c-u>setlocal foldlevel?<CR>

nnoremap <silent> zR zR:<c-u>setlocal foldlevel?<CR>
nnoremap <silent> zM zM:<c-u>setlocal foldlevel?<CR>

" Change Option Folds
nnoremap zi  :<c-u>call <SID>ToggleFoldcolumn(1)<CR>
nnoremap coz :<c-u>call <SID>ToggleFoldcolumn(0)<CR>
nmap     cof coz

function! s:ToggleFoldcolumn(fold)
  if &foldcolumn
    let w:foldcolumn = &foldcolumn
    silent setlocal foldcolumn=0
    if a:fold | silent setlocal nofoldenable | endif
  else
      if exists('w:foldcolumn') && (w:foldcolumn!=0)
        silent let &l:foldcolumn=w:foldcolumn
      else
        silent setlocal foldcolumn=4
      endif
      if a:fold | silent setlocal foldenable | endif
  endif
  setlocal foldcolumn?
endfunction
""}}}

" fzf
Plug 'junegunn/fzf.vim'
Plug '~/.fzf', {'do': './install --all' }
" fzf setting {{{
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
"let g:fzf_commands_expect = 'alt-enter, ctrl-x'


" }}}
"Plug 'Shougo/deol.nvim'

" undotreee
Plug 'mbbill/undotree' | Plug '~/.vim/customs/undotree-m'

"Plug 'Glench/Vim-Jinja2-Syntax'

Plug 'tmux-plugins/vim-tmux'

"Plug 'takac/vim-hardtime'
"let g:hardtime_default_on = 1

" vim tmux navigator
Plug 'christoomey/vim-tmux-navigator'
" vim tmux navigator setting {{{
let g:tmux_navigator_no_mappings = 1
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
    tnoremap <silent> <A-h> <C-\><C-N>:TmuxNavigateLeft<cr>
    tnoremap <silent> <A-j> <C-\><C-N>:TmuxNavigateDown<cr>
    tnoremap <silent> <A-k> <C-\><C-N>:TmuxNavigateUp<cr>
    tnoremap <silent> <A-l> <C-\><C-N>:TmuxNavigateRight<cr>
    tnoremap <silent> <A-=> <C-\><C-N>:TmuxNavigatePrevious<cr>
else
    " 这下能在应该在的模式下使用alt键了
    " 包括insert模式
    for i in range(65,90) + range(97,122)
	let c = nr2char(i)
	exec "map \e".c." <M-".c.">"
	exec "map! \e".c." <M-".c.">"

	exec "imap \e".c." <M-".c.">"
	exec "imap \e".c." <M-".c.">"
    endfor
endif
noremap <silent> <A-h> <C-\><C-N>:TmuxNavigateLeft<cr>
noremap <silent> <A-j> <C-\><C-N>:TmuxNavigateDown<cr>
noremap <silent> <A-k> <C-\><C-N>:TmuxNavigateUp<cr>
noremap <silent> <A-l> <C-\><C-N>:TmuxNavigateRight<cr>
noremap <silent> <A-=> <C-\><C-N>:TmuxNavigatePrevious<cr>

" 先从insert模式进入normal模式再进行移动
" 否则移回来的时候忘记了，又按键导致出现不想要的字符
inoremap <silent> <A-h> <C-\><C-N>:TmuxNavigateLeft<cr>
inoremap <silent> <A-j> <C-\><C-N>:TmuxNavigateDown<cr>
inoremap <silent> <A-k> <C-\><C-N>:TmuxNavigateUp<cr>
inoremap <silent> <A-l> <C-\><C-N>:TmuxNavigateRight<cr>
inoremap <silent> <A-=> <C-\><C-N>:TmuxNavigatePrevious<cr>
"}}}

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
" vim-cutlass settings {{{
nnoremap x d
xnoremap x d
nnoremap xx dd
xnoremap X D
" 把之前映射的m键给找回来
nnoremap m m
xnoremap m m
nnoremap mm mm
xnoremap M M
" }}}

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
"Plug 'cjrh/vim-conda'
let g:conda_startup_msg_suppress = 1

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
"colo dracula
"colo onedark
