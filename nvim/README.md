# Neovim 設定（NvChad ベース）

Neovim の設定は [NvChad](https://nvchad.com/) v2.5 の [starter](https://github.com/NvChad/starter) をベースにしている。
プラグインマネージャは [lazy.nvim](https://github.com/folke/lazy.nvim)。Vim 用の `.vimrc` とは独立している（`.vimrc` は Vim 専用・dein.vim のまま）。

## 構成ファイル

| ファイル | 説明 |
|---|---|
| `init.lua` | lazy.nvim のブートストラップと NvChad の読み込み（starter そのまま） |
| `lua/chadrc.lua` | NvChad の UI 設定（テーマなど） |
| `lua/options.lua` | NvChad 既定に対するオプションの上書き・追加 |
| `lua/mappings.lua` | NvChad 既定に対するキーマップの追加 |
| `lua/autocmds.lua` | ファイルタイプ別インデント、全角スペース強調、LSP/treesitter の autocmd |
| `lua/plugins/init.lua` | 追加プラグインと NvChad 既定プラグインの上書き設定 |
| `lua/configs/lspconfig.lua` | Language Server の設定 |
| `lua/configs/conform.lua` | フォーマッタの設定 |
| `lua/configs/lazy.lua` | lazy.nvim の設定（starter そのまま） |
| `after/indent/php.vim` | PHP のメソッドチェーン向けインデント関数 |
| `lazy-lock.json` | プラグインのバージョン固定。`:Lazy update` で更新される |

## プラグイン

### NvChad に含まれるもの（主なもの）

| プラグイン | 説明 |
|---|---|
| nvchad/ui, nvchad/base46 | ステータスライン・タブライン・テーマ |
| nvim-telescope/telescope.nvim | ファイル・全文・バッファの曖昧検索（fzf.vim の代替） |
| nvim-tree/nvim-tree.lua | ツリー型ファイラ |
| nvim-treesitter/nvim-treesitter (`main`) | 構文ハイライト。`ensure_installed` は `lua/plugins/init.lua` |
| hrsh7th/nvim-cmp + LuaSnip + friendly-snippets | 補完・スニペット |
| neovim/nvim-lspconfig + mason.nvim | LSP の定義と Language Server の管理 |
| lewis6991/gitsigns.nvim | Git の差分表示 |
| lukas-reineke/indent-blankline.nvim | インデントの可視化 |
| windwp/nvim-autopairs | 括弧・クォートの自動補完 |
| folke/which-key.nvim | キーマップのヒント表示 |
| stevearc/conform.nvim | フォーマッタ |

### 追加したもの

| プラグイン | 説明 |
|---|---|
| [tpope/vim-surround](https://github.com/tpope/vim-surround) + vim-repeat | 囲み文字の追加/変更/削除 |
| [folke/noice.nvim](https://github.com/folke/noice.nvim) + nui.nvim + nvim-notify | コマンドライン・メッセージ・通知 UI の置き換え |

## Language Server

| 言語 | Language Server | インストール |
|---|---|---|
| PHP | [intelephense](https://intelephense.com/) | `npm install -g intelephense` |

Language Server は mason.nvim（`:Mason`）からも入れられる。追加する場合は `lua/configs/lspconfig.lua` の `vim.lsp.enable` に名前を足す。

## セットアップ

```bash
# ~/.config/nvim -> dotfiles/nvim のシンボリックリンク（setup/put_symbolic_links.sh）
# intelephense（Node.js / npm が必要）
npm install -g intelephense
# ripgrep は telescope の全文検索、tree-sitter-cli は treesitter のパーサビルドに必要
brew install ripgrep tree-sitter-cli

# 初回起動で lazy.nvim がプラグインを、nvim-treesitter がパーサをインストールする
nvim
```

アイコンには Nerd Font が必要。Ghostty は Nerd Font のシンボルを内蔵しているので追加設定は不要。

## キーマップ

`<leader>` は **Space**（NvChad 既定。以前の `\` から変更）。`<leader>` を押して待つと which-key が候補を表示する。
全キーマップは `<leader>ch`（チートシート）で確認できる。

### 独自に追加したもの

| キー | 動作 |
|---|---|
| `;` / `:` | ノーマルモードで入れ替え（`;` でコマンドライン） |
| `<C-p>` | ファイル検索（Telescope find_files） |
| `<C-p>`（ビジュアル） | 直前にヤンクした内容を貼り付け |
| `t1`〜`t9` | n 番目のタブへ |
| `tc` / `tx` / `tn` / `tp` | タブを新規 / 閉じる / 次 / 前 |
| `<leader>rn` | LSP リネーム（LSP が付いたバッファのみ。それ以外は NvChad 既定の相対行番号トグル） |

### NvChad 既定でよく使うもの

| キー | 動作 |
|---|---|
| `<C-n>` | nvim-tree の開閉 |
| `<leader>e` | nvim-tree にフォーカス |
| `<leader>ff` / `<leader>fa` | ファイル検索 / 隠しファイル込みで検索 |
| `<leader>fw` | ripgrep で全文検索 |
| `<leader>fb` | バッファ一覧 |
| `<leader>fo` | 最近開いたファイル |
| `<Tab>` / `<S-Tab>` | 次 / 前のバッファ |
| `<leader>x` | バッファを閉じる |
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` | ウィンドウ移動 |
| `<leader>/` | コメントのトグル（`gcc` も可） |
| `<leader>fm` | フォーマット |
| `<leader>th` | テーマ選択 |
| `<leader>h` / `<leader>v` | 水平 / 垂直分割でターミナル |
| `<A-i>` | フローティングターミナルのトグル |
| `<Esc>` | 検索ハイライト消去 |

### LSP（Language Server が付いたバッファ内）

| キー | 動作 | 備考 |
|---|---|---|
| `gd` / `gD` | 定義 / 宣言へジャンプ | NvChad |
| `<leader>ra` | リネーム（NvChad の UI） | NvChad |
| `<leader>D` | 型定義へジャンプ | NvChad |
| `<leader>ds` | 診断一覧（loclist） | NvChad |
| `K` | ホバー | Neovim 組み込み |
| `grr` / `grn` / `gra` / `gri` | 参照 / リネーム / コードアクション / 実装 | Neovim 組み込み |
| `]d` / `[d` | 次 / 前の診断 | Neovim 組み込み |

### Git（gitsigns / `lua/plugins/init.lua` で追加）

| キー | 動作 |
|---|---|
| `]c` / `[c` | 次 / 前のハンク |
| `<leader>gp` | ハンクをプレビュー |
| `<leader>gs` | ハンクをステージ |
| `<leader>gr` | ハンクの変更を破棄 |
| `<leader>gb` | 現在行の blame |
| `<leader>gt` | git status（Telescope、NvChad 既定） |

### ファイラ（nvim-tree / NvChad 既定）

| キー | 動作 |
|---|---|
| `<C-n>` | nvim-tree の開閉 |
| `<leader>e` | nvim-tree にフォーカス |
| `g?` | nvim-tree 内でヘルプ（全キー一覧） |
| `a` / `d` / `r` | 作成 / 削除 / リネーム |
| `x` / `c` / `p` | 切り取り / コピー / 貼り付け |
| `<CR>` / `o` | 開く |
| `<C-v>` / `<C-x>` / `<C-t>` | 縦分割 / 横分割 / タブで開く |
| `H` | 隠しファイルの表示切替 |
| `R` | 再読み込み |

## メンテナンス

- `:Lazy` でプラグインの状態確認、`:Lazy update` で更新（`lazy-lock.json` が書き換わるのでコミットする）
- `:NvCheatsheet` / `<leader>ch` でキーマップ一覧
- NvChad 本体の更新は `:Lazy update` に含まれる（`NvChad/NvChad` の `v2.5` ブランチ）

## トラブルシューティング

### シンタックスハイライトが効かない

nvim-treesitter (main) はハイライト定義（クエリ）を `~/.local/share/nvim/site/queries/<言語>` にシンボリックリンクとして置く。
リンク先はプラグイン本体なので、プラグインの置き場所が変わる（プラグインマネージャの移行など）とリンクが切れ、パーサはあるのにハイライトだけ消える。
NvChad の `syntax` は無効化されているため、従来の正規表現ハイライトにもフォールバックしない。

```vim
" 確認: false ならクエリが見つかっていない
:lua print(vim.treesitter.query.get("php", "highlights") ~= nil)
" 修復: パーサとクエリを強制的に入れ直す
:lua require("nvim-treesitter").install(require("nvim-treesitter").get_installed("parsers"), { force = true })
```
