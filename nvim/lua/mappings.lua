require "nvchad.mappings"

-- NvChad の主なキーマップ（<leader> は Space）:
--   <C-n> nvim-tree / <leader>ff ファイル検索 / <leader>fw 全文検索 / <leader>fb バッファ
--   <Tab> <S-Tab> バッファ切替 / <leader>x バッファを閉じる / <Esc> 検索ハイライト消去
--   <C-h/j/k/l> ウィンドウ移動 / <leader>/ コメントトグル / <leader>th テーマ選択

local map = vim.keymap.set

-- ノーマルモード時だけ ; と : を入れ替える
map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", ":", ";", { desc = "repeat f/t motion" })

-- Ctrl+i でジャンプリストを進む（Ctrl+o の逆）。
-- NvChad は <Tab> をバッファ切替に使っており、Neovim は <C-I> のマッピングが無いと <Tab> に単純化して
-- しまうので、<C-I> を明示的に組み込み動作へ割り当てて単純化を防ぐ。
-- 端末が Ctrl+i と Tab を区別して送る必要がある（tmux は .tmux.conf の extended-keys で対応済み）。
map("n", "<C-I>", "<C-I>", { desc = "jump forward (jumplist)" })

-- 以前の fzf.vim <C-p> と同じ感覚でファイル検索
map("n", "<C-p>", "<cmd>Telescope find_files<CR>", { desc = "telescope find files" })

-- ビジュアルモードで、直前にヤンクした内容を貼り付ける（上書き貼り付けでレジスタが汚れない）
map("v", "<C-p>", '"0p', { desc = "paste from yank register" })

-- タブ操作: t1〜t9 でジャンプ、tc 新規、tx 閉じる、tn 次、tp 前
for n = 1, 9 do
  map("n", "t" .. n, "<cmd>tabnext " .. n .. "<CR>", { desc = "tab goto " .. n })
end
map("n", "tc", "<cmd>tablast | tabnew<CR>", { desc = "tab new" })
map("n", "tx", "<cmd>tabclose<CR>", { desc = "tab close" })
map("n", "tn", "<cmd>tabnext<CR>", { desc = "tab next" })
map("n", "tp", "<cmd>tabprevious<CR>", { desc = "tab prev" })
