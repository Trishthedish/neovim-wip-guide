-- options.lua

-- Show absolute line number for the current line (useful for orientation)
vim.opt.number = true

-- Show relative line numbers for all other lines (helps with movement like `5k`, `3j`)
vim.opt.relativenumber = true

-- Enable mouse support in all modes (normal, insert, visual, etc.)
vim.opt.mouse = "a"

-- Set the number of visual spaces a <Tab> counts for (on screen)
vim.opt.tabstop = 4

-- Set the number of spaces inserted when indenting with `>>`, `<<`, or auto-indent
vim.opt.shiftwidth = 4

-- Use spaces instead of tabs when pressing the <Tab> key
vim.opt.expandtab = true

-- Enable intelligent auto-indenting based on file type and syntax
vim.opt.smartindent = true

-- Disable automatic line wrapping — long lines will overflow horizontally
vim.opt.wrap = false

-- Enable true color support (for better theme compatibility in supported terminals)
vim.opt.termguicolors = true