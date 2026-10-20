-- NvChad の既定（capabilities、LspAttach でのキーマップ、診断の見た目）を読み込む
require("nvchad.configs.lspconfig").defaults()

-- PHP: intelephense（npm install -g intelephense）
-- サーバー定義は nvim-lspconfig の lsp/intelephense.lua を使い、設定だけ上書きする
vim.lsp.config("intelephense", {
  root_markers = { "composer.json", ".git" },
  settings = {
    intelephense = {
      files = {
        exclude = { "**/.git/**", "**/node_modules/**", "**/.claude/**" },
      },
    },
  },
})

vim.lsp.enable { "intelephense" }

-- 診断をインライン表示する（Neovim 0.11 から既定オフ）
vim.diagnostic.config { virtual_text = true, severity_sort = true }
