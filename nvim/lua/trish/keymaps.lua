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

-- 🗂 Open file explorer (Space + E)
keymap("n", "<leader>e", ":Ex<CR>", {
  desc = "Open file explorer",
})

-- 💾 Save file (Space + W)
keymap("n", "<leader>w", ":w<CR>", {
  desc = "Save file",
})

-- 💾 Save file (⌘S)
-- 🧠 Why do I have *two* save keymaps?
-- - <leader>w is universal: Works on any system, any keyboard layout, even in terminal-only environments (like my VM).
-- - <D-s> is macOS-specific: Lets me use familiar ⌘S muscle memory when editing locally on my Mac.
-- - Both do the same thing: save the file!
-- ✅ This setup lets me keep my habits (⌘S) *and* stay portable (Space + W) across systems.
keymap("n", "<D-s>", ":w<CR>", {
  noremap = true,
  silent = true,
  desc = "Save file (Cmd+S)",
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

-- 📄 Copy current line (⌘C) in normal mode
keymap("n", "<D-c>", '"+yy', {
  noremap = true,
  silent = true,
  desc = "Copy current line (Cmd+C)",
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
  function() require("builtin.buffers").buffers() end,
  { desc = "Telescope: List buffers" }
)

-- 📚 Browse Neovim's built-in help docs (Space + f + h)
keymap("n", "<leader>fh",
  function() require("builtin.help_tags").help_tags() end,
  { desc = "Telescope: Help tags" }
)