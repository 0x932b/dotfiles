-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    -- Project and file navigation
    {
        'scrooloose/nerdtree',
        config = function()
            vim.g.NERDTreeMinimalUI = 1
            vim.g.NERDTreeDirArrows = 1
            vim.g.NERDChristmasTree = 1
            vim.g.NERDTreeChDirMode = 2
            vim.g.NERDTreeHighlightCursorline = 1
            vim.g.NERDTreeIgnore = { '\\.pyc$', '\\.pyo$', '__pycache__$' }
            vim.g.NERDTreeWinSize = 40

            -- Automatically close the tab if the last window open is nerdtree
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = "*",
                callback = function()
                    if vim.fn.winnr("$") == 1 and vim.fn.exists("b:NERDTree") == 1 and vim.b.NERDTree.isTabTree() then
                        vim.cmd("q")
                    end
                end,
            })
        end
    },
    'majutsushi/tagbar',
    'Xuyuanp/nerdtree-git-plugin',

    -- Syntax Checking/completion
    {
        'dense-analysis/ale',
        config = function()
            vim.g.ale_linters = { python = { "ruff", "pyright" } }
            vim.g.ale_fixers = { python = { "black", "isort" } }
            vim.g.ale_python_isort_options = '-m 3 -tc'
            vim.g.ale_fix_on_save = 1
        end
    },
    {
        'jiangmiao/auto-pairs',
        init = function()
            vim.g.AutoPairs = { ['('] = ')', ['['] = ']', ['{'] = '}', ['`'] = '`', ['```'] = '```', ['"""'] = '"""', ["'''"] = "'''" }
        end
    },

    -- Other
    'tpope/vim-fugitive',
    'godlygeek/tabular',

    -- Markdown support
    {
        'plasticboy/vim-markdown',
        init = function()
            vim.g.vim_markdown_folding_disabled = 1
            vim.g.vim_markdown_folding_style_pythonic = 1
            vim.g.vim_markdown_math = 1
        end
    },
})
