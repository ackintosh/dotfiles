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
