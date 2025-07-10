-- lua/trish/lsp/lua.lua
-- 🌙 Lua Language Server configuration

return function()
  local lspconfig = require("lspconfig")

  -- Simple, clean setup without the "nuclear options"
  lspconfig.lua_ls.setup({
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    single_file_support = true,

    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
        completion = {
          callSnippet = "Replace"
        },
      },
    },
  })
end
