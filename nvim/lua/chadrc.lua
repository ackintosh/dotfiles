-- NvChad の UI 設定。構造は nvconfig.lua に合わせる必要がある
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  -- 以前使っていた tokyonight.nvim に合わせたテーマ。<leader>th で他のテーマを試せる
  theme = "tokyonight",
}

-- 起動時のダッシュボードは使わない
M.nvdash = { load_on_startup = false }

return M
