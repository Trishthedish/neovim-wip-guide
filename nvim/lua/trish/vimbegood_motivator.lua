-- File: ~/.config/nvim/lua/trish/vimbegood_motivator.lua

local M = {}

local log_path = vim.fn.expand("~/.local/share/nvim/VimBeGoodStats.log")

-- Helper: split string by a separator
local function split(str, sep)
  local result = {}
  for part in string.gmatch(str, "([^"..sep.."]+)") do
    table.insert(result, part)
  end
  return result
end

-- Parse a single round entry line into a table
local function parse_round(entry)
  local parts = split(entry, ",")
  if #parts ~= 6 then return nil end
  return {
    timestamp = tonumber(parts[1]),
    roundNum = tonumber(parts[2]),
    difficulty = parts[3],
    roundName = parts[4],
    success = parts[5] == "true",
    time = tonumber(parts[6]),
  }
end

-- Read and parse all rounds from the log file
local function read_log()
  local f = io.open(log_path, "r")
  if not f then return {} end
  local content = f:read("*a")
  f:close()

  local rounds = {}
  for entry in string.gmatch(content, "[^%s]+") do
    local round = parse_round(entry)
    if round then
      table.insert(rounds, round)
    end
  end
  return rounds
end

-- Convert timestamp to YYYY-MM-DD string (local time)
local function timestamp_to_date(ts)
  return os.date("%Y-%m-%d", ts)
end

-- Aggregate stats
local function aggregate_stats(rounds)
  local stats = {
    sessions_today = 0,
    avg_time = 0,
    total_success = 0,
    total_rounds = 0,
    current_streak = 0,
    max_streak = 0,
    skill = {},  -- skill breakdown by roundName
  }

  local today = os.date("%Y-%m-%d") -- local time for matching "today"

  -- Group rounds into sessions (games of exactly 10 rounds)
  local game_sessions = {}
  local current_session = {}

  for i, r in ipairs(rounds) do
    table.insert(current_session, r)

    -- If roundNum == 10 or last round, consider session complete
    if r.roundNum == 10 or i == #rounds then
      -- Only count complete sessions of 10 rounds starting with 1 and ending with 10
      if #current_session == 10 and current_session[1].roundNum == 1 and current_session[10].roundNum == 10 then
        table.insert(game_sessions, current_session)
      end
      current_session = {}
    end
  end

  -- Count sessions completed today
  for _, session in ipairs(game_sessions) do
    local last = session[#session]
    if timestamp_to_date(last.timestamp) == today then
      stats.sessions_today = stats.sessions_today + 1
    end
  end

  -- Continue aggregating all rounds (not sessions) for other stats
  local streak = 0
  for _, r in ipairs(rounds) do
    if r.success then
      stats.total_success = stats.total_success + 1
      streak = streak + 1
      if streak > stats.max_streak then
        stats.max_streak = streak
      end
    else
      streak = 0
    end

    stats.total_rounds = stats.total_rounds + 1
    stats.avg_time = stats.avg_time + r.time

    -- Skill breakdown by roundName
    if not stats.skill[r.roundName] then
      stats.skill[r.roundName] = {
        count = 0,
        success = 0,
        total_time = 0,
      }
    end
    local skill_entry = stats.skill[r.roundName]
    skill_entry.count = skill_entry.count + 1
    if r.success then skill_entry.success = skill_entry.success + 1 end
    skill_entry.total_time = skill_entry.total_time + r.time
  end

  if stats.total_rounds > 0 then
    stats.avg_time = stats.avg_time / stats.total_rounds
  else
    stats.avg_time = 0
  end
  stats.current_streak = streak

  -- Compute success rate and average time per skill
  for _, v in pairs(stats.skill) do
    v.success_rate = (v.success / v.count) * 100
    v.avg_time = v.total_time / v.count
  end

  return stats
end

-- Quote or tip of the day (basic example)
local function get_quote_of_the_day()
  local quotes = {
    "Keep pushing your limits! 🚀",
    "Consistency is the key to mastery.",
    "Mistakes are proof you're trying.",
    "Focus on progress, not perfection.",
    "Practice makes permanent.",
    "Don't forget to take breaks!",
  }
  local day = tonumber(os.date("%d")) or 1
  return quotes[(day % #quotes) + 1]
end

-- Create and open a floating window with the stats
function M.open()
  local rounds = read_log()
  local stats = aggregate_stats(rounds)
  local quote = get_quote_of_the_day()

  local lines = {}
  table.insert(lines, "📊 VimBeGood Stats")
  table.insert(lines, "-------------------")
  table.insert(lines, string.format("Sessions today: %d", stats.sessions_today))
  table.insert(lines, string.format("Average time: %.2f seconds", stats.avg_time))
  table.insert(lines, string.format("Current streak 🔥: %d", stats.current_streak))
  table.insert(lines, "")
  table.insert(lines, "Skill breakdown:")

  for name, skill in pairs(stats.skill) do
    table.insert(lines, string.format(
      "  - %s: %.1f%% success, avg time %.2fs",
      name, skill.success_rate, skill.avg_time))
  end

  table.insert(lines, "")
  table.insert(lines, "💡 Tip of the day:")
  table.insert(lines, quote)

  -- Floating window options
  local buf = vim.api.nvim_create_buf(false, true) -- create new scratch buffer
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  local width = 50
  local height = #lines
  local opts = {
    relative = "editor",
    width = width,
    height = height,
    row = (vim.o.lines - height) / 2,
    col = (vim.o.columns - width) / 2,
    style = "minimal",
    border = "rounded",
  }

  vim.api.nvim_open_win(buf, true, opts)
end

return M
