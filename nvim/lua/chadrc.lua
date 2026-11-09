-- NvChad の UI 設定。構造は nvconfig.lua に合わせる必要がある
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  -- 以前使っていた tokyonight.nvim に合わせたテーマ。<leader>th で他のテーマを試せる
  theme = "tokyonight",

  -- vim-illuminate（カーソル下の単語の出現箇所）のハイライト。プラグイン既定は下線だけで目立たないので背景色を付ける。
  -- Read は参照、Write は代入箇所（LSP が区別できる場合のみ。treesitter / 正規表現では Text になる）
  -- 変更後は :lua require("base46").load_all_highlights() でキャッシュを再生成する（nvim 再起動だけでは反映されない）
  hl_add = {
    IlluminatedWordText = { bg = "#3b4f8a" },
    IlluminatedWordRead = { bg = "#3b4f8a" },
    IlluminatedWordWrite = { bg = "#7a3f6b", bold = true },
  },
}

-- 起動時のダッシュボードは使わない
M.nvdash = { load_on_startup = false }

-- ステータスラインのファイル名を、プロジェクトルート（git ルート。無ければカレントディレクトリ）からの相対パスにする
-- NvChad 既定の file モジュール（nvchad/stl/default.lua）はファイル名だけなので上書きする
M.ui = {
  statusline = {
    modules = {
      file = function()
        local utils = require "nvchad.stl.utils"
        local x = utils.file() -- { icon, ファイル名 }
        local name = x[2]

        local path = vim.api.nvim_buf_get_name(utils.stbufnr())
        if path ~= "" and vim.bo[utils.stbufnr()].buftype == "" then
          local root = vim.fs.root(path, ".git") or vim.fn.getcwd()
          name = vim.fs.relpath(root, path) or vim.fn.fnamemodify(path, ":~")
        end

        local sep_r = utils.separators[require("nvconfig").ui.statusline.separator_style].right
        return "%#St_file# " .. x[1] .. " " .. name .. " %#St_file_sep#" .. sep_r
      end,
    },
  },
}

return M
