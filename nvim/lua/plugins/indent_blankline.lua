-- ~/.config/nvim/plugins/indent_blankline.lua

local M = {}

M.current_mode = 1
M.mode_names = {"gray_simple","rainbow_dashed", "rainbow_continuous"}

-- Define the three configuration modes
M.configs = {

    -- Gray Simple
    gray_simple = {
      indent = {
        char = "│",  -- simple gray line
        highlight = {
          "IndentBlanklineChar"
        },
      },
      whitespace = {
        remove_blankline_trail = false, -- keep trailing whitespace visible
      },
      exclude = {
        filetypes = {
          "help", "dashboard", "NvimTree", "lazy", "lualine", "mason",
          "snacks", "snacks_dashboard"
        }
      },
      scope = {
        enabled = false,
      },
    },

    -- Rainbow Dashed
    rainbow_dashed = {
      indent = {
        char = "┊",
        highlight = {
          "RainbowRed", "RainbowYellow", "RainbowBlue",
          "RainbowOrange", "RainbowGreen", "RainbowViolet", "RainbowCyan"
        },
      },
      whitespace = {
        remove_blankline_trail = false -- keep trailing whitespace visible
      },
      exclude = {
        filetypes = {
          "help", "dashboard", "NvimTree", "lazy", "lualine",
          "mason", "snacks", "snacks_dashboard"
        }
      },
      scope = {
        enabled = false,
      },
    },

    -- Rainbow continuous
    rainbow_continuous = {
      indent = {
        char = "▏",  -- continuous full column character
        highlight = {
          "RainbowRedMuted", "RainbowYellowMuted", "RainbowBlueMuted",
          "RainbowOrangeMuted", "RainbowGreenMuted", "RainbowVioletMuted",
          "RainbowCyanMuted"
        },
      },
      whitespace = {
        remove_blankline_trail = false, -- keep trailing whitespace visible
      },
      exclude = {
        filetypes = {
          "help", "dashboard", "NvimTree", "lazy", "lualine", "mason",
          "snacks", "snacks_dashboard"
        }
      },
      scope = {
        enabled = false,
      },
    }
}

-- 🌈 Highlight setup (now a method)
function M.setup_highlights()
  local hl = vim.api.nvim_set_hl

  -- Bright rainbow
  hl(0, "RainbowRed",    { fg = "#E06C75" })
  hl(0, "RainbowYellow", { fg = "#E5C07B" })
  hl(0, "RainbowBlue",   { fg = "#61AFEF" })
  hl(0, "RainbowOrange", { fg = "#D19A66" })
  hl(0, "RainbowGreen",  { fg = "#98C379" })
  hl(0, "RainbowViolet", { fg = "#C678DD" })
  hl(0, "RainbowCyan",   { fg = "#56B6C2" })

  -- Muted rainbow highlights
  hl(0, "RainbowRedMuted",    { fg = "#D99A9A" })
  hl(0, "RainbowOrangeMuted", { fg = "#E6A87A" })
  hl(0, "RainbowYellowMuted", { fg = "#F0DC9B" })
  hl(0, "RainbowGreenMuted",  { fg = "#B6E1A3" })
  hl(0, "RainbowCyanMuted",   { fg = "#A5DEE4" })
  hl(0, "RainbowBlueMuted",   { fg = "#A9C6F5" })
  hl(0, "RainbowVioletMuted", { fg = "#D1B2F2" })

  -- Simple gray
  hl(0, "IndentBlanklineChar", { fg = "#3C4048" })

  -- ExtraWhitespace highlight
  hl(0, "ExtraWhitespace", { bg = "#FF00FF" })
end

-- 🔁 Cycle between modes
function M.cycle_indent_guides()
  M.current_mode = (M.current_mode % #M.mode_names) + 1
  M.set_mode(M.mode_names[M.current_mode])
end

-- 🎯 Set a specific mode
function M.set_mode(mode_name)
  for i, name in ipairs(M.mode_names) do
    if name == mode_name then
      M.current_mode = i
      M.setup_highlights()  -- Ensure highlights are set before ibl.setup
      require("ibl").setup(M.configs[mode_name])
      vim.notify("Indent guides: " .. mode_name:gsub("_", " "), vim.log.levels.INFO)
      return
    end
  end
  vim.notify("Invalid mode: " .. mode_name, vim.log.levels.ERROR)
end

-- 🚀 Setup (initial or on colorscheme change)
function M.setup()
  M.setup_highlights()
  local config = M.configs[M.mode_names[M.current_mode]]
  require("ibl").setup(config)
end

-- 💡 Run initial setup now
-- Don't run setup immediately - let's control when it happens
-- M.setup()

-- Auto-reapply highlights and IBL config when colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  group = vim.api.nvim_create_augroup("IndentBlanklineCustom", { clear = true }),
  callback = function()
    -- Set highlights immediately when colorscheme changes
    M.setup_highlights()
  end,
  desc = "Setup indent-blankline highlights after colorscheme change"
})

-- Setup IBL after everything is loaded
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    M.setup()
  end,
  desc = "Initial indent-blankline setup"
})

-- Also setup on BufEnter to ensure it's working
vim.api.nvim_create_autocmd("BufEnter", {
  once = true,
  callback = function()
    M.setup()
  end,
  desc = "Ensure indent-blankline is setup"
})

return M
