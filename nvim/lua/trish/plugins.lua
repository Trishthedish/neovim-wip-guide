-- Return a table of plugin definitions for lazy.nvim to install and configure
return {

-- ┌────────────────────────────────────┐
-- │ 🎨 UI & Appearance                 │
-- └────────────────────────────────────┘
{
  "nvim-lualine/lualine.nvim", -- Statusline at the bottom
  config = function()
    require("lualine").setup()
  end,
},

{
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl", -- uses the modern module name
  ---@module "ibl" -- (optional) tells Lazy to use the "ibl" module instead of default
  ---@type ibl.config -- (optional hint for Lua LSP, more on this below)
  config = function()
    local opts = {
      indent = {
        char = "┊", -- or "▏", "⎸", "┊"
        highlight = {
          "RainbowRed",
          "RainbowYellow",
          "RainbowBlue",
          "RainbowOrange",
          "RainbowGreen",
          "RainbowViolet",
          "RainbowCyan",
        },
      },
      whitespace = {
        remove_blankline_trail = false, --keep trailing whitespace visible
      },
      exclude = {
        filetypes = {
          "help",
          "dashboard",
          "NvimTree",
          "lazy",
          "mason",
          "lualine"
        }
      },
      scope = {
        enabled = false,
      },
    }

    -- 🌈 Define the custom highlights
    vim.api.nvim_set_hl(0, "RainbowRed",    { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue",   { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen",  { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan",   { fg = "#56B6C2" })

    -- 🧽 Define highlight group used by autocmds
    vim.api.nvim_set_hl(0, "ExtraWhitespace", { bg = "#FF00FF" })

    -- ✅ Finally call setup just once
    require("ibl").setup(opts)
  end,
},

{
  "folke/tokyonight.nvim", -- Beautiful color theme
  lazy = false, -- Load immediately at startup
  priority = 1000, -- Load before anything else
  config = function()
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
-- │ 🧼 Formatting                      │
-- └────────────────────────────────────┘
{
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 500,
      },
      formatters_by_ft = {
        python = { "black" },
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

        -- 🔄 SHIFT-TAB: Reverse navigation
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
    require("gitsigns").setup()
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
