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

-- 1. ⚙️ Load core settings + keymaps
require("trish.options")
require("trish.keymaps")

-- 2. 💡 Load plugins using lazy.nvim
require("lazy").setup(require("trish.plugins"))

-- 3. 🔧 Load custom plugin configurations
-- Extracting complex plugins to individual /plugins/ files for better organization
-- This enables easier customization (e.g., toggling indent-blankline color schemes)
-- while keeping init.lua clean and maintainable
require("plugins.indent_blankline")

-- 4. 🧠 Load LSP configs (language-specific setups)
require("trish.lsp")

-- 5. 📌 Event-driven automation (autocmds)
-- This file sets up automatic behaviors triggered by Neovim events:
--     • Trailing whitespace highlighting when entering buffers
--     • Language-specific indentation rules (Lua, Python, JS/TS)
--     • File type detection and buffer-specific settings
require("trish.autocmds")

-- 6. 🎯 Manual user commands
-- Custom commands that extend Neovim's functionality:
--     • :GitStageLines - Stage specific line ranges with surgical precision
--     • :TrimWhitespace - Manual cleanup of trailing whitespace
--     • Other on-demand utilities and shortcuts
require("trish.user_commands")