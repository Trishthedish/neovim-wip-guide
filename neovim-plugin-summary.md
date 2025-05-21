# 🔌 Neovim Plugin Summary

### Plugin Summary in table form

| Plugin                      | Purpose                            | Keymaps (if any)                   |
| --------------------------- | ---------------------------------- | ---------------------------------- |
| `lualine.nvim`              | Fancy statusline at bottom         | No default, but auto-displays      |
| `tokyonight.nvim`           | Gorgeous color theme               | N/A                                |
| `nvim-web-devicons`         | Filetype icons (for UI niceness)   | N/A                                |
| `telescope.nvim`            | Fuzzy finder + search power        | Usually `<leader>ff`, etc.         |
| `nvim-lspconfig`            | Built-in LSP support               | Depends on LSP setup               |
| `nvim-cmp` + `cmp-nvim-lsp` | Autocompletion powered by LSP      | Usually triggered automatically    |
| `LuaSnip`                   | Snippet support for completions    | Usually `<Tab>` / `<C-j>`          |
| `gitsigns.nvim`             | Git blame, signs, and inline hunks | `]c`, `[c`, `:Gitsigns` commands   |
| `which-key.nvim`            | Help popup for keybindings         | Auto-shows when you hit `<leader>` |

----

# An annotated breakdown of every plugin in my plugins.lua file.
Includes short descriptions, purpose, and key usage notes so I can easily find and remember what does what.

list of plugins in my `plugins.lua` for `lazy.nvim` 💖


## 🎨 UI & Appearance

### 🌈 [`folke/tokyonight.nvim`](https://github.com/folke/tokyonight.nvim)
A beautiful and soothing colorscheme inspired by Tokyo nightscapes.
✅ Loads first for instant vibes.
🛠 Use: `vim.cmd.colorscheme("tokyonight")`

---

### 🧾 [`nvim-lualine/lualine.nvim`](https://github.com/nvim-lualine/lualine.nvim)
A flexible and fancy statusline. Looks great, shows mode, file info, git branch, etc.
🛠 No keymaps; just enjoy the vibe at the bottom of your screen.
🔧 Configured in `plugins.lua` with `require("lualine").setup()`.

---

### 🧸 [`kyazdani42/nvim-web-devicons`](https://github.com/nvim-tree/nvim-web-devicons)
Adds pretty icons to your file explorer, statusline, and more.
🎉 No setup needed if other plugins use it.

---

## 🔍 Navigation & Search

### 🔭 [`nvim-telescope/telescope.nvim`](https://github.com/nvim-telescope/telescope.nvim)
**What it does**: Fuzzy finder to rule them all — files, text, buffers, git stuff.
Adds powerful fuzzy finding for files, text, buffers, help, and more -- all through
slick, interactive popups.

**Why I use it**: It's fast, extensible, and super beginner friendly.

**Setup**:
- 🧠 Depends on `plenary.nvim`.

💡 Common keymaps (not included by default, but often added):
- `<leader>ff`: Find files
- `<leader>fg`: Live grep
- `<leader>fb`: List buffers

- Config lives: `plugins.lua`, using:
```
require("telescope").setup()
```
---

## 🧠 LSP & Autocompletion

### 🧠 [`neovim/nvim-lspconfig`](https://github.com/neovim/nvim-lspconfig)

Enables LSP (language server protocol) support. Powers autocomplete, diagnostics, go-to-def, etc.
🛠 You’ll still need to configure individual servers (`lua_ls`, `tsserver`, etc).

---

### ✨ [`hrsh7th/nvim-cmp`](https://github.com/hrsh7th/nvim-cmp)

Autocompletion engine — works with LSP, buffer, path, etc.
🧩 You’ve also included:
- `cmp-nvim-lsp`: Completion source for LSP
- `LuaSnip`: Snippet engine used in completions

Keymap idea (usually in your `keymaps.lua`):
- `<Tab>` / `<S-Tab>` to jump between completion items
- `<C-Space>` to trigger completion manually

---

### 🧠 [`L3MON4D3/LuaSnip`](https://github.com/L3MON4D3/LuaSnip)

Powerful snippet engine. Needed for `nvim-cmp` to expand things like:
`func => function(...) ... end`

🛠 Optional custom snippets and keybindings:

`vim.keymap.set({"i", "s"}, "<C-j>", function() ls.jump(1) end)`

---

## 🧰 Git Integration

### 🧩 [`lewis6991/gitsigns.nvim`](https://github.com/lewis6991/gitsigns.nvim)

Inline git hunks, blame info, and signs in the gutter.
🔍 Helpful keymaps (if enabled):

- `]c` / `[c` to jump between hunks
- `<leader>gb` for blame
- `<leader>gr` to reset hunk

Configured via:
```
require("gitsigns").setup()
```

---
## 🛠 Utilities

### ❓ [`folke/which-key.nvim`](https://github.com/folke/which-key.nvim)

Ever forget your own keybindings? Which-Key to the rescue!
Pops up a little menu when you press `<leader>`, showing what’s available next.

🛠 Setup with:
```
require("which-key").setup()
```
No default keymaps required — it listens automatically.

---

##  🧼 Formatting

### 🪄 [`stevearc/conform.nvim`](https://github.com/stevearc/conform.nvim)
**What it does**: lightweight formatter plugin that runs external formatters like `black`, `prettier`, etc.

**Why I use it**: It’s dead simple, fast, and doesn’t mess with LSP formatting. It gives me full control.

💡 Typical behavior:
- Autoformats on save
- Can be triggered manually too

**Setup**:
```lua
-- lua/trish/plugins.lua
{
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 500,
      },
      formatters_by_ft = {
        python = { "black" }, -- Add more as needed
      },
    })
  end,
}
```

### [`black`](https://black.readthedocs.io/en/stable/#) — Python’s opinionated formatter 🐍
**What it does**: Reformats Python files to match a consistent style guide — great for keeping things clean and readable.

🧠 **Why we use it**: It enforces standards automatically. It’s fast, unambiguous, and basically the standard in Pythonland.

⚙️ **Install it** globally or in your venv:
```sh
pip install black
```

---

## ✅ Final Notes

- All plugins are **lazy-loaded** unless marked `lazy = false`

- You can group keymaps in `keymaps.lua` and annotate them with comments for each plugin