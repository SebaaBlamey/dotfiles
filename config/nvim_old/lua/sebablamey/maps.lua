vim.g.mapleader = " "

local function map(mode, lhs, rhs)
	vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true, silent = true })
end

-- nvim-tree
-- abrir archivo en vertical con "S"
map("n", "<leader>e", ":Neotree toggle position=right<CR>")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")

-- bufferline
map("n", "<M-l>", ":BufferLineCycleNext<CR>")
map("n", "<M-h>", ":BufferLineCyclePrev<CR>")

-- terminal
map("n", "<leader>tv", ":vsplit | :term<CR>") -- abrir terminal a la derecha
map("n", "<leader>ts", ":split | :term<CR>") -- abrir terminal abajo
map("n", "<leader>tf", ":Lspsaga term_toggle<CR>") -- abrir terminal flotante

-- cerrar la pestana
map("n", "<C-w>", ":bdelete<CR>")

-- Telescope
map("n", "<leader>ff", ":Telescope find_files<CR>")
map("n", "<leader>fg", ":Telescope live_grep<CR>")
map("n", "<leader>fb", ":Telescope buffers<CR>")

-- Seleccionar
map("n", "<C-a>", "ggVG") -- todo el archivo

-- Copiar al portapapeles
map("v", "Y", '"+y')

map("n", "<C-.>", "<cmd>Lspsaga code_action<CR>")
map("v", "<C-.>", "<cmd><C-U>Lspsaga range_code_action<CR>")
