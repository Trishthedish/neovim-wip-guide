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
    on_attach = function(client, bufnr)
      -- 🔧 Optional: Custom behavior once LSP is attached to a buffer
      -- (e.g., keybindings for LSP actions like hover, go to def, etc.)

      local buf_map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, {
          noremap = true,
          silent = true,
          buffer = bufnr,
          desc = "LSP: " .. desc,
        })
      end

      -- 🪄 Example keymaps:
      buf_map("n", "K", vim.lsp.buf.hover, "Hover documentation")
      buf_map("n", "gd", vim.lsp.buf.definition, "Go to definition")
      buf_map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
      buf_map("n", "gr", vim.lsp.buf.references, "List references")
      buf_map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
      buf_map("n", "<leader>ca", vim.lsp.buf.code_action, "Code actions")
      buf_map("n", "<leader>ds", vim.lsp.buf.document_symbol, "Document symbols")
    end,
  })
end