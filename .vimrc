" ===============================================================================
" プラグイン管理
" dein.vim
" https://github.com/Shougo/dein.vim
" ===============================================================================
" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif
" 設定開始
call dein#begin(s:dein_dir)
" プラグイン管理
call dein#add('Shougo/dein.vim')
" ステータスラインの表示をわかりやすく
call dein#add('itchyny/lightline.vim')
" unite.vim で ptを使用した検索のため
call dein#add('Shougo/vimproc', {
      \ 'build': {
      \     'windows': 'tools\\update-dll-mingw',
      \     'cygwin': 'make -f make_cygwin.mak',
      \     'mac': 'make -f make_mac.mak',
      \     'linux': 'make',
      \     'unix': 'gmake'}})
" ファイル、バッファ、レジスタ操作
call dein#add('Shougo/unite.vim', {
      \ 'depends': ['vimproc'],
      \ 'on_cmd': ['Unite'],
      \ 'lazy': 1})
" unite.vim で最近使ったファイルを表示できるようにする
call dein#add('Shougo/neomru.vim')
" カラースキーマ
call dein#add('nanotech/jellybeans.vim')
" インデントに色を付ける
call dein#add('nathanaelkane/vim-indent-guides')
" 補完
call dein#add('Shougo/neocomplete.vim')
" アウトライン表示
call dein#add('Shougo/unite-outline')
" スニペット管理
call dein#add('Shougo/neosnippet.vim')
" vim の Golang サポート
call dein#add('fatih/vim-go')
" Golang アウトライン表示
" :Tagbar アウトライン表示
" カーソルを合わせて gd で定義元にジャンプ
call dein#add('majutsushi/tagbar')
" Puppet定義ファイル(ppファイル)のハイライト
call dein#add('rodjek/vim-puppet')
" ファイラ
call dein#add('Shougo/vimfiler.vim', {
      \ 'depends': ['unite.vim']
      \})
" gtags
call dein#add('vim-scripts/gtags.vim')
" 構文チェック
call dein#add('scrooloose/syntastic')
" 設定終了
call dein#end()
" 未インストールがあったらインストール
if dein#check_install()
  call dein#install()
endif

" ===============================================================================
" *** プラグイン設定 ***
" ===============================================================================
" -------------------------------------------------------------------------------
"  neocomplete.vim
"  https://github.com/Shougo/neocomplete.vim
" -------------------------------------------------------------------------------
source ~/.vim/.vimrc.neocomplete

" -------------------------------------------------------------------------------
"  lightline.vim
"  https://github.com/itchyny/lightline.vim
" -------------------------------------------------------------------------------
if !has('gui_running')
  set t_Co=256
endif

" -------------------------------------------------------------------------------
" vim-indent-guides
" https://github.com/nathanaelkane/vim-indent-guides
" http://www.absolute-keitarou.net/blog/?p=1127
" -------------------------------------------------------------------------------
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=234
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=242
let g:indent_guides_enable_on_vim_startup = 1
" 幅の設定
" let g:indent_guides_guide_size = 1

" -------------------------------------------------------------------------------
" unite.vim
" https://github.com/Shougo/unite.vim
" http://blog.remora.cx/2010/12/vim-ref-with-unite.html
" -------------------------------------------------------------------------------
" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
noremap <C-P> :Unite buffer<CR>
" ファイル一覧
noremap <C-N> :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
noremap <C-H> :Unite file_mru<CR>
" sourcesを「今開いているファイルのディレクトリ」とする
noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

" grep検索
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
" カーソル位置の単語をgrep検索
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
" grep検索結果の再呼出
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>
" ファイル非同期検索
nnoremap <silent> ,f  :<C-u>Unite file_rec/async:!<CR>
" カレントディレクトリを表示
nnoremap <silent> ,c :<C-u>UniteWithBufferDir -buffer-name=files file<CR>

" unite grep に pt(The Platinum Searcher) を使う
if executable('pt')
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
endif

" -------------------------------------------------------------------------------
" unite-outline
" https://github.com/Shougo/unite-outline
" -------------------------------------------------------------------------------
" http://keyamb.hatenablog.com/entry/2013/06/15/225501
let g:unite_split_rule = 'botright'
noremap ,o <ESC>:Unite -vertical -winwidth=40 outline<Return>

" -------------------------------------------------------------------------------
" gtags.vim
" https://github.com/vim-scripts/gtags.vim
" -------------------------------------------------------------------------------
" カーソル以下の定義元を探す
nnoremap <C-j> :Gtags <C-r><C-w><CR><CR>
" カーソル以下の使用箇所を探す
nnoremap <C-k> :Gtags -r <C-r><C-w><CR><CR>

" -------------------------------------------------------------------------------
" vimfiler.vim
" https://github.com/Shougo/vimfiler.vim
" -------------------------------------------------------------------------------
" vimデフォルトのエクスプローラをvimfilerで置き換える
let g:vimfiler_as_default_explorer = 1
nnoremap <silent> ,w :VimFiler -buffer-name=explorer -split -toggle -no-quit<Cr>
nnoremap <silent> ,e :VimFiler -buffer-name=explorer -split -horizontal -toggle -no-quit<Cr>

