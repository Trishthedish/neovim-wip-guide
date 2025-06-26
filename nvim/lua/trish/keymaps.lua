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

-- Show/hide git blame info next to eachdd line
keymap("n", "<leader>gdc", function()
  require("gitsigns").diffthis("~")
end, { desc = "Diff this file (cached)" })
