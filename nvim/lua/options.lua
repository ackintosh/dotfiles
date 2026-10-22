require "nvchad.options"

-- 以下は NvChad の既定に対する上書き・追加。
-- NvChad が既に設定しているもの: number, cursorline, ignorecase, smartcase,
-- clipboard=unnamedplus, expandtab, shiftwidth=2, undofile, splitright/splitbelow など

local o = vim.o
local opt = vim.opt

-- カーソル行を行番号だけでなく行全体で強調する（NvChad 既定は number のみ）
o.cursorlineopt = "both"
-- 画面端で折り返し、折り返し時にインデントを考慮する
o.wrap = true
o.breakindent = true
-- バックアップ・スワップファイルを作らない
o.backup = false
o.swapfile = false
-- 日本語ファイルの文字コード自動判定
-- utf-8 を JIS 系より先に置く。JIS 系を先にすると ASCII だけのファイルが iso-2022-jp と判定され、
-- そこに日本語を書いて保存すると JIS で保存されてしまう（新規に書くコードは UTF-8 にしたい）。
-- 代わりに 7bit の ISO-2022-JP ファイルは utf-8 として読まれるが、今はほぼ存在しないので許容する。
opt.fileencodings = {
  "ucs-bom", "utf-8", "iso-2022-jp-3", "iso-2022-jp", "eucjp-ms", "euc-jisx0213", "euc-jp", "cp932", "sjis",
}
