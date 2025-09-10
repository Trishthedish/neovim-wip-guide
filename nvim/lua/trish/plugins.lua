-- Return a table of plugin definitions for lazy.nvim to install and configure
return {

-- ┌────────────────────────────────────┐
-- │ 🎨 UI & Appearance                 │
-- └────────────────────────────────────┘
-- Displays hex codes as actual colors with background highlighting
-- (e.g. #ffd700 shows with golden yellow background)
{
  "norcalli/nvim-colorizer.lua",
  lazy = false,
  config = function()
    require("colorizer").setup()
  end,
},

-- Lualine: Configurable statusline featuring Git
-- integration, LSP diagnostics, and file indicators
{
  "nvim-lualine/lualine.nvim", -- Statusline at the bottom
  config = function()
    require("lualine").setup({
    options = {
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = true, -- single statusline for all splits, reflects current window
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      }
    },
    sections = {
      -- left side
      lualine_a = {'mode'},
      lualine_b = {
        'branch',
        { function() return "" end }, -- Github icon
        {
          'diff',
           colored = true,
           symbols = {
             added = "🌱",
             modified = "🔧 ",
             removed = "🗑️ ",
           }
        },
      },
        -- Center (filename)
        lualine_c = {
          {
            'filename',
            file_status = true,    -- Shows [+] for modified, [-] for readonly
            path = 1,              -- Show relative path
            symbols = {
              modified = '[+]',
              readonly = '[-]',
              unnamed = '[No Name]',
            }
          }
        },
        -- Right side
        lualine_x = {
          {
            'diagnostics',
            sources = { 'nvim_lsp' },
            symbols = {error = '  ', warn = '  ', info = '  ', hint = '  '},
          },
          'filetype'  -- This shows language with icon (lua , js , py  etc.)
        },
        lualine_y = {'progress'},
        lualine_z = {'location'}, -- 👈 shows line:column
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
		lualine_c = { 'filename' },
		lualine_x = {},
		lualine_y = {},
		lualine_z = { 'location' }, -- 👈 ensures inactive windows also show column
      },
    })
  end,
},

{
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl", -- uses the modern module name
  ---@module "ibl" -- (optional) tells Lazy to use the "ibl" module instead of default
  lazy = false,
  config = function()
    require("plugins.indent_blankline") --- importing custom plugin file.
  end,
},

-- colorful-winsep.nvim: Enhances Neovim's window separators with colorful,
-- visually distinct lines. Improves split visibility by highlighting active
-- and inactive windows differently.
{
  "nvim-zh/colorful-winsep.nvim",
  config = true,
  event = { "WinLeave" },
},

-- nvim-ufo: Modern, high-performance folding for Neovim
{
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  config = function()
      -- Fold column like VSCode gutter arrows
      vim.o.foldcolumn = "1" -- Show fold column (like VSCode gutter arrows)
      -- Expand all folds by default
      vim.o.foldlevel = 99 -- Expand all folds by default
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      -- Use expression-based folding with UFO
      vim.o.foldmethod = "expr"
      vim.o.foldexpr = "v:lua.require'ufo'.foldexpr()"

      -- UFO setup
      local ufo = require("ufo")

      ufo.setup({
        provider_selector = function(bufnr, filetype, buftype)
          -- Use treesitter first, fallback to indent
          return { "treesitter", "indent" }
        end,

        -- Virtual text handler: show method signatures or summary
        -- for folded code
        fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
          local newVirtText = {}
          local suffix = (" ... [%d lines]"):format(endLnum - lnum)
          local sufWidth = vim.fn.strdisplaywidth(suffix)
          local targetWidth = width - sufWidth
          local curWidth = 0

          for _, chunk in ipairs(virtText) do
              local chunkText = chunk[1]
              local chunkWidth = vim.fn.strdisplaywidth(chunkText)
              if curWidth + chunkWidth <= targetWidth then
                  table.insert(newVirtText, chunk)
                  curWidth = curWidth + chunkWidth
              else
                  chunkText = vim.fn.strcharpart(chunkText, 0, targetWidth - curWidth)
                  table.insert(newVirtText, { chunkText, chunk[2] })
                  curWidth = curWidth + vim.fn.strdisplaywidth(chunkText)
                  break
              end
          end

          table.insert(newVirtText, { suffix, "MoreMsg" })
          return newVirtText
        end,
      })
   end,
},

-- ╭──────────────────────────────╮
-- │ 🌈  List of Color Schemes    │
-- ╰──────────────────────────────╯

-- Tokyo Night: Modern dark theme with vibrant colors
{
  "folke/tokyonight.nvim", -- Tokyo Night: Modern dark theme with vibrant colors
  -- Plugin loading behavior
  lazy = false,    -- Load immediately during startup (not lazy-loaded)
  priority = 1000, -- High priority ensures colorscheme loads before other plugins

  config = function()
    -- Configure Tokyo Night theme customizations
    require("tokyonight").setup({
      on_highlights = function(hl)

        -- Customize cursor line appearance
        hl.CursorLine = {
          bg = "#2d3149", -- a subtle bluish background for the cursor line
          fg = "NONE",   -- Keep default text color (commented out)
        }

        -- Enhance comment visibility and styling
        hl.Comment = {
          fg = "#8888aa", -- Custom blue-gray color (brighter than default)
          italic = true,  -- Make comments italic for better distinction
        }
      end,
    })

    -- Apply the colorscheme after configuration
    vim.cmd.colorscheme("tokyonight")
  end,
},

-- Lytmode: A high-contrast, minimalist dark theme with
-- a cool cyberpunk/terminal aesthetic
{
  "github-main-user/lytmode.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require('lytmode').setup()
  end
},

-- Catppuccin: Soothing, Stylish, and Pastel-Perfect
{
  "catppuccin/nvim",
   lazy = false,
   name = "catppuccin",
   priority = 1000,
},

-- Onedark: A moody and modern dark theme
{
  "navarasu/onedark.nvim",
  lazy = false,
  priority = 1000,
},

-- Cyberdream: A high-tech neon cyberpunk theme
{
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("cyberdream").setup({
      theme = "dark", -- or "light" if you prefer
      transparent = false, -- or true if you want transparent bg
    })
  end,
},

-- File type icons for enhanced visual file identification
{
  "kyazdani42/nvim-web-devicons",
  lazy = true,
},

{
  -- ✨ nvim-autopairs auto-inserts matching brackets, quotes
  -- and parentheses as you type — just like VS Code.
  -- Smart, simple, and integrates well with completions.
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    require("nvim-autopairs").setup({
      check_ts = true,        -- ✅ enables Treesitter checks for better context awareness (smart pairing in quotes/strings)
      enable_check_bracket_line = false, -- 🚫 disables strict "same line" bracket pairing
      disable_filetype = { "TelescopePrompt", "vim" }, -- 🙅 avoids pairing in Telescope or Vimscript files
      ignored_next_char = "[%w%.]", -- ❌ won't add closing pair if the next character is a word character or period
    })
  end,
},
-- ┌────────────────────────────────────┐
-- │ 🔍 Navigation & Search             │
-- └────────────────────────────────────┘
{
  "nvim-telescope/telescope.nvim", -- Fuzzy finder and file search
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").setup({
      extensions = {
        -- Optional: No extra config needed for colorscheme preview,
        -- but this ensures correct defaults
        cheatsheet = {}, -- Add this line to load it with default settings
      },
      pickers = {
        colorscheme = {
          enable_preview = true, -- <-- this line enables live preview...
          layout_config = {
            height = 0.4,
            width = 0.4,
            prompt_position = "top",
          },
          layout_strategy = "center",
        },
      }
    })

    -- 🔑 This is the *correct* place to load the extensions
    require("telescope").load_extension("cheatsheet")
  end,
},

  -- Recall: refines the use of neovim marks. By focusing on global marks,
  -- streamlining their usuage and enhancing their visibility and navigability.
{
  "fnune/recall.nvim",
  version = "*",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("recall").setup({
      telescope = { autoload = true },  -- Automatically load Telescope extension
    })
  end,
},

