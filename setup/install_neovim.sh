#!/bin/bash
#
# Neovim（NvChad ベース設定）のセットアップ
#
# 前提:
# - setup/install_homebrew_packages.sh を実行済み（neovim, ripgrep, tree-sitter-cli, node が入る）
# - setup/put_symbolic_links.sh を実行済み（~/.config/nvim -> dotfiles/nvim）
#
# 何度実行しても同じ結果になるようにしてある。
set -euo pipefail

# ------------------------------------------------------------------------------
# 1. 前提コマンドの確認
# ------------------------------------------------------------------------------
for cmd in nvim git rg tree-sitter npm; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "missing: $cmd （setup/install_homebrew_packages.sh を先に実行する）" >&2
    exit 1
  fi
done

if [ ! -e "$HOME/.config/nvim/init.lua" ]; then
  echo "missing: ~/.config/nvim/init.lua （setup/put_symbolic_links.sh を先に実行する）" >&2
  exit 1
fi

# ------------------------------------------------------------------------------
# 2. Language Server
#    PHP: intelephense（nvim/lua/configs/lspconfig.lua で有効化している）
# ------------------------------------------------------------------------------
if command -v intelephense >/dev/null 2>&1; then
  echo "intelephense: installed"
else
  echo "intelephense: installing via npm"
  npm install -g intelephense
fi

# ------------------------------------------------------------------------------
# 3. プラグインと treesitter パーサ
#    初回起動で lazy.nvim がプラグインを、NvChad が ensure_installed のパーサを入れるが、
#    ここではヘッドレスで先に済ませておく。
# ------------------------------------------------------------------------------
echo "nvim: installing plugins (lazy.nvim sync)"
nvim --headless "+Lazy! sync" +qa

echo "nvim: installing treesitter parsers"
nvim --headless -c "lua local ts = require('nvim-treesitter'); local plugin = require('lazy.core.config').plugins['nvim-treesitter']; local want = require('lazy.core.plugin').values(plugin, 'opts', false).ensure_installed or {}; local have = ts.get_installed('parsers'); local missing = vim.tbl_filter(function(l) return not vim.tbl_contains(have, l) end, want); if #missing > 0 then ts.install(missing):wait(600000) end" +qa

echo
echo "done. nvim を起動して :checkhealth で問題がないか確認する。"
