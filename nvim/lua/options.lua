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
opt.fileencodings = {
  "ucs-bom", "iso-2022-jp-3", "iso-2022-jp", "eucjp-ms", "euc-jisx0213", "euc-jp", "utf-8", "sjis", "cp932",
}
