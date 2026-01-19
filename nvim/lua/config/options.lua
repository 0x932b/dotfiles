local opt = vim.opt

-- Leaders
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Language settings
vim.opt.langmenu = "none"
vim.cmd("language messages en_US")

-- General settings
opt.clipboard = "unnamed"
opt.expandtab = true
opt.smarttab = true
opt.autoindent = true
opt.smartindent = true
opt.cindent = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.wildmode = "longest:full"
opt.wildmenu = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4

-- Backup and undo
local backupdir = vim.fn.stdpath("state") .. "/backup"
if vim.fn.isdirectory(backupdir) == 0 then
    vim.fn.mkdir(backupdir, "p")
end
opt.backup = true
opt.backupdir = backupdir .. "/"

local undodir = vim.fn.stdpath("state") .. "/undo"
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p")
end
opt.undofile = true
opt.undodir = undodir .. "/"

-- Appearance and UI
opt.wrap = true
opt.linebreak = true
opt.number = true
opt.ruler = true
opt.mouse = "a"
opt.showcmd = true
opt.hidden = true
opt.lazyredraw = true
opt.magic = true
opt.showmatch = true
opt.whichwrap:append("<,>,h,l")
opt.list = false
opt.winminheight = 0
opt.winminwidth = 0
opt.laststatus = 2
opt.cursorline = true

-- Colorscheme
opt.termguicolors = true
vim.cmd("syntax on")

-- Disable semantic tokens to match classic Vim look
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then
            client.server_capabilities.semanticTokensProvider = nil
        end
    end,
})

-- Encoding
opt.fileencodings = "utf-8,big5,euc-jp,gbk,euc-kr,utf-bom,iso8859-1"

-- Backspace
opt.backspace = "eol,start,indent"

-- Statusline
-- Ported from: set statusline=%{(&paste)?'[p]':''}%m%f%= %{mode()} [%{&fenc}] [%{&ft!=''?&ft:'none'}] Col %c, Line %l/%L %p%%
opt.statusline = "%{(&paste)?'[p]':''}%m%f%= %{mode()} [%{&fenc}] [%{&ft!=''?&ft:'none'}] Col %c, Line %l/%L %p%%"

-- Custom commands
vim.api.nvim_create_user_command("DiffLS", function()
    vim.cmd("w !diff % -")
end, {})

vim.api.nvim_create_user_command("Nonu", function()
    vim.opt.relativenumber = false
    vim.opt.number = false
end, {})

vim.api.nvim_create_user_command("Nu", function()
    vim.opt.relativenumber = true
    vim.opt.number = true
end, {})

-- Autocmds
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Strip trailing whitespace on save
local strip_whitespace_group = augroup("StripTrailingWhitespace", { clear = true })
autocmd("BufWritePre", {
    group = strip_whitespace_group,
    pattern = { "*.c", "*.cpp", "*.java", "*.php", "*.ruby", "*.python" },
    callback = function()
        local l = vim.fn.line(".")
        local c = vim.fn.col(".")
        vim.cmd("%s/\\s\\+$//e")
        vim.fn.cursor(l, c)
    end,
})

-- Save last position
autocmd("BufReadPost", {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Filetypes
autocmd({ "BufReadPost", "BufNewFile" }, {
    pattern = "*.tt",
    command = "set filetype=html",
})
autocmd({ "BufReadPost", "BufNewFile" }, {
    pattern = "httpd*.conf",
    command = "set filetype=apache",
})

-- Highlight trailing spaces
local highlight_space_group = augroup("highLightSpace", { clear = true })
vim.api.nvim_set_hl(0, "ExtraWhitespace", { bg = "red" })
autocmd({ "BufWinEnter", "InsertLeave" }, {
    group = highlight_space_group,
    pattern = "*",
    command = "match ExtraWhitespace /\\s\\+$/",
})
autocmd("InsertEnter", {
    group = highlight_space_group,
    pattern = "*",
    command = "match ExtraWhitespace /\\s\\+\\%#\\@<!$/",
})
autocmd("BufWinLeave", {
    group = highlight_space_group,
    pattern = "*",
    callback = function()
        vim.fn.clearmatches()
    end,
})

-- Open NERDTree if opened on a directory
autocmd("VimEnter", {
    callback = function()
        local arg0 = vim.fn.argv(0)
        if arg0 ~= "" and vim.fn.isdirectory(arg0) == 1 then
            vim.cmd("bd")
            vim.cmd("cd " .. vim.fn.fnameescape(arg0))
            vim.cmd("NERDTree")
        end
    end,
})