-- oil.nvim - A modern, minimal file manager that opens directories as editable buffers.
-- Lets you navigate, create, rename, and delete files or folders right from a buffer.
-- Great alternative to bulky tree UIs – stays close to native Neovim workflows.
{
  "stevearc/oil.nvim",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
  config = function(_, opts)
    require("oil").setup(opts)
    -- ensure netrw is *disabled* so it doesn't take over the '-' key
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
},

-- ┌────────────────────────────────────┐
-- │ 🧠 LSP                             │
-- └────────────────────────────────────┘

-- Mason: The package manager for LSP servers, DAP adapters, linters & formatters
-- This is the core plugin that handles downloading and installing language tools
-- Think of it like a "homebrew" but specifically for Neovim development tools
{
  "williamboman/mason.nvim",
  priority = 1000, -- Load first
  config = function()
    require("mason").setup()
  end,
},

-- LSPConfig: The actual LSP configuration plugin (your existing setup)
-- This handles the communication between Neovim and language servers
-- Mason installs the servers, mason-lspconfig bridges them, and this configures them
{
  "neovim/nvim-lspconfig",
  dependencies = { "mason-lspconfig.nvim" },
  priority = 998, -- Load last
  config = function()
    -- load master LSP configuration
    require("trish.lsp.init")
  end,
},

