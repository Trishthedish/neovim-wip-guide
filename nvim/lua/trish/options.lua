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

-- Highlight the line under the cursor (great for keeping visual track of where you are)
vim.opt.cursorline = true

-- Use the system clipboard for all yank, delete, change, and put operations
-- This means you can copy between Neovim and other macOS apps like Safari or Notes seamlessly
vim.opt.clipboard = "unnamedplus"

-- Make searches case-insensitive by default (`/hello` matches `Hello`, `HELLO`, etc.)
vim.opt.ignorecase = true

-- ...but if your search includes an uppercase letter, make it case-sensitive
-- This smart combo lets you stay lazy *or* precise depending on how you type (`/Hello` only matches `Hello`)
vim.opt.smartcase = true

-- Copy indent from current line when starting a new line
vim.opt.autoindent = true

-- Makes <Tab> insert the correct number of spaces
vim.opt.smarttab = true
