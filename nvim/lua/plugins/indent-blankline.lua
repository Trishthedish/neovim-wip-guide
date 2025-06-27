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
          "lualine"
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
          "lualine"
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
          "lualine"
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

  -- Muted rainbow highlights
  vim.api.nvim_set_hl(0, "RainbowRedMuted", { fg = "#E06C75", blend = 60 })
  vim.api.nvim_set_hl(0, "RainbowYellowMuted", { fg = "#E5C07B", blend = 60 })
  vim.api.nvim_set_hl(0, "RainbowBlueMuted", { fg = "#61AFEF", blend = 60 })
  vim.api.nvim_set_hl(0, "RainbowOrangeMuted", { fg = "#D19A66", blend = 60 })
  vim.api.nvim_set_hl(0, "RainbowGreenMuted", { fg = "#98C379", blend = 60 })
  vim.api.nvim_set_hl(0, "RainbowVioletMuted", { fg = "#C678DD", blend = 60 })
  vim.api.nvim_set_hl(0, "RainbowCyanMuted", { fg = "#56B6C2", blend = 60 })

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
  require('ibl').setup(M.configs.rainbow_dashed)
end

-- Call setup
setup()

return M