-- ┌────────────────────────────────────┐
-- │ 📚 Syntax & Treesitter             │
-- └────────────────────────────────────┘
{
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate", -- Automatically update parsers when installing
  lazy = false, -- Load at startup
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "lua",
        "python",
        "bash",
        "markdown",
        "markdown_inline",
        "json",
        "yaml",
        "html",
        "css",
        "javascript",
        "typescript",
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    })
  end,
},

-- ┌────────────────────────────────────┐
-- │ 🤖 Autocompletion                  │
-- └────────────────────────────────────┘
{
  "hrsh7th/nvim-cmp", -- Completion plugin (shows suggestions as you type)
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- Completion from LSP
    {
      "L3MON4D3/LuaSnip", -- Snippet engine
      version = "v2.*", -- Follow latest v2 release
      build = "make install_jsregexp", -- This will install jsregexp automatically
      config = function()
        -- Load your custom Lua snippets
        require("luasnip.loaders.from_lua").load({
          paths = "~/.config/nvim/lua/trish/snippets"
        })
      end,
    },
  },
  config = function()
    -- nvim-cmp = "completion engine" - handles autocomplete suggestions
    -- luasnip = "snippet engine" - handles snippet expansion and navigation
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    cmp.setup({
      -- 📝 SNIPPET EXPANSION: How to turn snippet text into actual code
      snippet = {
        expand = function(args)
          -- When user selects a snippet from completion menu,
          -- hand the snippet body to LuaSnip to expand it
          luasnip.lsp_expand(args.body)
        end,
      },
      -- ⌨️ KEYMAPS: What keys do what during completion
      mapping = cmp.mapping.preset.insert({
        -- 📖 Documentation scrolling (when completion docs are visible)
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),  -- (Ctrl + b): Scroll up in docs
        ["<C-f>"] = cmp.mapping.scroll_docs(4),   -- (Ctrl + f): Scroll down in docs

        -- 🔍 Completion control
        ["<C-Space>"] = cmp.mapping.complete(), -- (Ctrl + Space): Force show completions
        ["<C-e>"] = cmp.mapping.abort(),        -- (Ctrl + e): Close completion menu
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- (Enter): Accept current selection

        -- 🎯 SMART TAB: The key that makes snippets work!
        -- Tab does different things depending on what's happening:
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- Completion menu is open → navigate to next suggestion
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            -- Can expand a snippet (like "leet") OR jump to next placeholder → do it
            luasnip.expand_or_jump()
          else
            -- Nothing special happening → just insert a normal tab
            fallback()
          end
        end, { "i", "s" }), -- Works in insert mode ("i") and select mode ("s")

        -- 🔄 SHIFT-TAB: Reverse navigatin
        --  Move backward through snippet placeholders (or previous autocomplete item)
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- Completion menu is open → navigate to previous suggestion
            cmp.select_previous_item()
          elseif luasnip.jumpable(-1) then
            -- Can jump to previous snippet placeholder → do it
            luasnip.jump(-1)
          else
            -- Nothing special → normal Shift-Tab behavior
            fallback()
          end
        end, { "i", "s" }),

        -- 🔁 Reload Luasnp snippets without restarting Neovim.
        -- Run `:ReloadSnippets` after editing snippets in
        -- ~/.config/nvim/lua/trish/snippets
        vim.api.nvim_create_user_command("ReloadSnippets", function()
        require("luasnip.loaders.from_lua").load({
          paths = "~/.config/nvim/lua/trish/snippets",
        })
        print("🔁 LuaSnip snippets reloaded!")
        end, {})
      }),

      -- 🔍 COMPLETION SOURCES: Where do suggestions come from?
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- For snippets
      }),
    })
  end,
},

