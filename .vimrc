""
"" Janus setup
""

" Define paths
let g:janus_path = escape(fnamemodify(resolve(expand("<sfile>:p")), ":h"), ' ')
let g:janus_vim_path = escape(fnamemodify(resolve(expand("<sfile>:p" . "vim")), ":h"), ' ')
let g:janus_custom_path = expand("~/.janus")

" Source janus's core
exe 'source ' . g:janus_vim_path . '/core/before/plugin/janus.vim'

" You should note that groups will be processed by Pathogen in reverse
" order they were added.
call janus#add_group("tools")
call janus#add_group("langs")
call janus#add_group("colors")

""
"" Customisations
""

if filereadable(expand("~/.vimrc.before"))
  source ~/.vimrc.before
endif


" Disable plugins prior to loading pathogen
exe 'source ' . g:janus_vim_path . '/core/plugins.vim'

""
"" Pathogen setup
""

" Load all groups, custom dir, and janus core
call janus#load_pathogen()

" .vimrc.after is loaded after the plugins have loaded

"" Configured by Ack
" see http://d.hatena.ne.jp/kanno_kanno/20121217/1355694191
set noswapfile
set clipboard=unnamed,autoselect
vnoremap <silent> <C-p> "0p<CR>

" see https://github.com/gmarik/vundle
"     -->Quick start
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
Bundle 'Shougo/neocomplcache'

" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'quickrun'
" let g:quickrun_config={'hook/time/enable': 1}

" non github repos
Bundle 'git://git.wincent.com/command-t.git'

Bundle 'opsplorer'
filetype plugin indent on     " required!

" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..


" --------------------------------
"  neocomplcache
"  see  http://www.karakaram.com/neocomplcache
" --------------------------------
"起動時に有効
let g:neocomplcache_enable_at_startup = 1
"ポップアップメニューで表示される候補の数。初期値は100
let g:neocomplcache_max_list = 20

" see https://github.com/tiwakawa/dotfiles/blob/master/.vimrc
" --------------------------------
"  General Settings
" --------------------------------
set nobackup " バックアップを取らない

set wrap     " 画面端で折り返す

" --------------------------------
"  PHP Settings
" --------------------------------
autocmd FileType php set tabstop=4
autocmd FileType php set shiftwidth=4
autocmd FileType php set softtabstop=4


" --------------------------------
"  PHP Settings
" --------------------------------
autocmd FileType ruby set tabstop=2
autocmd FileType ruby set shiftwidth=2
autocmd FileType ruby set softtabstop=2

