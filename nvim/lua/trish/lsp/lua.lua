
-- lua/trish/lsp/lua.lua
-- 🌙 Lua Language Server configuration
-- Configures lua_ls for Neovim development with proper vim global recognition

return function()
  local lspconfig = require("lspconfig")

  -- Prevent multiple setups of the same Server
  if lspconfig.lua_ls.manager then
    return
  end

  lspconfig.lua_ls.setup({
    -- Enhanced capabilities for completion
    capabilities = require("cmp_nvim_lsp").default_capabilities(),

    -- Only start once per root directory
    single_file_support = false,

    -- Server-specific settings
    settings = {
      Lua = {
        runtime = {
          -- Tell lua_ls we're using LuaJIT (Neovim's Lua runtime)
          version = "LuaJIT",
        },
        diagnostics = {
          -- Recognize 'vim' as a valid global variable
          globals = { "vim" },
        },
        workspace = {
          -- Make lua_ls aware of Neovim's runtime files for better completions
          library = vim.api.nvim_get_runtime_file("", true),
          -- Don't ask about luassert, busted, etc. in workspace
          checkThirdParty = false,
        },
        telemetry = {
          -- Don't send usage statistics to lua_ls developers
          enable = false,
        },
        -- Better IntelliSense
        completion = {
          callSnippet = "Replace"
        },
      },
    },
  })
end
