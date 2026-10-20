require "nvchad.mappings"

-- NvChad の主なキーマップ（<leader> は Space）:
--   <C-n> nvim-tree / <leader>ff ファイル検索 / <leader>fw 全文検索 / <leader>fb バッファ
--   <Tab> <S-Tab> バッファ切替 / <leader>x バッファを閉じる / <Esc> 検索ハイライト消去
--   <C-h/j/k/l> ウィンドウ移動 / <leader>/ コメントトグル / <leader>th テーマ選択

local map = vim.keymap.set

-- ノーマルモード時だけ ; と : を入れ替える
map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", ":", ";", { desc = "repeat f/t motion" })

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

-- oil.nvim: - で親ディレクトリを開く
map("n", "-", "<cmd>Oil<CR>", { desc = "oil open parent directory" })
