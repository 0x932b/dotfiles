local keymap = vim.keymap

-- General mappings
keymap.set({"n", "v"}, ";", ":")
keymap.set("n", "j", "gj")
keymap.set("n", "k", "gk")
keymap.set("v", "j", "gj")
keymap.set("v", "k", "gk")

-- Leader mappings
keymap.set("n", "<Leader>h", ":noh<CR>", { silent = true, desc = "Clear search highlight" })
keymap.set("n", "<Leader>m", ":set nu!<CR>", { silent = true, desc = "Toggle line numbers" })
keymap.set("n", "<Leader>p", ":set paste!<CR>", { silent = true, desc = "Toggle paste mode" })

-- Arrows to NOP
keymap.set({ "n", "v", "i" }, "<Up>", "<NOP>")
keymap.set({ "n", "v", "i" }, "<Down>", "<NOP>")
keymap.set({ "n", "v", "i" }, "<Left>", "<NOP>")
keymap.set({ "n", "v", "i" }, "<Right>", "<NOP>")

-- Plugin mappings (these will work once plugins are loaded)
keymap.set("n", "<Leader>a", ":ALEFix<CR>", { desc = "ALE Fix" })
keymap.set("n", "gd", ":ALEGoToDefinition<CR>", { silent = true, desc = "ALE Go To Definition" })
keymap.set("n", "<Leader>n", ":NERDTreeToggle<CR>", { desc = "Toggle NERDTree" })
keymap.set("n", "<Leader>t", ":TagbarToggle<CR>", { desc = "Toggle Tagbar" })
keymap.set("n", "<leader>aj", ":ALENext<cr>", { silent = true, desc = "ALE Next" })
keymap.set("n", "<leader>ak", ":ALEPrevious<cr>", { silent = true, desc = "ALE Previous" })

-- Custom command mappings
keymap.set("n", "<Leader>d", ":DiffLS<CR>", { desc = "Show diff since last save" })

-- Show syntax highlighting groups for word under cursor
keymap.set("n", "<C-C>", function()
    local stack = vim.fn.synstack(vim.fn.line("."), vim.fn.col("."))
    local names = {}
    for _, id in ipairs(stack) do
        table.insert(names, vim.fn.synIDattr(id, "name"))
    end
    print(table.concat(names, " -> "))
end, { desc = "Show syntax highlight groups" })
