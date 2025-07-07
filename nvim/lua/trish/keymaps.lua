-- keymaps.lua
-- 🧭 Custom keybindings (shortcuts) for Neovim
-- These mappings improve productivity by making common actions faster.

-- 🧠 Legend:
-- Modes: "n" = Normal, "v" = Visual, "i" = Insert
-- <leader> = Spacebar (set below)
-- <D-*> = Cmd key on macOS (⌘)

-- 🚀 Set <leader> key
vim.g.mapleader = " "

-- ⛏ Helper alias for shorter calls
-- Creates a local shortcut to the Neovim keymap function
-- Makes it easier to reuse without typing `vim.keymap.set` every time
local keymap = vim.keymap.set

-- ========================================
-- 📁 NORMAL MODE KEYBINDINGS
-- ========================================
-- ⓘ This first keybinding is fully broken down for learning purposes:
-- - It explains what each part of the keymap does.
-- - All future keymaps below will follow a cleaner format (see 🗂 example).
-- - This helps keep things readable while still leaving one “reference” example.

-- Normal mode keybinding: Open the file explorer
-- "n": means this works in Normal mode
-- "<leader>e": means you press: Spacebar, then E
-- ":Ex<CR>": is the command to open netrw (the file explorer) and "press Enter"
-- -------- The 'desc' helps tools like 'which-key' show what the shortcut does

-- 🗂 Open file explorer (Space + e)
keymap("n", "<leader>e", ":Ex<CR>", {
  desc = "Open file explorer",
})

-- 💾 Save file with feedback (Space + w)
vim.keymap.set("n", "<leader>w", function()
  print("🔧 Save function triggered!")
  vim.cmd("w")
  vim.api.nvim_echo({{"💾 File saved with Space+w!", "Normal"}}, false, {})
end, {
  noremap = true,
  desc = "Save file with feedback",
})

-- 📋 Paste from system clipboard (⌘V)
keymap("n", "<D-v>", '"+p', {
  noremap = true,
  silent = true,
  desc = "Paste from system clipboard (Cmd+V)",
})

-- Select All (⌘A)
keymap("n", "<D-a>", "ggVG", {
    noremap = true,
    silent = true,
    desc = "Select all (cmd+A)",
})

-- 📄 Copy current line (⌘C in normal mode)
keymap("n", "<D-c>", '"+yy', {
  noremap = true,
  silent = true,
  desc = "Copy current line (Cmd+C)",
})

-- 📋 Copy entire buffer WITHOUT line numbers (Space + y + n)
keymap("n", "<leader>yn", function()
  vim.opt.number = false
  vim.opt.relativenumber = false
  vim.cmd('normal! ggVG"+y')
  vim.opt.number = true
  vim.opt.relativenumber = true
end, {
  desc = "Copy whole buffer without line numbers",
})

-- 📋 Copy entire buffer WITH visible line numbers (Space + y + l)
keymap("n", "<leader>yl", function()
  vim.cmd('set number relativenumber') -- make sure numbers are visible
  vim.cmd('normal! ggVG"+y')
end, {
  desc = "Copy whole buffer with line numbers",
})

-- ✂️ Trim trailing whitespace manually (Space + t + w)
keymap("n", "<leader>tw", "<cmd>TrimWhitespace<CR>", {
  noremap = true,
  silent = true,
  desc = "Trim trailing whitespace manually",
})

-- 📐 Cycle through indent guide settings (Space + t + i)
-- Cycles through: rainbow_dashed → rainbow_continuous → gray_simple → repeat
-- Useful for adjusting visual indentation cues based on current coding context
keymap('n', '<leader>ti', function()
  require('plugins.indent_blankline').cycle_indent_guides()
end, { desc = "Cycle indent guide styles" })

-- 🔁 Reload Luasnip snippets from /nvim/lua/trish/snippets/
-- This lets you refresh your snippets without restarting Neovim.
vim.keymap.set("n", "<leader>sr", function()
  require("luasnip.loaders.from_lua").lazy_load({
    paths = "~/.config/nvim/lua/trish/snippets",
  })
  vim.notify("🔄 Snippets reloaded!", vim.log.levels.INFO)
end, { desc = "LuaSnip: Reload Snippets" })

-- 🚀 Hot-reload current Lua file
-- (great for plugin/dev work!)
vim.keymap.set("n", "<leader>rr",
  "<cmd>luafile %<CR>",
{ desc = "Reload current Lua file" })

