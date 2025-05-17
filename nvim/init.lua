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

-- ⚙️ Load core config: settings + keymaps
require("trish.options")
require("trish.keymaps")

-- 💡 Load plugins using lazy.nvim
require("lazy").setup(require("trish.plugins"))