# Neovim 設定

## 構成ファイル

| ファイル | 説明 |
|---|---|
| `nvim/init.vim` | Neovim 専用設定（LSP・補完） |
| `.vimrc` | Vim/Neovim 共通設定（プラグイン管理・インデント・キーマップ等） |

`init.vim` は `.vimrc` を `source` した後に Neovim 固有の設定を上書き・追加する構成。

## プラグイン

プラグインマネージャは [dein.vim](https://github.com/Shougo/dein.vim)。

### 共通（Vim / Neovim）

| プラグイン | 説明 |
|---|---|
| [itchyny/lightline.vim](https://github.com/itchyny/lightline.vim) | ステータスライン |
| [mustache/vim-mustache-handlebars](https://github.com/mustache/vim-mustache-handlebars) | Mustache/Handlebars のハイライト |
| [junegunn/fzf](https://github.com/junegunn/fzf) + [junegunn/fzf.vim](https://github.com/junegunn/fzf.vim) | ファイル・grep・バッファの曖昧検索（`fzf` / `ripgrep` を使用） |
| [tpope/vim-surround](https://github.com/tpope/vim-surround) | 囲み文字（括弧・クォート・タグ）の追加/変更/削除 |
| [tpope/vim-repeat](https://github.com/tpope/vim-repeat) | surround の操作を `.` で繰り返す |

### Vim 専用

| プラグイン | 説明 |
|---|---|
| [nathanaelkane/vim-indent-guides](https://github.com/nathanaelkane/vim-indent-guides) | インデントの可視化 |
| [Shougo/neocomplete.vim](https://github.com/Shougo/neocomplete.vim) | 補完 |
| [dense-analysis/ale](https://github.com/dense-analysis/ale) | 非同期の構文チェック（保存時・オープン時に実行） |
| 同梱の `comment` パッケージ | `gc` によるコメントのトグル（Vim 9.1 以降） |

### Neovim 専用（LSP・補完・UI）

| プラグイン | 説明 |
|---|---|
| [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | カラースキーム |
| [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | 補完エンジン |
| [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) | LSP ソース（nvim-cmp 用） |
| [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer) | バッファ内単語ソース（nvim-cmp 用） |
| [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip) | スニペットエンジン（nvim-cmp に必要） |
| [saadparwaiz1/cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip) | LuaSnip ソース（nvim-cmp 用） |
| [rafamadriz/friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | LuaSnip 用のスニペット集 |
| [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs) | 括弧・クォートの自動補完 |
| [MunifTanjim/nui.nvim](https://github.com/MunifTanjim/nui.nvim) | noice.nvim 依存（UI コンポーネント） |
| [rcarriga/nvim-notify](https://github.com/rcarriga/nvim-notify) | 通知 UI |
| [folke/noice.nvim](https://github.com/folke/noice.nvim) | コマンドライン・メッセージ・通知 UI の置き換え（LSP の進捗表示も担当） |
| [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) (`main`) | treesitter による構文ハイライト。パーサは起動時に自動インストール |
| [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git の差分をサインカラムに表示、ハンク操作 |
| [stevearc/oil.nvim](https://github.com/stevearc/oil.nvim) | ディレクトリをバッファとして編集するファイラ（netrw を置き換え） |
| [lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | インデントの可視化（現在のスコープを強調） |

構文チェックは Neovim では組み込み LSP の診断を使う（Neovim 0.11 で既定オフになった `virtual_text` は `init.vim` で有効化している）。
コメントのトグル（`gc`）は Neovim 組み込み。

### dein.vim の注意点

dein は `package.loaders` の先頭に `on_lua` 遅延ロード用のフックを入れるが、libuv コールバックなどの fast event 中に `require` されると `E5560` で落ちる（gitsigns が該当）。
`on_lua` は使っていないので、`.vimrc` で fast event 中はフックを素通りさせている。

## Language Server

| 言語 | Language Server | インストール |
|---|---|---|
| PHP | [intelephense](https://intelephense.com/) | `npm install -g intelephense` |

## セットアップ

```bash
# intelephense のインストール（Node.js / npm が必要）
npm install -g intelephense

# fzf.vim と nvim-treesitter が使うコマンド（setup/install_homebrew_packages.sh にも記載）
brew install fzf ripgrep tree-sitter-cli

# Neovim を起動すると dein が自動でプラグインを、nvim-treesitter がパーサをインストールする
nvim
```

## キーマップ

`<leader>` は既定の `\`。

### 検索（fzf.vim / Vim・Neovim 共通）

| キー | 動作 |
|---|---|
| `<C-p>` | ファイル名で検索（`:Files`） |
| `<leader>g` | ripgrep で全文検索（`:Rg`） |
| `<leader>b` | 開いているバッファを検索（`:Buffers`） |
| `<leader>h` | 最近開いたファイルを検索（`:History`） |

### 補完（insert モード）

| キー | 動作 |
|---|---|
| `<C-Space>` | 補完を手動起動 |
| `<Tab>` | 次の候補を選択 / スニペットを展開・次のフィールドへ |
| `<S-Tab>` | 前の候補を選択 / 前のフィールドへ |
| `<CR>` | 候補を確定 |

### LSP（normal モード / Language Server が付いたバッファ内）

| キー | 動作 | 備考 |
|---|---|---|
| `gd` | 定義へジャンプ | `init.vim` で定義 |
| `<leader>rn` | リネーム | `init.vim` で定義 |
| `K` | ホバー（型情報・ドキュメント） | Neovim 組み込み |
| `grr` | 参照一覧 | Neovim 組み込み |
| `grn` | リネーム | Neovim 組み込み |
| `gra` | コードアクション | Neovim 組み込み |
| `gri` | 実装へジャンプ | Neovim 組み込み |
| `]d` / `[d` | 次 / 前の診断へ移動 | Neovim 組み込み |

### Git（gitsigns.nvim / Neovim）

| キー | 動作 |
|---|---|
| `]c` / `[c` | 次 / 前のハンクへ移動 |
| `<leader>hp` | ハンクの差分をプレビュー |
| `<leader>hs` | ハンクをステージ |
| `<leader>hr` | ハンクの変更を破棄 |
| `<leader>hb` | 現在行の blame を表示 |

### ファイラ（oil.nvim / Neovim）

| キー | 動作 |
|---|---|
| `-` | 親ディレクトリを開く（oil 内でも同じ） |
| `<CR>` | ファイル / ディレクトリを開く |
| 通常の編集 + `:w` | ファイル名変更・削除・作成を反映 |