-- 🔍 Clear Search Highlights (Double Escape)
-- Press <Esc><Esc> in normal mode to clear lingering `/` or `?` search highlights.
-- Handy after navigating with `n` or `N` and no longer needing the highlight.
-- Mimics behavior from some plugins or IDEs for quick visual reset.
vim.keymap.set("n", "<Esc><Esc>", "<cmd>nohlsearch<CR>", {
  desc = "Clear search highlight"
})

-- 📓 Open Cheatsheet
-keymap("n", <leader>cc, "<cmd>Telescope Cheatsheet<CR>", {
  desc = "📓 Cheetsheets via Telescope"
})

-- ========================================
-- 🔧 LSP KEYBINDINGS (Language Server Protocol)
-- ========================================
-- These keymaps work when LSP is attached to a buffer
-- They provide IDE-like functionality: hover docs, go to definition, etc.

-- 📖 Show hover documentation (k)
keymap("n", "K", vim.lsp.buf.hover, {
  noremap = true,
  silent = true,
  desc = "LSP: Hover documentation",
})

-- 🎯 Go to definition (g + d)
keymap("n", "gd", vim.lsp.buf.definition, {
  noremap = true,
  silent = true,
  desc = "LSP: Go to definition",
})

-- 🔗 Go to implementation (g + i)
keymap("n", "gi", vim.lsp.buf.implementation, {
  noremap = true,
  silent = true,
  desc = "LSP: Go to implementation",
})

-- 📚 List all references (g + r)
keymap("n", "gr", vim.lsp.buf.references, {
  noremap = true,
  silent = true,
  desc = "LSP: List references",
})

-- ✏️ Smart rename across entire project (Space + r + n)
-- ⚠️ CHANGES YOUR CODE: Renames symbol everywhere - make sure you want this!
-- 💡 SUPER USEFUL: Safely rename variables/functions everywhere they're used
-- Example: Rename "calc_area" to "calculate_circle_area" in 50+ files instantly
-- Much safer than find/replace - understands code context and won't break strings
keymap("n", "<leader>rn", vim.lsp.buf.rename, {
  noremap = true,
  silent = true,
  desc = "LSP: Smart rename everywhere",
})

-- ⚡ AI-powered code suggestions (Space + c + a)
-- ⚠️ MAY CHANGE CODE: Some suggestions will modify your code when applied
-- 💡 SUPER USEFUL: Shows smart fixes and improvements at cursor location
-- Examples: "Remove unused import", "Add missing type hint", "Fix syntax error"
-- Like having a coding mentor suggest improvements as you work
keymap("n", "<leader>ca", vim.lsp.buf.code_action, {
  noremap = true,
  silent = true,
  desc = "LSP: Show smart suggestions",
})

-- 📋 Jump to any function/class in current file (Space + d + s)
-- 💡 USEFUL: Navigate large files quickly - shows searchable outline
-- Like a "table of contents" for your code - find functions instantly
-- Great for files with 100+ lines where scrolling gets tedious
keymap("n", "<leader>ds", vim.lsp.buf.document_symbol, {
  noremap = true,
  silent = true,
  desc = "LSP: File outline/navigation",
})

-- 🔧 Auto-format code styling: spacing, indentation, line breaks (Space + f + m)
-- ⚠️ CHANGES YOUR CODE: Only affects visual formatting, not logic/bugs
-- 💡 USEFUL: Makes messy code neat and consistent with style standards
-- Example: Fixes spacing around operators, proper indentation, line lengths
keymap("n", "<leader>fm", function()
  vim.lsp.buf.format({ async = true })
end, {
  noremap = true,
  silent = true,
  desc = "LSP: Format buffer",
})

-- 🚨 Show line diagnostics (Space + d + l)
keymap("n", "<leader>dl", vim.diagnostic.open_float, {
  noremap = true,
  silent = true,
  desc = "LSP: Show line diagnostics",
})

-- ⬆️ Go to previous diagnostic ([ + d)
keymap("n", "[d", vim.diagnostic.goto_prev, {
  noremap = true,
  silent = true,
  desc = "LSP: Previous diagnostic",
})

-- ⬇️ Go to next diagnostic (] + d)
keymap("n", "]d", vim.diagnostic.goto_next, {
  noremap = true,
  silent = true,
  desc = "LSP: Next diagnostic",
})

