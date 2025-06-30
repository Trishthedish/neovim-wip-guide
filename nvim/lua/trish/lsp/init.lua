-- lua/trish/lsp/init.lua
-- 📦 Master LSP loader
-- This file loads all language-specific LSP configs.
-- Add new languages by simply requiring their file here. Clean and scalable!

-- 🐍 Python support with Pyright
require("trish.lsp.python")()

-- 🌙 Lua support with lua_ls
require("trish.lsp.lua")()

-- Add more languages like the above, one by one