-- ┌────────────────────────────────────┐
-- │ 🧰 Git Integration                 │
-- └────────────────────────────────────┘
{
  "lewis6991/gitsigns.nvim", -- Show git changes in the sign column
  config = function()
    require("gitsigns").setup({
      attach_to_untracked = true,
      signs = {
        add = { text = "█"},
        change = { text = "█" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        map("n", "<leader>gp", gs.preview_hunk, "Preview git hunk")
        map("n", "<leader>gb", gs.toggle_current_line_blame, "Toggle git line blame")
      end,
    })


    -- Set VS Code-like git diff colors
    -- These colors match VS Code's default git gutter colors
    vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#28a745" })          -- Green for additions
    vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#ffa500" })       -- Orange for changes
    vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#d73a49" })       -- Red for deletions
    vim.api.nvim_set_hl(0, "GitSignsTopdelete", { fg = "#d73a49" })    -- Red for top deletions
    vim.api.nvim_set_hl(0, "GitSignsChangedelete", { fg = "#ffa500" }) -- Orange for change+delete

    -- Optional: Set background colors for line highlighting (when you navigate to hunks)
    vim.api.nvim_set_hl(0, "GitSignsAddLn", { bg = "#e6ffed" })      -- Light green background
    vim.api.nvim_set_hl(0, "GitSignsChangeLn", { bg = "#fff8e1" })   -- Light orange background
    vim.api.nvim_set_hl(0, "GitSignsDeleteLn", { bg = "#ffeef0" })   -- Light red background

    -- Optional: Inline word diff colors (for preview_hunk)
    vim.api.nvim_set_hl(0, "GitSignsAddInline", { bg = "#acf2bd" })    -- Light green highlight for added words/chars
    vim.api.nvim_set_hl(0, "GitSignsDeleteInline", { bg = "#fdb8c0" }) -- Light red highlight for deleted words/chars
    vim.api.nvim_set_hl(0, "GitSignsChangeInline", { bg = "#ffe4b3" }) -- Light orange highlight for changed words/chars

     -- Override diff colors for preview window to match VS Code
    vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#e6ffed", fg = "#28a745" })
    vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#ffeef0", fg = "#d73a49" })
    vim.api.nvim_set_hl(0, "DiffChange", { bg = "#fff8e1", fg = "#ffa500" })
    vim.api.nvim_set_hl(0, "DiffText", { bg = "#ffe4b3", fg = "#ffa500", bold = true })
  end,
},

-- ┌────────────────────────────────────┐
-- │ 🔧 Utilities                       │
-- └────────────────────────────────────┘
{
  "folke/which-key.nvim",
   event = "VeryLazy",
   opts = {
    presets = "modern",
    plugins = {spelling = {enabled = true} },
    win = { border = "rounded", title = true, },
  },
},

-- Obsidian.nvim: Seamless integration between Neovim and Obsidian.md vaults
-- Provides note creation, linking, search, and markdown editing features
-- Enables working with Obsidian notes directly from Neovim with vault awareness
{
  "epwalsh/obsidian.nvim",
  version = "*",  -- Use latest stable release
  lazy = true,
  event = {
    "BufReadPre /Users/trish/Library/Mobile\\ Documents/iCloud~md~obsidian/Documents/MasterVault/*.md",
    "BufNewFile /Users/trish/Library/Mobile\\ Documents/iCloud~md~obsidian/Documents/MasterVault/*.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "MasterWorkspace",
        path = "/Users/trish/Library/Mobile Documents/iCloud~md~obsidian/Documents/MasterVault",
      },
    },
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
    new_notes_location = "current_dir", -- Create new notes in current dir
    open_notes_in = "vsplit", -- Open links in a vertical split

    -- Disable all default mappings (you can define your own)
    mappings = {},
    ui = {
      enable = true,
      update_debounce = 200,
    },
  },
},

-- 🧠 vim-coach.nvim: Your personal Vim coach!
-- A comprehensive, beginner-friendly command reference for Neovim.
-- This plugin offers an interactive, searchable guide to Vim/Neovim commands,
-- complete with detailed explanations, helpful tips, and context-aware suggestions.
{
  "shahshlok/vim-coach.nvim",
  dependencies = {
    "folke/snacks.nvim",
  },
  config = function()
    require("vim-coach").setup()
  end,
},

