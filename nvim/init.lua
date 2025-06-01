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

-- 3. 🧠 Load LSP configs (language-specific setups)
require("trish.lsp")

-- 4. 📌 Custom autocommands for Neovim
-- This file sets up event-driven behaviors, such as:
--     • Highlighting trailing whitespace on buffer open
--     • User commands for manual cleanup
--     • Other buffer/window-related automation
-- 💡 Make sure the 'ExtraWhitespace' highlight group is defined in your colorscheme
require("trish.autocmds")