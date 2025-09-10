-- lua/trish/lsp/python.lua
-- 🐍 Python LSP setup using Pyright

return function()
  local lspconfig = require("lspconfig")

  -- 🔍 Helper: auto-detect the Python interpreter
  local function get_python_path(workspace)
    -- 1️⃣ Use currently active virtualenv
    if vim.env.VIRTUAL_ENV then
      return vim.env.VIRTUAL_ENV .. "/bin/python"
    end

    -- 2️⃣  Check workspace for common venv folders
    local paths = { workspace .. "/.venv/bin/python", workspace .. "/venv/bin/python" }
    for _, path in ipairs(paths) do
      if vim.fn.filereadable(path) == 1 then
        return path
      end
    end

    -- 3️⃣  Fallback: system Python
    return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
  end

  -- 🔧 Configure Pyright LSP
  lspconfig.pyright.setup({
    capabilities = require("cmp_nvim_lsp").default_capabilities(),

    on_init = function(client)
      local python_path = get_python_path(client.config.root_dir)
      client.config.settings.python.pythonPath = python_path
      print("🐍 Pyright using Python interpreter: " .. python_path)
      return true
    end,

    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,        -- 📚 Automatically find Python paths
          useLibraryCodeForTypes = true, -- 📦 Use installed packages for better type inference
          typeCheckingMode = "basic",    -- 🔍 Options: "off", "basic", or "strict"
        },
      },
    },
  })
end
