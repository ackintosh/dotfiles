" PHP メソッドチェーン（-> で始まる行）の上で o したとき、前の行のインデントをコピーする。
" それ以外は PHP 組み込みのスマートインデント (GetPhpIndent) を使う。
" after/indent に置くことで、組み込みの indent/php.vim の後に確実に読み込まれる。
function! PhpIndentWithChain()
  let prev = prevnonblank(v:lnum - 1)
  let prev_line = getline(prev)
  if prev_line =~# '^\s*->' && prev_line !~# ';\s*$'
    return indent(prev)
  endif
  return GetPhpIndent()
endfunction

setlocal indentexpr=PhpIndentWithChain()
