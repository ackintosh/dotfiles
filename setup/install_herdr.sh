#!/bin/bash
#
# herdr と herdr-nvim のセットアップ
#
# - herdr: AI コーディングエージェント向けのターミナルワークスペース https://herdr.dev
# - herdr-nvim: herdr 内で Neovim をサイドバーとして使い、コードへのコメントをエージェントに送る
#   https://github.com/ChmaraX/herdr-nvim
#
# 何度実行しても同じ結果になるようにしてある（導入済みの手順はスキップする）。
# Neovim 側のプラグインは dotfiles/nvim の lazy.nvim 設定に含まれているので、ここでは扱わない。
set -euo pipefail

HERDR_CONFIG_DIR="$HOME/.config/herdr"
HERDR_CONFIG="$HERDR_CONFIG_DIR/config.toml"
HERDR_NVIM_PLUGIN_ID="chmarax.herdr-nvim"
HERDR_NVIM_REPO="ChmaraX/herdr-nvim"

# ------------------------------------------------------------------------------
# 1. herdr 本体
# ------------------------------------------------------------------------------
if command -v herdr >/dev/null 2>&1; then
  echo "herdr: installed ($(herdr --version))"
else
  echo "herdr: installing via Homebrew"
  brew install herdr
fi

# ------------------------------------------------------------------------------
# 2. herdr-nvim のキー設定
#    herdr は既定で何も割り当てないので config.toml に追記する。
#    prefix+e: Neovim サイドバーの開閉 / prefix+o: エージェントが触ったファイルのピッカー
# ------------------------------------------------------------------------------
mkdir -p "$HERDR_CONFIG_DIR"
touch "$HERDR_CONFIG"
if grep -q "${HERDR_NVIM_PLUGIN_ID}.toggle" "$HERDR_CONFIG"; then
  echo "herdr config: herdr-nvim key bindings already present"
else
  echo "herdr config: adding herdr-nvim key bindings to $HERDR_CONFIG"
  cat >> "$HERDR_CONFIG" <<TOML

# herdr-nvim (https://github.com/ChmaraX/herdr-nvim)
[[keys.command]]
key = "prefix+e"
type = "plugin_action"
command = "${HERDR_NVIM_PLUGIN_ID}.toggle"
description = "nvim sidebar"

[[keys.command]]
key = "prefix+o"
type = "plugin_action"
command = "${HERDR_NVIM_PLUGIN_ID}.pick-file"
description = "open file from agent output"
TOML
fi

# ------------------------------------------------------------------------------
# 3. herdr-nvim プラグイン（herdr 側）
#    サーバーが旧バージョンのまま動いていると protocol_mismatch で失敗するので、
#    その場合は `herdr server stop` してから再実行する。
# ------------------------------------------------------------------------------
if herdr plugin list 2>/dev/null | grep -q "$HERDR_NVIM_PLUGIN_ID"; then
  echo "herdr-nvim: plugin already installed"
else
  echo "herdr-nvim: installing plugin from $HERDR_NVIM_REPO"
  herdr plugin install "$HERDR_NVIM_REPO" --yes
fi

# 設定を反映（サーバーが動いていなければ次回起動時に読まれるので無視してよい）
herdr server reload-config >/dev/null 2>&1 || true

# ------------------------------------------------------------------------------
# 4. 動作確認
# ------------------------------------------------------------------------------
HERDR_NVIM_BIN=$(find "$HERDR_CONFIG_DIR/plugins" -name herdr-nvim -type f -perm -u+x 2>/dev/null | head -1 || true)
if [ -n "$HERDR_NVIM_BIN" ]; then
  echo
  echo "動作確認は herdr を起動した状態で次を実行する:"
  echo "  $HERDR_NVIM_BIN doctor"
fi
echo
echo "herdr のタブ内で prefix+e を押すと Neovim サイドバーが開く。"
