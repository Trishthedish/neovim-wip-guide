-- lua/trish/lsp/lua.lua
-- 🌙 Lua Language Server configuration
-- Configures lua_ls for Neovim development with proper vim global recognition

return function()
  local lspconfig = require("lspconfig")

  -- NUCLEAR OPTION: Force stop ALL lua_ls clients before setup
  for _, client in pairs(vim.lsp.get_clients()) do
    if client.name == "lua_ls" then
      print("Stopping existing lua_ls client:", client.id)
      client.stop()
    end
  end

  -- Wait a moment for cleanup
  vim.defer_fn(function()
    -- Now set up our properly configured lua_ls
    lspconfig.lua_ls.setup({
    -- Enhanced capabilities for completion
    capabilities = require("cmp_nvim_lsp").default_capabilities(),

    -- IMPORTANT: Enable single file support to prevent workspace conflicts
    single_file_support = true,

    -- Root directory detection
    root_dir = lspconfig.util.root_pattern(".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git"),

    -- Server-specific settings
    settings = {
      Lua = {
        runtime = {
          -- Tell lua_ls we're using LuaJIT (Neovim's Lua runtime)
          version = "LuaJIT",
        },
        diagnostics = {
          -- NUCLEAR OPTION: Recognize vim globals more aggressively
          globals = {
            "vim", "describe", "it", "before_each", "after_each",
          },
          -- Try this if the issue persists - disables the warning entirely
          disable = { "undefined-global" },
        },
        workspace = {
          -- SIMPLIFIED: Just use the basic vim runtime
          library = vim.api.nvim_get_runtime_file("", true),
          -- Force it to ignore third party warnings
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
        -- Add this to help with persistent diagnostics
        format = {
          enable = true,
          defaultConfig = {
            indent_style = "space",
            indent_size = "2",
          }
        },
      },
    },

    -- Add on_attach to ensure proper setup
    on_attach = function(client, bufnr)
      -- Clear any existing diagnostics when attaching
      vim.diagnostic.reset(nil, bufnr)

      -- Optional: Add buffer-local keymaps here if needed
      local opts = { buffer = bufnr, silent = true }
      -- Example: vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    end,

    -- Add flags to control LSP behavior
    flags = {
      debounce_text_changes = 150,
    },
      })
  end, 100) -- Wait 100ms for cleanup
end
