local function map(mode, lhs, rhs)
    vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true, silent = true })
end

-- neotree
map("n", "<leader>e", ":Neotree toggle position=right<CR>")

-- buffer move
map("n", "<C-h>", "<C-w>h") -- move left
map("n", "<C-l>", "<C-w>l") -- move right
map("n", "<C-j>", "<C-w>j") -- move down
map("n", "<C-k>", "<C-w>k") -- move up

-- fzf
map("n", "<leader><leader>", ":FzfLua files<CR>") -- files
map("n", "<leader>fw", ":FzfLua live_grep<CR>")   -- grep
map("n", "<leader>fb", ":FzfLua buffers<CR>")     -- buffers
map("n", "<C-.>", ":Lspsaga code_action<CR>")

-- config
map("n", "<C-a>", "ggVG")         -- select all
map("n", "<C-s>", ":wa<CR>")      -- save all
map("n", "<C-p>d", ":split<CR>")  -- split down
map("n", "<C-p>r", ":vsplit<CR>") -- split right
map("n", "<C-q>", ":bdelete<CR>") -- close active tab

-- terminal
map("n", "<C-t>d", ":split | :term<CR>")
map("n", "<C-t>r", ":vsplit | :term<CR>")

-- lsp
map("n", "gI", ":lua vim.lsp.buf.hover()<CR>")

-- lazygit
map("n", "<leader>lg", ":LazyGit<CR>")
