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

-- SortVimOptions: Alphabetizes vim.opt settings while keeping comments attached
-- Preserves file header, maintains spacing, and reports duplicates
-- Usage: :SortVimOptions
-- This function sorts vim.opt blocks found in options.lua
-- while keeping comments attached
local function sort_vim_options()
  -- Get the current buffer content
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  -- Always preserve line 1 (file header) and skip it
  local header = lines[1] or ""

  -- Find all vim.opt lines first to establish what we're sorting
  local vim_opt_positions = {}
  for i = 2, #lines do
    if lines[i]:match("^%s*vim%.opt%.") then
      local opt_name = lines[i]:match("vim%.opt%.([%w_]+)")
      table.insert(vim_opt_positions, {
        line_num = i,
        opt_name = opt_name or "",
        line_content = lines[i]
      })
    end
  end

  -- For each vim.opt line, find its associated comments
  local blocks = {}
  for idx, opt_info in ipairs(vim_opt_positions) do
    local block_lines = {}
    local opt_line_num = opt_info.line_num

    -- Look backwards from the vim.opt line to find its comments
    local search_start = idx == 1 and 2 or (vim_opt_positions[idx-1].line_num + 1)

    -- Collect comments and empty lines that belong to this vim.opt
    for i = search_start, opt_line_num - 1 do
      local line = lines[i]
      if line:match("^%s*%-%-") or line:match("^%s*$") then
        table.insert(block_lines, line)
      end
    end

    -- Keep empty lines as part of the block (they provide spacing)

    -- Add the vim.opt line itself
    table.insert(block_lines, opt_info.line_content)

    -- Save the complete block
    table.insert(blocks, {
      lines = block_lines,
      sort_key = opt_info.opt_name,
      original_order = idx
    })
  end

  -- Check for duplicates and report them
  local seen_options = {}
  local duplicates = {}

  for _, block in ipairs(blocks) do
    if seen_options[block.sort_key] then
      table.insert(duplicates, block.sort_key)
    else
      seen_options[block.sort_key] = true
    end
  end

  -- Sort blocks alphabetically by the vim.opt option name
  table.sort(blocks, function(a, b)
    if a.sort_key == b.sort_key then
      return a.original_order < b.original_order
    end
    return a.sort_key < b.sort_key
  end)

  -- Reconstruct the file
  local new_lines = {}

  -- Add the header (line 1)
  table.insert(new_lines, header)

  -- Add sorted blocks (they already include their spacing)
  for _, block in ipairs(blocks) do
    for _, line in ipairs(block.lines) do
      table.insert(new_lines, line)
    end
  end

  -- Replace buffer content with sorted content
  vim.api.nvim_buf_set_lines(0, 0, -1, false, new_lines)

  -- Friendly completion message
  local message = "Sorted " .. #blocks .. " vim.opt blocks alphabetically"

  if #duplicates > 0 then
    local unique_duplicates = {}
    for _, dup in ipairs(duplicates) do
      unique_duplicates[dup] = true
    end

    local dup_list = {}
    for dup, _ in pairs(unique_duplicates) do
      table.insert(dup_list, dup)
    end
    table.sort(dup_list)

    message = message .. "\n⚠️  Found duplicate options: " .. table.concat(dup_list, ", ")
    message = message .. "\n   (Kept original order for duplicates)"
  end

  print(message)
end

-- Create a command to run the sorter
vim.api.nvim_create_user_command('SortVimOptions', sort_vim_options, {
  desc = 'Sort vim.opt settings alphabetically while keeping comments & header attached'
})