-- Cheatsheet.nvim: 🧾 Interactive reference for keymaps, Lua APIs, and plugin commands
-- Launch via `:Cheatsheet` or Telescope (`<leader>cc`) to search across docs
{
  "doctorfree/cheatsheet.nvim",
  event = "VeryLazy",
  dependencies = {
    { "nvim-telescope/telescope.nvim" },
    { "nvim-lua/popup.nvim" },
    { "nvim-lua/plenary.nvim" },
  },
  config = function()
    local ctactions = require("cheatsheet.telescope.actions")
    require("cheatsheet").setup({
      bundled_cheatsheets = {
        enabled = { "default", "lua", "markdown", "regex" },
        disabled = { "nerd-fonts", "netrw", "unicode" },
      },
      bundled_plugin_cheatsheets = {
        enabled = { "telescope.nvim", "gitsigns" },
      },
      include_only_installed_plugins = true,
      telescope_mappings = {

        -- Fills the command line with cheat value (enter)
        -- If cheat is a command
        ["<CR>"] = ctactions.select_or_fill_commandline,

        -- Select or execute command immedately (alt + enter)
        ["<A-CR>"] = ctactions.select_or_execute,

        -- Copies the "cheat value" to your system clipboard (ctrl + y )
        ["<C-Y>"] = ctactions.copy_cheat_value,

        -- Opens your *user cheatsheet* file for editing (ctrl + e)
        ["<C-E>"] = ctactions.edit_user_cheatsheet,
      },
    })
  end,
},

-- ✂️ Guard: Async-first formatter + linter runner for Neovim 0.10+
-- A lightweight, LSP-free alternative to tools like conform/null-ls
-- ideal for scripting languages like bash. Chosen for its modular API
-- and speed; planning to build a an on-demand custom Bash autoformatter
-- via keymap
{
  "nvimdev/guard.nvim",
  dependencies = { "nvimdev/guard-collection" },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
  -- These are your intended opts
  vim.g.guard_config = {
    fmt_on_save = false,
    lsp_as_default_formatter = false,
    save_on_fmt = true,
    auto_lint = true,
    lint_interval = 500,
    refresh_diagnostic = true,
  }

  -- Make sure this is  on a new line, not after
  -- the table literal without separator
  local ft = require("guard.filetype")

  -- Bash conditional Formatter (shfmt)
  if vim.fn.executable("shfmt") == 1 then
    -- Bash formatter
    ft("sh"):fmt("shfmt")
  else
    vim.notify(
      "[guard.nvim] 'shfmt' not found in PATH — Bash formatting disabled",
      vim.log.levels.WARN
    )
  end

  -- Lua conditional Formatter (stylua)
  if vim.fn.executable("stylua") == 1 then
    -- Lua Formatter
    ft("lua"):fmt("stylua")
  else
    vim.notify(
      "[guard.nvim] 'styula' not found in PATH - Lua formatting disabled",
      vim.log.levels.WARN
    )
  end
end,
},

-- 🎹 key-analyzer.nvim
-- Visualizes your used and unused keys on a QWERTY keyboard layout.
-- Lazy-loads and shows key heatmaps to help optimize your Neovim mappings.
{
  "meznaric/key-analyzer.nvim",
  event = "VeryLazy",
  opts = {
    command_name = "KeyAnalyzer",
    highlights = {
      bracket_used = "KeyAnalyzerBracketUsed",
      letter_used = "KeyAnalyzerLetterUsed",
      bracket_unused = "KeyAnalyzerBracketUnused",
      letter_unused = "KeyAnalyzerLetterUnused",
      promo_highlight = "KeyAnalyzerPromo",
      define_default_highlights = true,
    },
    layout = "qwerty",
  },
},

-- ┌────────────────────────────────────┐
-- │ 🏋️ Practice & Training              │
-- └────────────────────────────────────┘

-- VimBeGood:
{
  "ThePrimeagen/vim-be-good",
  cmd = "VimBeGood", -- Lazy-load only when this command is used
  event = "VeryLazy", -- Optional: load on low-priority event
  config = function() -- Attempting to add persistent stats from game play
      vim.g.vim_be_good_save_statistics = true
  end,
},

-- ┌────────────────────────────────────┐
-- │ 🍿 Snacks (Multi-purpose Utils)    │
-- └────────────────────────────────────┘
-- Snacks.nvim: A collection of small QoL (Quality of Life) plugins by folke
-- Starting with dashboard only - can expand to include notifications,
-- status indicators, file utilities, and performance optimizations
{
 "folke/snacks.nvim",
 priority = 1000,
 lazy = false,
 config = function()
   require("snacks").setup({
     bigfile = { enabled = false },
     notifier = { enabled = false },
     quickfile = { enabled = false },
     statuscolumn = { enabled = false },
     words = { enabled = false },

     -- Focus on dashboard only
     dashboard = {
       enabled = true,
       sections = {
         {
            section = "header",
            padding = 2
         },
         { section = "keys", gap = 1, padding = 1 },
         { section = "startup" },
       },
     },
   })
   -- load your custom snacks
   require("trish.snacks_states").setup()
 end,
},

}
