source ~/.vimrc

colorscheme tokyonight

lua << EOF
-- noice.nvim: コマンドライン・メッセージ・通知 UI の置き換え
local ok_noice, noice = pcall(require, 'noice')
if ok_noice then
  noice.setup({
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
  })
end

-- nvim-autopairs
local ok_autopairs, autopairs = pcall(require, 'nvim-autopairs')
if ok_autopairs then
  autopairs.setup()
end

-- nvim-cmp 補完設定
local ok_cmp, cmp = pcall(require, 'cmp')
local ok_luasnip, luasnip = pcall(require, 'luasnip')

if ok_cmp and ok_luasnip then
  -- friendly-snippets（VSCode 形式）を遅延ロード
  pcall(function() require('luasnip.loaders.from_vscode').lazy_load() end)

  local ok_cmp_lsp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
  if ok_cmp_lsp then
    vim.lsp.config('*', {
      capabilities = cmp_lsp.default_capabilities(),
    })
  end

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<CR>']      = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
      ['<Tab>']     = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>']   = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    }, {
      { name = 'buffer' },
    }),
  })

  -- nvim-cmp と nvim-autopairs の連携: 補完確定時にペアが重複しないようにする
  local ok_cmp_autopairs, cmp_autopairs = pcall(require, 'nvim-autopairs.completion.cmp')
  if ok_cmp_autopairs then
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end
end

-- 診断の表示設定（Neovim 0.11 から virtual_text が既定で無効になったため明示する）
vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
})

-- LSP 共通キーマップ（どの Language Server でも同じキーが使えるよう LspAttach でまとめて設定）
-- 以下は Neovim 0.11+ の組み込みなのでここでは定義しない:
--   K: ホバー / grr: 参照一覧 / grn: リネーム / gra: コードアクション / gri: 実装へジャンプ
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my_lsp_attach', { clear = true }),
  callback = function(args)
    local opts = { buffer = args.buf, silent = true }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  end,
})

-- PHP LSP (intelephense) - vim.lsp.config は Neovim 0.11+ 組み込み
vim.lsp.config('intelephense', {
  cmd = { 'intelephense', '--stdio' },
  filetypes = { 'php' },
  root_markers = { 'composer.json', '.git' },
  settings = {
    intelephense = {
      files = {
        exclude = { '**/.git/**', '**/node_modules/**', '**/.claude/**' },
      },
    },
  },
})
vim.lsp.enable('intelephense')

-- nvim-treesitter (main ブランチ): パーサの自動インストールとハイライトの有効化
local ok_ts, ts = pcall(require, 'nvim-treesitter')
if ok_ts then
  local langs = {
    'php', 'phpdoc', 'lua', 'vim', 'vimdoc', 'query',
    'json', 'yaml', 'toml', 'markdown', 'markdown_inline',
    'html', 'css', 'scss', 'javascript', 'typescript',
    'bash', 'fish', 'ruby', 'sql', 'go', 'diff', 'gitcommit',
  }
  -- 未インストールのパーサだけを入れる（tree-sitter CLI と C コンパイラが必要）
  if vim.fn.executable('tree-sitter') == 1 then
    local installed = ts.get_installed and ts.get_installed('parsers') or {}
    local missing = vim.tbl_filter(function(l) return not vim.tbl_contains(installed, l) end, langs)
    if #missing > 0 then
      ts.install(missing)
    end
  end
  -- パーサがある filetype では treesitter ハイライトを使う（無ければ従来の syntax のまま）
  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('my_treesitter', { clear = true }),
    callback = function(args)
      pcall(vim.treesitter.start, args.buf)
    end,
  })
end

-- gitsigns.nvim: Git の差分表示とハンク操作
local ok_gs, gitsigns = pcall(require, 'gitsigns')
if ok_gs then
  gitsigns.setup({
    on_attach = function(bufnr)
      local opts = { buffer = bufnr, silent = true }
      -- 次 / 前のハンクへ移動（diff モード中は Vim 標準の ]c [c を使う）
      vim.keymap.set('n', ']c', function()
        if vim.wo.diff then vim.cmd.normal({ ']c', bang = true }) else gitsigns.nav_hunk('next') end
      end, opts)
      vim.keymap.set('n', '[c', function()
        if vim.wo.diff then vim.cmd.normal({ '[c', bang = true }) else gitsigns.nav_hunk('prev') end
      end, opts)
      vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk, opts)
      vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk, opts)
      vim.keymap.set('n', '<leader>hr', gitsigns.reset_hunk, opts)
      vim.keymap.set('n', '<leader>hb', function() gitsigns.blame_line({ full = true }) end, opts)
    end,
  })
end

-- oil.nvim: ディレクトリをバッファとして編集するファイラ
local ok_oil, oil = pcall(require, 'oil')
if ok_oil then
  oil.setup({
    view_options = { show_hidden = true },
  })
  -- - で親ディレクトリを開く
  vim.keymap.set('n', '-', '<cmd>Oil<CR>', { silent = true, desc = '親ディレクトリを開く' })
end

-- indent-blankline.nvim: インデントの可視化（現在のスコープを強調）
local ok_ibl, ibl = pcall(require, 'ibl')
if ok_ibl then
  ibl.setup({
    scope = { enabled = true },
  })
end
EOF
