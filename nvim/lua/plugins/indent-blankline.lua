-- ~/.config/nvim/plugins/indent-blankline.lua

local M = {}

M.current_mode = 1
M.mode_names = {"rainbow_dashed", "rainbow_continuous", "gray_simple"}

-- Define the three configuration modes
M.configs = {
    rainbow_dashed = {
      indent = {
        char = "┊",  -- matches your exact character
        highlight = {
          "RainbowRed",
          "RainbowYellow",
          "RainbowBlue",
          "RainbowOrange",
          "RainbowGreen",
          "RainbowViolet",
          "RainbowCyan"
        },
      },
      whitespace = {
        remove_blankline_trail = false -- keep trailing whitespace visible
      },
      exclude = {
        filetypes = {
          "help",
          "dashboard",
          "NvimTree",
          "lazy",
          "lualine",
          "mason",
          "snacks",
          "snacks_dashboard"
        }
      },
      scope = {
        enabled = false,
      },
    },

    rainbow_continuous = {
      indent = {
        char = "▏",  -- continuous full column character
        highlight = {
          "RainbowRedMuted",
          "RainbowYellowMuted",
          "RainbowBlueMuted",
          "RainbowOrangeMuted",
          "RainbowGreenMuted",
          "RainbowVioletMuted",
          "RainbowCyanMuted"
        },
      },
      whitespace = {
        remove_blankline_trail = false, -- keep trailing whitespace visible
      },
      exclude = {
        filetypes = {
          "help",
          "dashboard",
          "NvimTree",
          "lazy",
          "lualine",
          "mason",
          "snacks",
          "snacks_dashboard"
        }
      },
      scope = {
        enabled = false,  -- matches your setting
      },
    },
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
          "help",
          "dashboard",
          "NvimTree",
          "lazy",
          "lualine",
          "mason",
          "snacks",
          "snacks_dashboard"
        }
      },
      scope = {
        enabled = false,  -- matches your setting
      },
    }
}

-- Define Highlight groups

local function setup_highlights()
  -- Rainbow highlights (bright) - matches your exact colors
  vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
  vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
  vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
  vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
  vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
  vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
  vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })

  -- -- Muted rainbow highlights
vim.api.nvim_set_hl(0, "RainbowRedMuted",    { fg = "#D99A9A" }) -- soft rose
vim.api.nvim_set_hl(0, "RainbowOrangeMuted", { fg = "#E6A87A" }) -- creamsicle
vim.api.nvim_set_hl(0, "RainbowYellowMuted", { fg = "#F0DC9B" }) -- wheat gold
vim.api.nvim_set_hl(0, "RainbowGreenMuted",  { fg = "#B6E1A3" }) -- spring mint
vim.api.nvim_set_hl(0, "RainbowCyanMuted",   { fg = "#A5DEE4" }) -- glacier teal
vim.api.nvim_set_hl(0, "RainbowBlueMuted",   { fg = "#A9C6F5" }) -- powder sky
vim.api.nvim_set_hl(0, "RainbowVioletMuted", { fg = "#D1B2F2" }) -- lilac bloom

  -- Gray highlights
  vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "#3C4048" })

  -- ExtraWhitespace highlight (for trailing whitespace) - matches your setting
  vim.api.nvim_set_hl(0, "ExtraWhitespace", { bg = "#FF00FF" })
end

-- Function to cycle through modes
function M.cycle_indent_guides()
  M.current_mode = (M.current_mode % 3) + 1
  local config_name = M.mode_names[M.current_mode]
  local config = M.configs[config_name]

  -- Apply the new configuration
  require('ibl').setup(config)

  -- Notify user of current mode
  vim.notify("Indent guides: " .. config_name:gsub("_", " "), vim.log.levels.INFO)
end

-- Function to set specific mode
function M.set_mode(mode_name)
  for i, name in ipairs(M.mode_names) do
    if name == mode_name then
      M.current_mode = i
      require('ibl').setup(M.configs[mode_name])
      vim.notify("Indent guides: " .. mode_name:gsub("_", " "), vim.log.levels.INFO)
      return
    end
  end
  vim.notify("Invalid mode: " .. mode_name, vim.log.levels.ERROR)
end

-- Initial setup
local function setup()
  setup_highlights()

  -- Set up the plugin with default configuration
  require('ibl').setup(M.configs.gray_simple)
end

-- Call setup
setup()

-- Auto-reapply highlights and IBL config when colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    setup_highlights()
    local current = M.mode_names[M.current_mode]
    local config = M.configs[current]
    require("ibl").setup(config)
  end,
})

return M
