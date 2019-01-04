" File: .vimrc
" Author: mongoose
" Description: my vim config

function! s:load_my_config(config_file_name)
    let config_file_dir_m = expand('$HOME/.config/nvim/configs/')
    let full_path = config_file_dir_m . a:config_file_name
    if !empty(full_path)
	exe 'source ' . full_path
    else
	echom full_path . " not exists, cannot source"
    endif
endfunction

if !exists('g:loaded_plug')
  source $HOME/.vim/vim-plug/plug.vim
endif

call plug#begin('~/.config/vim-plugged')

" general syntax support
Plug 'sheerun/vim-polyglot'

" simplified clipboard functionality for vim
" Plug 'svermeulen/vim-easyclip'

" will configure latter
Plug 'skywind3000/asyncrun.vim'
call s:load_my_config('for_asyncrun.vim')

Plug 'vheon/vim-cursormode'

Plug 'vim-airline/vim-airline'
call s:load_my_config('for_airline.vim')
" Plug 'itchyny/lightline.vim'

Plug 'romainl/vim-qf'

Plug 'pbrisbin/vim-mkdir'

Plug 'jiangmiao/auto-pairs'

Plug 'will133/vim-dirdiff'

" Plug 'hecal3/vim-leader-guide'

Plug 'editorconfig/editorconfig-vim'

Plug 'ntpeters/vim-better-whitespace'

Plug 'Yggdroot/indentLine'
"Plug 'thaerkh/vim-indentguides'

Plug 'pbrisbin/vim-restore-cursor'

Plug 'terryma/vim-multiple-cursors'

" Target text *after* the designated characters
Plug 'junegunn/vim-after-object'

Plug 'Konfekt/FastFold'

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
Plug 'justinmk/vim-sneak'

" Plug 'drmikehenry/vim-fixkey'

" vim plugin that displays tags in a window, ordered by scope
Plug 'majutsushi/tagbar'

" Plug 'xolox/vim-easytags'

" swap window without break windows size
Plug 'wesQ3/vim-windowswap'
call s:load_my_config('for_vim_windowswap.vim')

" vim easy align
" add some like viga=<CR> function
Plug 'junegunn/vim-easy-align'
call s:load_my_config('for_vim_easy_align.vim')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
call s:load_my_config('for_nerdtree.vim')

" snippets {{{
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
"}}}

" completion {{{
if has('nvim')
    Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
exe "source " . expand("~/.config/nvim/configs/for_deoplete.vim")

" python complete for deoplete
"Plug 'zchee/deoplete-jedi'
" jedi-vim
" Plug 'davidhalter/jedi-vim', {
    " \'for': ['python'],
    " \'do': function('InstallJediDeps')
    " \}
"call s:load_my_config('for_jedi.vim')
"}}}

" commenter {{{
Plug 'scrooloose/nerdcommenter'
call s:load_my_config('for_nerdtree.vim')
" Plug 'tpope/vim-commentary'
" Plug 'tomtom/tcomment_vim'
"}}}

" better numbertoggle {{{
"Plug 'jeffkreeftmeijer/vim-numbertoggle'
"Plug 'myusuf3/numbers.vim'
Plug 'kennykaye/vim-relativity'
call s:load_my_config('for_vim_relativity.vim')
"}}}

" linter ale
Plug 'w0rp/ale'
call s:load_my_config('for_ale.vim')

" colorscheme {{{
Plug 'cocopon/iceberg.vim'
Plug 'junegunn/seoul256.vim'
Plug 'trevordmiller/nova-vim'
Plug 'chriskempson/base16-vim'
"}}}

" lengthmatters: highlight the flooding art of an overly long line
Plug 'whatyouhide/vim-lengthmatters'
call s:load_my_config('for_lengthmatters.vim')

" easymotion, <leader><leader>f like function
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'haya14busa/incsearch.vim'
call s:load_my_config('for_easymotion_incsearch.vim')

" vim-anzu: display search status
Plug 'osyo-manga/vim-anzu'

call s:load_my_config('for_anzu.vim')

" fancy fold texts
Plug 'Konfekt/FoldText'
call s:load_my_config('for_foldtext.vim')

" fzf
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
call s:load_my_config('for_fzf.vim')

" leader-f
" an asynchronous fuzzy finder which is used to quickly locate files, buffers, mrus, tags, etc. in large project
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'Yggdroot/LeaderF-marks'
call s:load_my_config('for_leaderf.vim')

" undotreee
Plug 'mbbill/undotree'
call s:load_my_config('for_undotree.vim')

Plug 'Glench/Vim-Jinja2-Syntax'

Plug 'tmux-plugins/vim-tmux'

" vim tmux navigator {{{
Plug 'christoomey/vim-tmux-navigator'
call s:load_my_config('for_tmux_nagivation.vim')
" }}}

" other tpope plugin {{{
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

" }}}

" directory viewer for vim
Plug 'justinmk/vim-dirvish'
call s:load_my_config('for_dirvish.vim')

" project configuration
Plug 'tpope/vim-projectionist'

" dirvish support for tpope's plug "projectionist"
" should install tpope's plug 'projectionist'
Plug 'fsharpasharp/vim-dirvinist'
call s:load_my_config('for_dirvinist.vim')


" many vim function helper
Plug 'LucHermitte/lh-vim-lib'
" add project-specify vimrc support
" currently it is actually supporting each file local vimrc not project
" so it runs every file buffer in the sub dir of the _vimrc_local.vim
" althernatives: embear/vim-localvimrc, tpope/projectionist (should be configured extra)
Plug 'LucHermitte/local_vimrc'

" Plug 'direnv/direnv.vim'


Plug 'vim-ruby/vim-ruby', {'for': ['ruby']}

Plug 'WolfgangMehner/bash-support', {'for': 'sh'}

" python {{{
" python-mode {{{
Plug 'python-mode/python-mode', { 'for' : 'python' , 'branch': 'develop'}
call s:load_my_config('for_pymode.vim')
" }}}


Plug 'vim-python/python-syntax', {'for': 'python'}

" conda support
" Plug 'cjrh/vim-conda'
call s:load_my_config('for_vim_conda.vim')

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
Plug 'pearofducks/ansible-vim'

" .tmux support like: K for `man tmux`; :make for source; g! and g!! for run as tmux commands
Plug 'tmux-plugins/vim-tmux'

" dockerfile syntax support and snippets for dockerfile
Plug 'ekalinin/Dockerfile.vim'

" move line down and up
Plug 'matze/vim-move'
call s:load_my_config('for_vim_move.vim')

call plug#end()

call s:load_my_config('default_config.vim')

call s:load_my_config('mappings.vim')

call s:load_my_config('nvim_vim.vim')

" call s:load_my_config('for_denite.vim')

call s:load_my_config('colorscheme.vim')

" vim:foldmethod=marker
