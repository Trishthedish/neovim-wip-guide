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
      globalstatus = false,
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
        {
          'diff',
           colored = true,
           symbols = {
             added = " ",
             modified = " ",
             removed = " ",
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
            symbols = {error = '', warn = '', info = '', hint = ''},
          },
          'filetype'  -- This shows language with icon (lua , js , py  etc.)
        },
        lualine_y = {'progress'},
        lualine_z = {'location'}
      }
    })
  end,
},

{
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl", -- uses the modern module name
  ---@module "ibl" -- (optional) tells Lazy to use the "ibl" module instead of default
  lazy = false,
},

{
  "folke/tokyonight.nvim", -- Tokyo Night: Modern dark theme with vibrant colors
  -- Plugin loading behavior
  lazy = false,    -- Load immediately during startup (not lazy-loaded)
  priority = 1000, -- High priority ensures colorscheme loads before other plugins

  config = function()
    -- Configure Tokyo Night theme customizations
    require("tokyonight").setup({
      on_highlights = function(hl, c)
        -- Customize cursor line appearance
        hl.CursorLine = {
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

{
  "kyazdani42/nvim-web-devicons", -- Adds icons for file types
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
    require("telescope").setup()
  end,
},

  -- Harpoon (by ThePrimeagen) is a fast file marking and navigation plugin.
  -- It lets you mark frequently-used files and quickly jump between them,
  -- providing a lightweight, persistent workspace feel inside Neovim.
{
  "ThePrimeagen/harpoon",
  branch = "harpoon2", -- optional: only if you want the newer version
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("harpoon").setup({
      settings = {
        save_on_toggle = true, -- auto-save your list when opening
        sync_on_ui_close = true, -- auto-sync when closing UI
      },
      ui = {
        -- this controls how each item is shown in the quick menu
        transform_fn = function(item)
          return item.label and item.label .. " → " .. item.value or item.value
        end,
      },
    })
  end,
},

-- ┌────────────────────────────────────┐
-- │ 🧠 LSP                             │
-- └────────────────────────────────────┘
{
  "neovim/nvim-lspconfig", -- Collection of LSP configs
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
          paths = "~/.config/nvim/trish/snippets",
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
}