" -------------------------------------------------------------------------------
" neosnippet.vim
" https://github.com/Shougo/neosnippet.vim
" -------------------------------------------------------------------------------
" スニペット保存ディレクトリ
let g:neosnippet#snippets_directory='~/.vim/snippets'
" <C-k> でスニペット選択. プレースホルダ移動.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" -------------------------------------------------------------------------------
" fatih/vim-go
" https://github.com/fatih/vim-go
" -------------------------------------------------------------------------------
" goimports
" * インストール
"   go get code.google.com/p/go.tools/cmd/goimports
let g:go_fmt_command = 'goimports'
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" -------------------------------------------------------------------------------
" gotags
" * インストール
"   go get -u github.com/jstemmer/gotags
" http://www.metal3d.org/ticket/2013/07/07/vim-for-golang
" -------------------------------------------------------------------------------
let g:tagbar_type_go = {
      \ 'ctagstype' : 'go',
      \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
      \ 'e:embedded',
      \ 'm:methods',
      \ 'r:constructor',
      \ 'f:functions'
      \ ],
      \ 'sro' : '.',
      \ 'kind2scope' : {
      \ 't' : 'ctype',
      \ 'n' : 'ntype'
      \ },
      \ 'scope2kind' : {
      \ 'ctype' : 't',
      \ 'ntype' : 'n'
      \ },
      \ 'ctagsbin' : 'gotags',
      \ 'ctagsargs' : '-sort -silent'
      \ }

" -------------------------------------------------------------------------------
" syntastic
" https://github.com/scrooloose/syntastic
" -------------------------------------------------------------------------------
" PHP
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 1
let g:syntastic_echo_current_error = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_enable_highlighting = 1
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*


" ===============================================================================
" *** インデント設定 ***
" ===============================================================================
" ファイルタイプの検索を有効にする
filetype plugin on
" そのファイルタイプにあわせたインデントを利用する
filetype indent on
" インデント設定
autocmd FileType c          setlocal sw=4 sts=4 ts=4 et
autocmd FileType css        setlocal sw=2 sts=2 ts=2 et
autocmd FileType diff       setlocal sw=4 sts=4 ts=4 et
autocmd FileType eruby      setlocal sw=2 sts=2 ts=2 et
autocmd FileType html       setlocal sw=2 sts=2 ts=2 et
autocmd FileType javascript setlocal sw=2 sts=2 ts=2 et
autocmd FileType json       setlocal sw=2 sts=2 ts=2 et
autocmd FileType md         setlocal sw=2 sts=2 ts=2 et
autocmd FileType php        setlocal sw=4 sts=4 ts=4 et
autocmd FileType ruby       setlocal sw=2 sts=2 ts=2 et
autocmd FileType scss       setlocal sw=2 sts=2 ts=2 et
autocmd FileType sql        setlocal sw=4 sts=4 ts=4 et
autocmd FileType vim        setlocal sw=2 sts=2 ts=2 et
autocmd FileType xhtml      setlocal sw=4 sts=4 ts=4 et
autocmd FileType xml        setlocal sw=4 sts=4 ts=4 et
autocmd FileType yaml       setlocal sw=2 sts=2 ts=2 et
autocmd FileType zsh        setlocal sw=4 sts=4 ts=4 et


" ===============================================================================
" *** その他 設定 ***
" ===============================================================================
" 行番号を表示
set number
" 行を強調表示
set cursorline
" シンタックスハイライトを有効にする
syntax on
" backspace
set backspace=indent,eol,start
" カラースキーマを設定
colorscheme jellybeans
" バックアップを取らない
set nobackup
" 画面端で折り返す
set wrap
" インクリメンタル検索
set incsearch
" 検索時に大文字小文字を区別しない
set ignorecase
" 検索パターンに大文字が含まれる場合は区別する
set smartcase

" -------------------------------------------------------------------------------
" see http://msrx9.bitbucket.org/blog/html/2013/06/29/vim_nnoremap.html
" ノーマルモード時だけ ; と : を入れ替える
" -------------------------------------------------------------------------------
nnoremap ; :
nnoremap : ;

" -------------------------------------------------------------------------------
" 他のアプリでコピーした文字をVimで貼付ける。またはその逆も。
" http://d.hatena.ne.jp/kanno_kanno/20121217/1355694191
" -------------------------------------------------------------------------------
set noswapfile
set clipboard=unnamed,autoselect
vnoremap <silent> <C-p> "0p<CR>

" -------------------------------------------------------------------------------
" 検索結果のハイライトをESC連打で消す
" http://blogged.e2esound.com/2010/08/18/vimrc%E3%81%AB%E5%BF%85%E3%81%9A%E6%9B%B8%E3%81%8D%E3%81%9F%E3%81%84%E5%80%8B%E4%BA%BA%E7%9A%84%E8%A8%AD%E5%AE%9A/
" -------------------------------------------------------------------------------
" 検索結果をハイライト
set hlsearch
" ESC連打設定
noremap <Esc><Esc> :nohlsearch<CR><Esc>

" -------------------------------------------------------------------------------
"  ステータスラインに文字コードやBOM、16進表示等表示
" -------------------------------------------------------------------------------
set laststatus=2 " ステータスラインを表示
set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).(&bomb?':BOM':'').']['.&ff.']'}%=\ (%v,%l)/%L%8P\

" -------------------------------------------------------------------------------
" 全角スペースをハイライト
" http://inari.hatenablog.com/entry/2014/05/05/231307
" -------------------------------------------------------------------------------
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction
if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif

" -------------------------------------------------------------------------------
"  タブ機能
"  http://qiita.com/wadako111/items/755e753677dd72d8036d
" -------------------------------------------------------------------------------
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ
