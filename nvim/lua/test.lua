-- Set up runtime path to include the nvim directory
local nvim_dir = vim.fn.getcwd() .. "/nvim"
vim.opt.rtp:prepend(nvim_dir)

-- Load the configuration
require("init")

local failed = false
local function assert_val(name, actual, expected)
    if actual ~= expected then
        print(string.format("FAIL: %s | Expected: %s, Got: %s", name, tostring(expected), tostring(actual)))
        failed = true
    else
        print(string.format("PASS: %s", name))
    end
end

-- 1. Check Leaders
assert_val("mapleader", vim.g.mapleader, " ")
assert_val("maplocalleader", vim.g.maplocalleader, "\\")

-- 2. Check Options
assert_val("expandtab", vim.opt.expandtab:get(), true)
assert_val("shiftwidth", vim.opt.shiftwidth:get(), 4)
local expected_backup = vim.fn.stdpath("state") .. "/backup/"
assert_val("backupdir", vim.opt.backupdir:get()[1], expected_backup)

-- 3. Check Custom Commands
assert_val("Command DiffLS exists", vim.fn.exists(":DiffLS"), 2)
assert_val("Command Nonu exists", vim.fn.exists(":Nonu"), 2)

-- 4. Check Plugin Config (Globals)
-- These might need some time to load if lazy-loaded, 
-- but we set them in the config/init functions of lazy.nvim.
assert_val("ALE Python linters", vim.g.ale_linters.python[1], "ruff")
assert_val("NERDTree Minimal UI", vim.g.NERDTreeMinimalUI, 1)

-- 5. Check Colorscheme
assert_val("colorscheme", vim.g.colors_name, "dm4")
assert_val("termguicolors", vim.opt.termguicolors:get(), true)

if failed then
    print("\nSome tests FAILED!")
    vim.cmd("cquit") -- Exit with non-zero status
else
    print("\nAll tests PASSED!")
    vim.cmd("q")
end