-- 📋 Show all diagnostics in location list (Space + d + a)
keymap("n", "<leader>da", vim.diagnostic.setloclist, {
  noremap = true,
  silent = true,
  desc = "LSP: Show all diagnostics",
})

-- 🍿 Toggle Line Number View (space + l + n)
-- Switch between relative line numbers (your default)
-- and absolute-only line numbers.
-- This uses snacks.nvim to manage UI state cleanly.
vim.keymap.set("n", "<leader>ln", function()
  local snacks = require("snacks")

  -- Check if snacks has toggle utility and our toggle exists
  if snacks.toggle and snacks.toggle.get and snacks.toggle.get("line_numbers_toggle") then
    -- Use snacks toggle
    snacks.toggle("line_numbers_toggle")
    -- Add feedback message
    if vim.opt.relativenumber:get() then
      print("🔄 Relative line numbers")
    else
      print("📊 Absolute line numbers")
    end
  else
    -- Fallback to direct approach
    local current_relative = vim.opt.relativenumber:get()
    if current_relative then
      vim.opt.number = true
      vim.opt.relativenumber = false
      print("📊 Absolute line numbers")
    else
      vim.opt.number = true
      vim.opt.relativenumber = true
      print("🔄 Relative line numbers")
    end
  end
end, { desc = "Toggle Absolute Line Numbers" })

-- ========================================
-- 🔄 LSP SERVER MANAGEMENT
-- ========================================

-- Tools for restarting/managing LSP servers when things go wrong
-- 🔄 Restart Lua LSP server (Space + l + r)
-- 💡 USEFUL: When Lua LSP acts up or you change config
-- Specifically restarts lua_ls without affecting other language servers
keymap("n", "<leader>lr", "<cmd>LspRestart lua_ls<cr>", {
  noremap = true,
  silent = true,
  desc = "LSP: Restart Lua server",
})

-- 🔄 Restart ALL LSP servers (Space + l + R)
-- 💡 USEFUL: Nuclear option when multiple servers are misbehaving
-- Restarts every LSP server attached to current buffer
-- TO DO: see if I can find another non-shift way to do this
keymap("n", "<leader>lR", "<cmd>LspRestart<cr>", {
  noremap = true,
  silent = true,
  desc = "LSP: Restart all servers",
})

-- 📊 Show LSP server info (Space + l + i)
-- 💡 USEFUL: Debug LSP issues - shows which servers are running
-- Great for troubleshooting when things aren't working
keymap("n", "<leader>li", "<cmd>LspInfo<cr>", {
  noremap = true,
  silent = true,
  desc = "LSP: Show server info",
})

-- 🧹 Clear diagnostic cache (Space + d + r)
-- 💡 USEFUL: For your specific issue with vim global warnings
-- Clears stale diagnostic messages that persist between buffers
keymap("n", "<leader>dr", function()
  vim.diagnostic.reset()
end, {
  noremap = true,
  silent = true,
  desc = "LSP: Clear diagnostic cache",
})

-- ========================================
-- ✨ VISUAL MODE KEYBINDINGS
-- ========================================

-- 📄 Copy selection to system clipboard (⌘C)
keymap("v", "<D-c>", '"+y', {
  noremap = true,
  silent = true,
  desc = "Copy to system clipboard (Cmd+C)",
})

-- ========================================
-- ✍ INSERT MODE KEYBINDINGS
-- ========================================

-- 📋 Paste from clipboard (⌘V)
-- This exits insert mode, pastes, and re-enters insert mode
keymap("i", "<D-v>", '<Esc>"+pa', {
  noremap = true,
  silent = true,
  desc = "Paste from clipboard (Cmd+V)",
})

-- ========================================
-- 🔭 Telescope keymaps
-- ========================================

-- 🧠 Why use `require("telescope.builtin")` inside a function?
-- - This is a lazy load pattern: the require call only runs when the key is pressed.
-- - It prevents errors if Telescope isn't loaded yet during startup.
-- - Ideal for beginner-friendly configs where plugin loading order can vary.

-- 📁 Find files in your project (Space + f + f)
keymap("n", "<leader>ff",
  function() require("telescope.builtin").find_files() end,
  { desc = "Telescope: Find files" }
)

-- 🔍 Grep text live in your project (Space + f + g)
keymap("n", "<leader>fg",
  function() require("telescope.builtin").live_grep() end,
  { desc = "Telescope: Live grep" }
)

