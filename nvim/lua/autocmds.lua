require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- ファイルタイプごとのインデント幅（NvChad 既定は 2）
local indent_by_ft = {
  c = 4, css = 2, diff = 4, eruby = 2, html = 2, javascript = 2, json = 2, markdown = 2,
  php = 4, ruby = 2, scss = 2, sql = 4, vim = 2, xhtml = 4, xml = 4, yaml = 2, zsh = 4, lua = 2,
}
local indent_group = augroup("my_indent", { clear = true })
for ft, width in pairs(indent_by_ft) do
  autocmd("FileType", {
    group = indent_group,
    pattern = ft,
    callback = function()
      vim.bo.shiftwidth = width
      vim.bo.softtabstop = width
      vim.bo.tabstop = width
      vim.bo.expandtab = true
    end,
  })
end

-- 全角スペースをハイライト
local zenkaku_group = augroup("my_zenkaku_space", { clear = true })
local function set_zenkaku_hl()
  vim.api.nvim_set_hl(0, "ZenkakuSpace", { underline = true, ctermfg = "lightblue", bg = "darkgray" })
end
autocmd("ColorScheme", { group = zenkaku_group, callback = set_zenkaku_hl })
autocmd({ "VimEnter", "WinEnter", "BufRead" }, {
  group = zenkaku_group,
  callback = function()
    if not vim.w.zenkaku_match then
      vim.w.zenkaku_match = vim.fn.matchadd("ZenkakuSpace", "　")
    end
  end,
})
set_zenkaku_hl()

-- LSP: 以前の設定と同じ <leader>rn でリネーム（NvChad 既定の <leader>ra も使える）
autocmd("LspAttach", {
  group = augroup("my_lsp_attach", { clear = true }),
  callback = function(args)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = args.buf, desc = "LSP rename" })
  end,
})

-- treesitter ハイライト（nvim-treesitter main ブランチではユーザーが有効化する）
autocmd("FileType", {
  group = augroup("my_treesitter", { clear = true }),
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})
