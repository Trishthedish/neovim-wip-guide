-- nvim/lua/trish/autocmds.lua
-- Highlight trailing whitespace in active buffers using the 'ExtraWhitespace'
-- highlight group, unless the filetype is in the excluded list. This helps
-- visually spot accidental trailing spaces before saving or committing changes.
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    local filetype = vim.api.nvim_get_option_value("filetype", { buf = 0 })
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = 0 })

    local exclude = {
      help = true,
      dashboard = true,
      NvimTree = true,
      Lazy = true,
      lazy = true,
      lualine = true,
    }

    -- 🛑 Disable highlight in special buffers
    if buftype ~= "" or exclude[filetype] then
      vim.cmd([[match none]])
    else
      vim.cmd([[match ExtraWhitespace /\s\+$/]])
    end
  end,
})

-- Function to remove trailing whitespace in the current buffer
local function remove_trailing_whitespace()
  -- %s/\s\+$//e  → substitute trailing whitespace with nothing, no error if none found
  vim.cmd([[%s/\s\+$//e]])
end

-- Create a user command :TrimWhitespace to run it manually
vim.api.nvim_create_user_command("TrimWhitespace", remove_trailing_whitespace, {})