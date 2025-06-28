-- lua/trish/lsp/python.lua
-- 🐍 Python LSP setup using Pyright

return function()
  local lspconfig = require("lspconfig")

  lspconfig.pyright.setup({
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic", -- 🔍 Options: "off", "basic", or "strict"
          autoSearchPaths = true,     -- 📚 Automatically find Python paths
          useLibraryCodeForTypes = true, -- 📦 Use installed packages for better type inference
        },
      },
    },
  })
end
