-- lua/trish/lsp/init.lua
-- 📦 Master LSP loader
-- This file loads all language-specific LSP configs.
-- Add new languages by simply requiring their file here. Clean and scalable!

require("trish.lsp.python")() -- 🐍 Python support with Pyright
-- Add more languages like the above, one by one