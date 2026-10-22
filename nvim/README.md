# Neovim 設定（NvChad ベース）

Neovim の設定は [NvChad](https://nvchad.com/) v2.5 の [starter](https://github.com/NvChad/starter) をベースにしている。
プラグインマネージャは [lazy.nvim](https://github.com/folke/lazy.nvim)。Vim 用の `.vimrc` とは独立している（`.vimrc` は Vim 専用・dein.vim のまま）。

## よく使う操作

`<leader>` は **Space**。

| キー | 動作 |
|---|---|
| `Tab` / `Shift+Tab` | 次 / 前のバッファへ切り替え（画面上部のバー） |
| `<leader>x` | 現在のバッファを閉じる |
| `gd` | 定義へジャンプ |
| `Ctrl+o` | ジャンプ前の位置に戻る（別ファイルへ飛んだ後もファイルごと戻る） |
| `Ctrl+i` | 戻りすぎたときに進む |
| `<leader>o` | ファイル構造（クラス・メソッド）のサイドバーを開閉 |
| `Ctrl+p` | ファイル名で曖昧検索して開く |
| `<leader>fw` | 全文検索（ripgrep） |
| `Ctrl+n` | nvim-tree（ファイラ）の開閉 |
| `K` | カーソル下のホバー（型・ドキュメント） |
| `<leader>ch` | 全キーマップのチートシート |

起動時にファイルを指定して開くと、左に nvim-tree、右に aerial のサイドバーが自動で開く（`lua/autocmds.lua` と aerial の `open_automatic`）。
ファイル指定なし、または `nvim .` のときは nvim-tree にフォーカスした状態で始まる。

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
| [stevearc/aerial.nvim](https://github.com/stevearc/aerial.nvim) | クラス・メソッドなどファイル構造のサイドバー表示（LSP / treesitter） |
| [ChmaraX/herdr-nvim](https://github.com/ChmaraX/herdr-nvim) | herdr ワークスペース内で、コードへのコメントを AI エージェントへ送る。herdr 側プラグインも必要 |
| [mrcjkb/rustaceanvim](https://github.com/mrcjkb/rustaceanvim) | rust-analyzer の設定と Rust 向けコマンド（runnables、マクロ展開、エラー解説など） |
| [saecki/crates.nvim](https://github.com/saecki/crates.nvim) | Cargo.toml で依存クレートのバージョン表示・更新・補完 |
| [folke/noice.nvim](https://github.com/folke/noice.nvim) + nui.nvim + nvim-notify | コマンドライン・メッセージ・通知 UI の置き換え |

## Language Server

| 言語 | Language Server | インストール |
|---|---|---|
| PHP | [intelephense](https://intelephense.com/) | `npm install -g intelephense` |
| Rust | [rust-analyzer](https://rust-analyzer.github.io/) | `rustup component add rust-analyzer`（rustaceanvim が起動する。nvim-lspconfig 側では有効化しない） |

Language Server は mason.nvim（`:Mason`）からも入れられる。追加する場合は `lua/configs/lspconfig.lua` の `vim.lsp.enable` に名前を足す。

## セットアップ

クリーンインストール後は次の順に実行する。

```bash
setup/install_homebrew_packages.sh   # neovim, ripgrep, tree-sitter-cli, node など
setup/put_symbolic_links.sh          # ~/.config/nvim -> dotfiles/nvim
setup/install_neovim.sh              # intelephense、プラグイン、treesitter パーサ
setup/install_herdr.sh               # herdr と herdr-nvim（任意）
```

`setup/install_neovim.sh` を使わない場合も、`nvim` を起動すれば lazy.nvim がプラグインを、NvChad が treesitter パーサを自動で入れる。intelephense だけは `npm install -g intelephense` が別途必要。

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
| `<leader>o` | aerial のサイドバー（ファイル構造）を開閉 |
| `<leader>fs` | ファイル内のシンボルを Telescope で検索してジャンプ |
| `{` / `}` | 前 / 次のシンボルへ移動（aerial 読み込み後） |
| `<leader>ac` | herdr: 現在行 / 選択範囲にコメントを付ける |
| `<leader>al` | herdr: コメント一覧（Enter で編集、d で削除） |
| `<leader>as` / `<leader>aS` | herdr: 全コメントをエージェントの入力欄へ貼り付け / 送信 |
| `<leader>ai` | herdr: 現在行 / 選択範囲の `path:line` 参照をエージェントの入力欄へ |
| `<leader>ih` | inlay hint の表示切替（LSP が付いたバッファ） |
| `<C-o>` / `<C-i>` | ジャンプリストを戻る / 進む（`gd` で飛んだ後に戻るなど）。`<C-i>` は下記の注意を参照 |

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

### Rust（rustaceanvim / Rust バッファ内）

保存時に clippy でチェックし、inlay hint は既定で表示する。フォーマットは `<leader>fm`（rustfmt）。

| キー | 動作 |
|---|---|
| `<leader>ca` | コードアクション（rust-analyzer のグループ化 UI） |
| `<leader>rr` / `<leader>rt` | カーソル位置から実行できるもの / テストを選んで実行 |
| `<leader>re` | マクロ展開を表示 |
| `<leader>rd` | カーソル下のエラーを rustc の詳細説明付きで表示 |
| `<leader>rc` / `<leader>rp` | Cargo.toml / 親モジュールを開く |
| `K` | アクション付きホバー |
| `:RustLsp <Tab>` | その他のコマンド（joinLines, moveItem, ssr, view HIR/MIR など） |

Cargo.toml では crates.nvim が各依存の最新バージョンを仮想テキストで表示し、`K` でバージョン一覧、`<leader>ca` 相当の `:Crates upgrade_crate` などで更新できる。

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

## herdr 連携（herdr-nvim）

[herdr](https://herdr.dev) のワークスペース内でだけ動く。2 つの半身からなる。

1. **herdr 側プラグイン**（サイドバーとファイルピッカー）: `setup/install_herdr.sh` が `herdr plugin install ChmaraX/herdr-nvim` と `~/.config/herdr/config.toml` へのキー設定の追記を行う（herdr 0.7.5 以上）
2. **Neovim 側プラグイン**（コメント・参照の送信）: `lua/plugins/init.lua` で lazy.nvim から導入済み

herdr を更新した直後は旧サーバーが残っていてプラグイン操作が `protocol_mismatch` で失敗する。`herdr server stop` してから再実行する（開いているペインのプロセスは終了する）。

| キー | 動作 |
|---|---|
| `prefix+e` | Neovim サイドバーの開閉（タブごとに Neovim が常駐し、閉じても状態が残る） |
| `prefix+o` | エージェントが触ったファイルのピッカー。入力するとリポジトリ全体を曖昧検索 |

サイドバーの Neovim は通常の `~/.config/nvim`（この NvChad 設定）で起動する。
常駐している Neovim の確認と停止は `herdr-nvim daemons` / `herdr-nvim daemons stop <tab>`。
動作確認は `herdr-nvim doctor`。

## メンテナンス

- `:Lazy` でプラグインの状態確認、`:Lazy update` で更新（`lazy-lock.json` が書き換わるのでコミットする）
- `:NvCheatsheet` / `<leader>ch` でキーマップ一覧
- NvChad 本体の更新は `:Lazy update` に含まれる（`NvChad/NvChad` の `v2.5` ブランチ）

## トラブルシューティング

### `<C-i>`（ジャンプを進む）が効かず、バッファが切り替わる

端末は歴史的に Ctrl+i と Tab を同じコード (0x09) で送るため、NvChad の `<Tab>`（バッファ切替）が動いてしまう。
Ghostty と Neovim は拡張キープロトコル（modifyOtherKeys / CSI u）で両者を区別できるので、間に入る tmux でも有効にしてある（`.tmux.conf` の `extended-keys on`）。
さらに Neovim は `<C-I>` のマッピングが無いと `<Tab>` に単純化するので、`lua/mappings.lua` で `<C-I>` を明示的に割り当てている。

tmux の設定を変えた直後は、Ghostty から tmux に接続し直す（デタッチして再アタッチ、またはウィンドウを開き直す）必要がある。


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
