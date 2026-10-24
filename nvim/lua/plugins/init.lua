return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- 保存時フォーマットを使う場合はコメントを外す
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "vimdoc", "lua", "luadoc", "query", "printf",
        "php", "phpdoc", "json", "yaml", "toml", "markdown", "markdown_inline",
        "html", "css", "scss", "javascript", "typescript",
        "bash", "fish", "ruby", "sql", "go", "diff", "gitcommit",
        "rust", "ron",
      },
    },
  },

  -- gitsigns: NvChad 既定にはキーマップが無いので追加する（<leader>g はテレスコープの git 系と同じ接頭辞）
  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
      opts.on_attach = function(bufnr)
        local gs = require "gitsigns"
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
        end
        -- 次 / 前のハンクへ移動（diff モード中は Vim 標準の ]c [c を使う）
        map("n", "]c", function()
          if vim.wo.diff then vim.cmd.normal { "]c", bang = true } else gs.nav_hunk "next" end
        end, "git next hunk")
        map("n", "[c", function()
          if vim.wo.diff then vim.cmd.normal { "[c", bang = true } else gs.nav_hunk "prev" end
        end, "git prev hunk")
        map("n", "<leader>gp", gs.preview_hunk, "git preview hunk")
        map("n", "<leader>gs", gs.stage_hunk, "git stage hunk")
        map("n", "<leader>gr", gs.reset_hunk, "git reset hunk")
        map("n", "<leader>gb", function() gs.blame_line { full = true } end, "git blame line")
      end
      return opts
    end,
  },

  -- rustaceanvim: rust-analyzer の設定と Rust 向けコマンド（:RustLsp ...）
  -- setup() は不要で vim.g.rustaceanvim で設定する。nvim-lspconfig の rust_analyzer は有効化しない（二重起動になる）
  {
    "mrcjkb/rustaceanvim",
    version = "^9",
    lazy = false, -- プラグイン側で ft=rust に遅延するので lazy.nvim 側では遅延させない（作者の推奨）
    init = function()
      vim.g.rustaceanvim = {
        server = {
          -- NvChad 共通の capabilities（nvim-cmp 用）を引き継ぐ
          capabilities = require("nvchad.configs.lspconfig").capabilities,
          on_attach = function(_, bufnr)
            local function map(mode, lhs, rhs, desc)
              vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = "Rust " .. desc })
            end
            -- rust-analyzer のコードアクション（グループ化された UI）
            map({ "n", "v" }, "<leader>ca", function() vim.cmd.RustLsp "codeAction" end, "code action")
            -- カーソル位置から実行できるもの（main / テスト / ベンチ）を選んで実行
            map("n", "<leader>rr", function() vim.cmd.RustLsp "runnables" end, "runnables")
            map("n", "<leader>rt", function() vim.cmd.RustLsp "testables" end, "testables")
            -- マクロ展開を別ウィンドウに表示
            map("n", "<leader>re", function() vim.cmd.RustLsp "expandMacro" end, "expand macro")
            -- Cargo.toml / 親モジュールを開く
            map("n", "<leader>rc", function() vim.cmd.RustLsp "openCargo" end, "open Cargo.toml")
            map("n", "<leader>rp", function() vim.cmd.RustLsp "parentModule" end, "parent module")
            -- カーソル下の診断を rustc の詳細説明付きで表示
            map("n", "<leader>rd", function() vim.cmd.RustLsp "explainError" end, "explain error")
            -- K: アクション付きホバー（rustaceanvim 版）
            map("n", "K", function() vim.cmd.RustLsp { "hover", "actions" } end, "hover actions")
            -- Rust では inlay hint（型・パラメータ名）を既定で表示する。<leader>ih で切替
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end,
          default_settings = {
            ["rust-analyzer"] = {
              -- 保存時のチェックを clippy で行う
              check = { command = "clippy" },
              cargo = { allFeatures = true },
              procMacro = { enable = true },
            },
          },
        },
      }
    end,
  },

  -- crates.nvim: Cargo.toml で依存クレートのバージョン表示・更新・補完
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    tag = "stable",
    opts = {
      completion = { cmp = { enabled = true } },
      lsp = {
        enabled = true, -- Cargo.toml 内でホバー / コードアクション（バージョン更新など）を使えるようにする
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },

  -- nvim-cmp: Cargo.toml でクレートの補完ソースを追加
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      table.insert(opts.sources, { name = "crates" })
      return opts
    end,
  },

  -- gitlinker.nvim: カーソル行 / 選択範囲の GitHub などの permalink をクリップボードにコピー
  -- （既定キーは無く、ここで定義した <leader>gl だけ。ブラウザで開くなら :GitLink!）
  {
    "linrongbin16/gitlinker.nvim",
    cmd = "GitLink",
    keys = {
      { "<leader>gl", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "git copy permalink" },
    },
    opts = {},
  },

  -- aerial.nvim: ファイル内のクラス・メソッドなどの構造をサイドバーに表示
  {
    "stevearc/aerial.nvim",
    cmd = { "AerialToggle", "AerialOpen", "AerialNavToggle" },
    keys = {
      { "<leader>o", "<cmd>AerialToggle!<CR>", desc = "aerial toggle outline" },
      { "<leader>fs", "<cmd>Telescope aerial<CR>", desc = "telescope document symbols (aerial)" },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    -- 起動時に自動で開くため、ファイルを開いたタイミングで読み込む
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      -- LSP があれば LSP、無ければ treesitter からシンボルを取る
      backends = { "lsp", "treesitter", "markdown", "man" },
      -- サイドバーは 1 つだけ置き、カレントバッファに追従させる（ウィンドウごとに開かない）
      -- 起動時の自動オープンは lua/autocmds.lua で nvim-tree の後に行う
      attach_mode = "global",
      layout = {
        -- 画面の右端に置く（"window" だとカレントウィンドウの隣に開き、nvim-tree と並んでしまう）
        placement = "edge",
        default_direction = "right",
        min_width = 30,
      },
      -- カーソル位置に追従して現在のシンボルを強調
      highlight_on_hover = true,
      autojump = false,
      -- サイドバー内のキー: <CR> で定義へジャンプ、{ } で前後のシンボル、q で閉じる
      on_attach = function(bufnr)
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr, desc = "aerial prev symbol" })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr, desc = "aerial next symbol" })
      end,
    },
    config = function(_, opts)
      require("aerial").setup(opts)
      -- :Telescope aerial を使えるようにする
      pcall(function() require("telescope").load_extension "aerial" end)
    end,
  },

  -- herdr-nvim: herdr ワークスペース内でコードにコメントを付けてエージェントへ送る
  -- （herdr 側のプラグインは `herdr plugin install ChmaraX/herdr-nvim` で別途導入）
  -- キーマップは <leader>a 接頭辞: ac コメント / al 一覧 / as 貼り付け / aS 送信 / ai 行参照
  {
    "ChmaraX/herdr-nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- 囲み文字（括弧・クォート・タグ）の追加/変更/削除。vim-repeat で . 繰り返し対応
  {
    "tpope/vim-surround",
    event = "VeryLazy",
    dependencies = { "tpope/vim-repeat" },
  },

  -- コマンドライン・メッセージ・通知 UI の置き換え
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
      },
    },
  },
}
