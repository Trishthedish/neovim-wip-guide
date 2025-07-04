-- snacks_states.lua

local M = {}

function M.setup()
  local snacks = require("snacks")

  -- Check if snacks has toggle utility with new method
  if snacks.toggle and snacks.toggle.new then
    -- Create a custom toggle for line numbers
    snacks.toggle.new("line_numbers_toggle", {
      name = "Line Numbers",
      get = function()
        return vim.opt.relativenumber:get()
      end,
      set = function(state)
        if state then
          vim.opt.number = true
          vim.opt.relativenumber = true
        else
          vim.opt.number = true
          vim.opt.relativenumber = false
        end
      end,
    })
  end
end

return M
