-- nvim/lua/trish/user-commands.lua

-- ========================================
-- 🧹 File Cleanup Commands
-- ========================================

-- Function to remove trailing whitespace in the current buffer
local function remove_trailing_whitespace()
  -- %s/\s\+$//e  → substitute trailing whitespace with nothing, no error if none found
  vim.cmd([[%s/\s\+$//e]])
end

-- Create a user command :TrimWhitespace to run it manually
vim.api.nvim_create_user_command("TrimWhitespace", remove_trailing_whitespace, {})

-- ========================================
-- 🎯 Custom Git Commands
-- ========================================

-- Simple command to stage specific lines
-- Command to stage specific lines
-- Usage: :GitStageLines 7 15
-- Usage: :GitStageLines 42 (single line)

vim.api.nvim_create_user_command("GitStageLines", function(opts)
  local args = vim.split(opts.args, "%s+")
  if #args == 0 then
    vim.notify("Usage: GitStageLines <start_line> [end_line]", vim.log.levels.ERROR)
    return
  end

  local start_line = tonumber(args[1])
  local end_line = tonumber(args[2]) or start_line

  if not start_line or not end_line then
    vim.notify("Line numbers must be valid integers", vim.log.levels.ERROR)
    return
  end

  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  -- Use gitsigns to stage the specific lines
  require("gitsigns").stage_hunk({start_line, end_line})

  local range_desc = start_line == end_line and ("line " .. start_line) or ("lines " .. start_line .. "-" .. end_line)
  vim.notify("Staged " .. range_desc, vim.log.levels.INFO)
end, {
  nargs = "+",
  desc = "Stage specific lines (start_line [end_line])"
})

-- ========================================
-- 📈 VimBeGood Motivator
-- ========================================
-- 📈 VimBeGood Motivator Progress Window (:VimBeProgress)
-- Opens a centered floating window with personalized VimBeGood stats.
-- Shows today's sessions, average time, current streak, skill breakdown,
-- and a motivational tip of the day. Great for tracking your improvement
-- and staying inspired as you level up your Vim skills!

vim.api.nvim_create_user_command("VimBeProgress", function()
  require("trish.vimbegood_motivator").open()
end, {
  desc = "Open floating VimBeGood progress window"
})
