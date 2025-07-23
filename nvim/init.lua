-- 🥾 Bootstraps lazy.nvim if it's not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
vim.fn.system({
"git", "clone", "--filter=blob:none",
"https://github.com/folke/lazy.nvim.git",
"--branch=stable", lazypath,
})
end
vim.opt.rtp:prepend(lazypath)

-- 1. ⚙️ Load core options
require("trish.options")

-- 2. 💡 Load plugins using lazy.nvim
require("lazy").setup(require("trish.plugins"))

-- 3. 🔑 Load keymaps *after* plugins are initialized
require("trish.keymaps")

-- 4. 🧠 Load LSP configs (language-specific setups)
require("trish.lsp")

-- 5. 📌 Load autocmds (event-driven automation)
-- This file sets up behaviors triggered by Neovim events, such as:
--     • Highlighting trailing whitespace on buffer enter
--     • Automatically removing trailing whitespace on save
--     • Language-specific indentation rules (Lua, Python, JS/TS)
--     • Filetype detection and buffer-local settings
require("trish.autocmds")

-- 6. 🛠️ Load custom user commands
-- This file defines user-defined commands for manual actions, such as:
--     • :GitStageLines – Stage specific line ranges with surgical precision
--     • :TrimWhitespace – Manually removes trailing whitespace (if not auto)
--     • :SortVimOptions – Alphabetically sort vim.opt settings with comments
--     • :VimBeProgress – View VimBeGood training progress in a floating window
require("trish.user_commands")