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
  on_attach = function(_, bufnr)
    local opts = { buffer = bufnr, silent = true }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K',  vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  end,
})
vim.lsp.enable('intelephense')
EOF
