-- nvim/lua/trish/autocmds.lua
-- When a buffer window is opened, highlight any trailing whitespace at the end of lines
-- using the 'ExtraWhitespace' highlight group (which should be defined elsewhere).
-- This helps visually spot and clean up unnecessary whitespace.
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  callback = function()
    vim.cmd([[match ExtraWhitespace /\s\+$/]])
  end,
})

-- Function to remove trailing whitespace in the current buffer
local function remove_trailing_whitespace()
  -- %s/\s\+$//e  → substitute trailing whitespace with nothing, no error if none found
  vim.cmd([[%s/\s\+$//e]])
end

-- Create a user command :TrimWhitespace to run it manually
vim.api.nvim_create_user_command("TrimWhitespace", remove_trailing_whitespace, {})