-- 📑 Switch between open buffers (Space + f + b)
keymap("n", "<leader>fb",
  function() require("telescope.builtin").buffers() end,
  { desc = "Telescope: List buffers" }
)

-- 📚 Browse Neovim's built-in help docs (Space + f + h)
keymap("n", "<leader>fh",
  function() require("telescope.builtin").help_tags() end,
  { desc = "Telescope: Help tags" }
)

-- ❓ Search all active keybindings (Space + ?)
keymap("n", "<leader>?",
  function() require("telescope.builtin").keymaps() end,
  { desc = "Telescope: 🔍 Search all keymaps"}
)

-- 🔎 Fuzzy find files relative to the current buffer's location (Space + f + c)
vim.keymap.set('n', '<leader>fc', function()
  -- Get the absolute path of the file currently open in the buffer
  local current_file = vim.fn.expand('%:p')

  if current_file == '' then
    -- If no file is open (e.g., a new buffer, help window, etc.),
    -- fallback to using the current working directory
    local cwd = vim.fn.getcwd()
    require('telescope.builtin').find_files({
      cwd = cwd,
      -- ':t' gets just the tail/basename of the path for cleaner title
      prompt_title = "Find Files in " .. vim.fn.fnamemodify(cwd, ':t')
    })
    return
  end

 -- 📂 Extract the directory of the current file)
local current_dir = vim.fn.fnamemodify(current_file, ':h')
  require('telescope.builtin').find_files({
    cwd = current_dir, -- Start search from this directory instead of project root
    prompt_title = "Find Files in " .. vim.fn.fnamemodify(current_dir, ':t'),
    -- Show hidden files in serach (dotfiles like .bashrc, .config/, etc.)
    hidden = true,
    -- But, respect exclude files that are in .gitignore (.env, .DS_Store, etc.)
    respect_gitignore = true
  })
end, { desc = "Find files in current buffer's directory" })

-- Alternative: Live grep in current buffer's directory
vim.keymap.set('n', '<leader>gc', function()
  local current_file = vim.fn.expand('%:p')
  if current_file == '' then
    print("No file in current buffer")
    return
  end
  local current_dir = vim.fn.fnamemodify(current_file, ':h')
  require('telescope.builtin').live_grep({
    cwd = current_dir,
    prompt_title = "Live Grep in " .. vim.fn.fnamemodify(current_dir, ':t')
  })
end, { desc = "Live grep in current buffer's directory" })


keymap("n", "<leader>gt",
  "<cmd>Telescope git_status<cr>",
  { desc = "Git status" })

-- ========================================
-- 🧭 Harpoon 2 Keybindings
-- ========================================

-- Add current file to Harpoon list (Space + a)
keymap("n", "<leader>a",
  function()
    local harpoon = require("harpoon")
    harpoon:list():add()
  end,
  { desc = "Harpoon: Add file" }
)

-- Remove current file from Harpoon list (Space + d)
keymap("n", "<leader>d",
  function()
    require("harpoon"):list():remove()
  end,
  { desc = "Harpoon: Remove current file" }
)

-- Toggle Harpoon menu UI (Space + h)
keymap("n", "<leader>h",
  function()
    local harpoon = require("harpoon")
    harpoon.ui:toggle_quick_menu(harpoon:list())
  end,
  { desc = "Harpoon: Toggle menu" }
)

-- Jump to directly to Harpoon file 1–5 (Space + 1 - 5)
for i = 1, 5 do
  keymap("n", "<leader>" .. i,
    function()
      local harpoon = require("harpoon")
      harpoon:list():select(i)
   end,
   { desc = "Harpoon: Go to file " .. i }
)
end

  -- Go to next Harpoon file (Space + j)
keymap("n", "<leader>j",
  function()
    require("harpoon"):list():next()
  end,
  { desc = "Harpoon: Next file" }
)

-- Go to previous Harpoon file (Space + k)
keymap("n", "<leader>k",
  function()
    require("harpoon"):list():prev()
  end,
  { desc = "Harpoon: Previous file" }
)

-- 🪄 Open Harpoon file in horizontal/vertical splits (Space + oh/ov + 1–5)
for i = 1, 5 do

    -- Horizontal split
    keymap("n", "<leader>oh" .. i, function()
        vim.cmd("split")
        require("harpoon"):list():select(i)
    end, { desc = "Harpoon: Open horizontal split file " .. i })

    -- Vertical split
    keymap("n", "<leader>ov" .. i, function()
        vim.cmd("vsplit")
        require("harpoon"):list():select(i)
    end, { desc = "Harpoon: Open vertical split file " .. i })
