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
| [nathanaelkane/vim-indent-guides](https://github.com/nathanaelkane/vim-indent-guides) | インデントの可視化 |
| [Shougo/neocomplete.vim](https://github.com/Shougo/neocomplete.vim) | 補完（Vim のみ有効、Neovim は非対応） |
| [rodjek/vim-puppet](https://github.com/rodjek/vim-puppet) | Puppet `.pp` ファイルのハイライト |
| [scrooloose/syntastic](https://github.com/scrooloose/syntastic) | 構文チェック |
| [mustache/vim-mustache-handlebars](https://github.com/mustache/vim-mustache-handlebars) | Mustache/Handlebars のハイライト |

### Neovim 専用（LSP・補完）

| プラグイン | 説明 |
|---|---|
| [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | 補完エンジン |
| [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) | LSP ソース（nvim-cmp 用） |
| [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer) | バッファ内単語ソース（nvim-cmp 用） |
| [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip) | スニペットエンジン（nvim-cmp に必要） |
| [saadparwaiz1/cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip) | LuaSnip ソース（nvim-cmp 用） |

## Language Server

| 言語 | Language Server | インストール |
|---|---|---|
| PHP | [intelephense](https://intelephense.com/) | `npm install -g intelephense` |

## セットアップ

```bash
# intelephense のインストール（Node.js / npm が必要）
npm install -g intelephense

# Neovim を起動すると dein が自動でプラグインをインストールする
nvim
```

## キーマップ

### 補完（insert モード）

| キー | 動作 |
|---|---|
| `<C-Space>` | 補完を手動起動 |
| `<Tab>` | 次の候補を選択 |
| `<S-Tab>` | 前の候補を選択 |
| `<CR>` | 候補を確定 |

### LSP（normal モード / PHP ファイル内）

| キー | 動作 |
|---|---|
| `gd` | 定義へジャンプ |
| `K` | ホバー（型情報・ドキュメント） |
| `gr` | 参照一覧 |
| `<leader>rn` | リネーム |
