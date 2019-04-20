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
" インデントに色を付ける
call dein#add('nathanaelkane/vim-indent-guides')
" 補完
call dein#add('Shougo/neocomplete.vim')
" スニペット管理
call dein#add('Shougo/neosnippet.vim')
" Puppet定義ファイル(ppファイル)のハイライト
call dein#add('rodjek/vim-puppet')
" 構文チェック
call dein#add('scrooloose/syntastic')
" mustache ファイルのハイライトなど
call dein#add('mustache/vim-mustache-handlebars')
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
"
if !has('gui_running')
  set t_Co=256
endif
" http://qiita.com/yuyuchu3333/items/20a0acfe7e0d0e167ccc
let g:lightline = {
  \ 'component_function': {
  \   'filename': 'MyFilename'
  \ }
  \}

function! MyFilename()
  return (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? substitute(b:vimshell.current_dir,expand('~'),'~','') :
        \ '' != expand('%') ? expand('%') : '[No Name]')
endfunction

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

" -------------------------------------------------------------------------------
" vim-phpqa
" https://github.com/joonty/vim-phpqa
" -------------------------------------------------------------------------------
" 保存時に messdetector を実行しない(default = 1)
let g:phpqa_messdetector_autorun = 0
" 保存時に codesniffer を実行しない(default = 1)
let g:phpqa_codesniffer_autorun = 0
" 保存時に coverage を実行しない(default = 0)
let g:phpqa_codecoverage_autorun = 1
" PHP Mess Detector binary (default = "phpmd")
let g:phpqa_messdetector_cmd='php ~/.vim/commands/phpmd.phar'

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
colorscheme pablo
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
" 行を折り返しするときにインデントを考慮する
set breakindent

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
set clipboard=unnamed
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


set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,utf-8,sjis,cp932