end

-- ========================================
-- 🌿 Git Operations with Gitsigns
-- ========================================

-- Navigate between git hunks (changes) --

-- Navigate to next hunk
keymap("n", "<C-j>", function()
  require("gitsigns").next_hunk()
end, { desc = "Next git hunk" })

-- Navigate to previous hunk
keymap("n", "<C-k>", function()
  require("gitsigns").prev_hunk()
end, { desc = "Previous git hunk" })

-- Stage/unstage hunks (chunks) --

-- Stage current hunk (add to commit)
keymap("n", "<leader>gs", function()
  require("gitsigns").stage_hunk()
end, { desc = "Stage hunk" })

-- Undo staging of current hunk (remove from commit)
keymap("n", "<leader>gu", function()
  require("gitsigns").undo_stage_hunk()
end, { desc = "Undo stage hunk" })

-- ⚠️ Reset hunk (permanently delete changes)
keymap("n", "<leader>gr", function()
  require("gitsigns").reset_hunk()
end, { desc = "Reset hunk" })

-- Stage/unstage visual selection --

-- Stage only the visually selected lines
keymap("v", "<leader>gs", function()
  require("gitsigns").stage_hunk({vim.fn.line("."), vim.fn.line("v")})
end, { desc = "Stage selected lines" })

-- Unstage only the visually selected lines
keymap("v", "<leader>gu", function()
  require("gitsigns").undo_stage_hunk({vim.fn.line("."), vim.fn.line("v")})
end, { desc = "Undo stage selected lines" })

-- ⚠️ Reset only the visually selected lines (delete those changes)
keymap("v", "<leader>gr", function()
  require("gitsigns").reset_hunk({vim.fn.line("."), vim.fn.line("v")})
end, { desc = "Reset selected lines" })

-- Stage/reset entire file --

-- Stage all changes in the current file
keymap("n", "<leader>gss", function()
  require("gitsigns").stage_buffer()
end, { desc = "Stage entire file" })

-- ⚠️ Reset all changes in the current file (delete all changes)
keymap("n", "<leader>grr", function()
  require("gitsigns").reset_buffer()
end, { desc = "Reset entire file" })

-- Preview and inspection --

-- Show popup preview of what changed in current hunk
keymap("n", "<leader>gp", function()
  require("gitsigns").preview_hunk()
end, { desc = "Preview hunk" })

-- Show/hide git blame info next to each line
keymap("n", "<leader>gb", function()
  require("gitsigns").toggle_current_line_blame()
end, { desc = "Toggle line blame" })

-- Preview and inspection --

-- Show side-by-side diff of current file vs last commit
keymap("n", "<leader>gd", function()
  require("gitsigns").diffthis()
end, { desc = "Diff this file" })

-- Show/hide git blame info next to each line
keymap("n", "<leader>gdc", function()
  require("gitsigns").diffthis("~")
end, { desc = "Diff this file (cached)" })

-- ========================================
-- 🗒️ Scratch Buffer Operations
-- ========================================
-- Function to create a scratch Lua buffer in vertical split
local function create_scratch_lua_buffer()
  -- Create vertical split
  vim.cmd('vsplit')

  -- Create new buffer
  local buf = vim.api.nvim_create_buf(false, true)

  -- Set buffer to current window
  vim.api.nvim_win_set_buf(0, buf)

  -- Set filetype to lua
  vim.api.nvim_buf_set_option(buf, 'filetype', 'lua')

  -- Set buffer as scratch (no file associated)
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'hide')
  vim.api.nvim_buf_set_option(buf, 'swapfile', false)

  -- Optional: Set a buffer name
  vim.api.nvim_buf_set_name(buf, 'scratch.lua')

  -- Optional: Add some initial content
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
    '-- Scratch Lua buffer',
    '',
    ''
  })

  -- Move cursor to end
  vim.api.nvim_win_set_cursor(0, {3, 0})
end

-- Create the keymap (using <leader>sl for "scratch lua")
vim.keymap.set('n', '<leader>sl', create_scratch_lua_buffer, {
  desc = 'Create scratch Lua buffer in vertical split',
  noremap = true,
  silent = true
})
