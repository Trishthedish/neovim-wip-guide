-- nvim/lua/trish/autocmds.lua
-- Highlight trailing whitespace in active buffers using the 'ExtraWhitespace'
-- highlight group, unless the filetype is in the excluded list. This helps
-- visually spot accidental trailing spaces before saving or committing changes.
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    local filetype = vim.api.nvim_get_option_value("filetype", { buf = 0 })
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = 0 })
    local bufname = vim.api.nvim_buf_get_name(0)

    -- More comprehensive exclusion list
    local exclude = {
      help = true,
      dashboard = true,
      NvimTree = true,
      Lazy = true,
      lazy = true,
      lualine = true,
      mason = true,
      snacks_dashboard = true,
      snacks = true,
      [""] = true,  -- Empty filetype
    }

    -- Exclude special buffer types
    local exclude_buftypes = {
      nofile = true,
      terminal = true,
      prompt = true,
      help = true,
      quickfix = true,
    }

    -- Check if buffer name contains snacks (fallback)
    local is_snacks_buffer = bufname:match("snacks") or bufname:match("dashboard")

    -- Disable highlight if any exclusion condition is met
    if exclude_buftypes[buftype] or
       exclude[filetype] or
       is_snacks_buffer then
      vim.cmd([[match none]])
    else
      vim.cmd([[match ExtraWhitespace /\s\+$/]])
    end
  end,
})

-- Set Lua-specific indentation rules when editing Lua files.
-- This ensures consistent formatting aligned with common Lua style guides:
-- - 2 spaces per indent level
-- - Tabs are replaced with spaces
-- - Smart indentation is enabled for language-aware structure like functions and blocks
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua", -- Trigger only for Lua filetypes
  desc = "Set Lua-specific indentation settings",
  callback = function()
    vim.bo.shiftwidth = 2       -- Use 2 spaces per indentation level when indenting with >> or <<
    vim.bo.tabstop = 2          -- A tab character appears as 2 spaces
    vim.bo.softtabstop = 2      -- Insert 2 spaces when pressing <Tab> in insert mode
    vim.bo.expandtab = true     -- Convert all tabs to spaces (for consistency)
    vim.bo.autoindent = true    -- Copy indentation from the previous line when starting a new one
    vim.bo.smartindent = true   -- Automatically add extra indentation for control structures (if, function, etc.)
  end,
})

-- Set Python-specific indentation rules when editing Python files.
-- This enforces common Python style guide (PEP 8) conventions:
-- - 4 spaces per indentation level (preferred over tabs)
-- - Tabs are replaced with spaces to avoid formatting inconsistencies
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python", -- Trigger only for Python files
  desc = "Set Python-specific indentation settings",
  callback = function()
    vim.opt_local.shiftwidth = 4   -- 4 spaces for each level of indentation
    vim.opt_local.tabstop = 4      -- A tab character appears as 4 spaces
    vim.opt_local.expandtab = true -- Use spaces instead of tab characters
  end,
})

-- Set JS/TS-specific indentation rules for consistent frontend code style.
-- These settings align with common community standards (like Prettier, ESLint):
-- - 2 spaces per indentation level
-- - Tabs are replaced with spaces for cross-editor consistency
vim.api.nvim_create_autocmd("FileType", {
  pattern = "javascript,typescript", -- Trigger for both JavaScript and TypeScript files
  desc = "Set JavaScript/TypeScript-specific indentation settings",
  callback = function()
    vim.opt_local.shiftwidth = 2   -- 2 spaces for each level of indentation
    vim.opt_local.tabstop = 2      -- A tab character appears as 2 spaces
    vim.opt_local.expandtab = true -- Use spaces instead of tab characters
  end,
})

-- Configure conceallevel for Obsidian vault markdown files to enable enhanced UI features.
-- This setting allows obsidian.nvim to display fancy checkboxes, hide markdown syntax,
-- and provide a cleaner reading experience similar to the Obsidian app itself.
-- Only applies to files within the specific Obsidian vault path to avoid affecting
-- other markdown files edited elsewhere.
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "/Users/trish/Library/Mobile Documents/iCloud~md~obsidian/Documents/MasterVault/*.md",
  desc = "Set conceallevel for Obsidian vault files to enable obsidian.nvim UI features",
  callback = function()
    vim.opt_local.conceallevel = 2
  end,
})
