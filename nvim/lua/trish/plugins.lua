-- Return a table of plugin definitions for lazy.nvim to install and configure
return {

-- ┌────────────────────────┐
-- │ 🎨 UI & Appearance │
-- └────────────────────────┘
{
"nvim-lualine/lualine.nvim", -- Statusline at the bottom
config = function()
require("lualine").setup()
end,
},

{
"folke/tokyonight.nvim", -- Beautiful color theme
lazy = false, -- Load immediately at startup
priority = 1000, -- Load before anything else
config = function()
vim.cmd.colorscheme("tokyonight")
end,
},

{
"kyazdani42/nvim-web-devicons", -- Adds icons for file types
lazy = true,
},

-- ┌────────────────────────┐
-- │ 🔍 Navigation & Search │
-- └────────────────────────┘
{
"nvim-telescope/telescope.nvim", -- Fuzzy finder and file search
dependencies = { "nvim-lua/plenary.nvim" },
config = function()
require("telescope").setup()
end,
},

-- ┌────────────────────────┐
-- │ 🧠 LSP & Autocompletion│
-- └────────────────────────┘
{
"neovim/nvim-lspconfig", -- Collection of LSP configs
},

{
"hrsh7th/nvim-cmp", -- Completion plugin
dependencies = {
"hrsh7th/cmp-nvim-lsp", -- Completion from LSP
"L3MON4D3/LuaSnip", -- Snippet engine
},
config = function()
-- You can add your cmp setup here later
end,
},

-- ┌────────────────────────┐
-- │ 🧰 Git Integration │
-- └────────────────────────┘
{
"lewis6991/gitsigns.nvim", -- Show git changes in the sign column
config = function()
require("gitsigns").setup()
end,
},

-- ┌────────────────────────┐
-- │ 🛠 Utilities │
-- └────────────────────────┘
{
"folke/which-key.nvim", -- Popup to show possible keybindings
config = function()
require("which-key").setup()
end,
},

}