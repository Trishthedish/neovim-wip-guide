local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep  -- 👈 Enables text repetition
local fmt = require("luasnip.extras.fmt").fmt -- 👈 Enables formatted snippets

--[[
📝 SNIPPET GUIDE:

"leetcode":
  ✦ Old-school example
  ✦ More verbose structure using individual `t()` and `i()` nodes
  ✦ Useful for understanding how LuaSnip primitives work line-by-line

"leet1":
  ✦ Modern-style using `fmt()` — simpler and cleaner
  ✦ Designed for functions that take **one** parameter

"leet2":
  ✦ Also modern `fmt()` format
  ✦ Built for functions that take **two** parameters

These newer snippets demonstrate a better DX (developer experience), especially for rapid LeetCode testing setups.
]]

return {

  -- Older style snippet for learning primitives
  s("leetcode", {
    t({ "class Solution:" }),  -- Modern Python doesn't need (object)
    t({ "    def " }), i(1, "function_name"),
    t({ "(self, " }), i(2, "param1, param2"),
    t({ "):", "        " }), i(3, "pass"),
    t({ "", "", "# Instantiate Solution class" }),
    t({ "solution = Solution()", "", "" }),

    -- ✨ Example 1
    t({ "# Ex 1:", "# Input:" }),
    t({ "param1 = " }), i(4, '"rat"'),
    t({ "", "param2 = " }), i(5, '"car"'),
    t({ "", "# Output:" }),
    t({ "print(\"Solution 1:\", solution." }), rep(1), t({ "(param1, param2))" }),
    t({ "", "# Expected outcome:", "", "" }),

    -- ✨ Example 2
    t({ "# Ex 2:", "# Input:" }),
    t({ "param1 = " }), i(6, '"rat"'),
    t({ "", "param2 = " }), i(7, '"car"'),
    t({ "", "# Output:" }),
    t({ "print(\"Solution 2:\", solution." }), rep(1), t({ "(param1, param2))" }),
    t({ "", "# Expected outcome:", "", "" }),

    -- ✨ Example 3
    t({ "# Ex 3:", "# Input:" }),
    t({ "param1 = " }), i(8, '"debitcard"'),
    t({ "", "param2 = " }), i(9, '"badcredit"'),
    t({ "", "# Output:" }),
    t({ "print(\"Solution 3:\", solution." }), rep(1), t({ "(param1, param2))" }),
    t({ "", "# Expected outcome:" }),
  }),

  -- Single-parameter function, formatted
  s("leet1", fmt([[
class Solution:
  def {}(self, {}):
    {}

  # Instantiate the Solution class
  solution = Solution()

  # -- ✨Example 1
  # Input:
  # {} =

  # Ouput:
  print("Solution 1:", solution.{}({}))

  # -- ✨Example 2
  # Input:
  # {} =

  # Output:
  print("Solution 2:", solution.{}({}))

  # -- ✨Example 3
  # Input:
  # {} =

  # Ouput:
  print("Solution 3:", solution.{}({}))
  ]], {
    i(1, "function_name"),       -- Function name
    i(2, "param"),               -- Single Parameter
    i(3, "pass"),                -- Function body

    rep(2),                      -- Example 1 input
    rep(1), rep(2),              -- Example 1 function call

    rep(2),                      -- Example 2 input
    rep(1), rep(2),              -- Example 2 function call

    rep(2),                      -- Example 3 input
    rep(1), rep(2),              -- Example 3 function call
  })),

  -- Two-parameter function, formatted
  s("leet2", fmt([[
class Solution:
  def {}(self, {}, {}):
    {}

  # Instantiate the Solution class
  solution = Solution()

  # -- ✨Example 1
  # Input:
  # {} =
  # {} =

  # Output:
  print("Solution 1:", solution.{}({}, {}))

  # -- ✨Example 2
  # Input:
  # {} =
  # {} =

  # Ouput:
  print("Solution 2:", solution.{}({}, {}))

  # -- ✨Example 3
  # Input:
  # {} =
  # {} =

  # Output:
  print("Solution 3.", solution.{}({}, {}))
  ]], {
    i(1, "function_name"),       -- Function name
    i(2, "param1"),              -- First Parameter
    i(3, "param2"),              -- Second Parameter
    i(4, "pass"),                -- Function body

    rep(2), rep(3),              -- Inputs for Example 1
    rep(1), rep(2), rep(3),      -- Call for Example 1

    rep(2), rep(3),              -- Inputs for Example 2
    rep(1), rep(2), rep(3),      -- Call for Example 2

    rep(2), rep(3),              -- Inputs for Example 3
    rep(1), rep(2), rep(3),      -- Call for Example 3
  })),

  -- mpsp 2 param snippet code
  -- Minimum Problem Solving Product
  s("mpsp_2p)", fmt([[
"""
The Problem {}
-----------------------------
{}
"""

# -- 💭 Test Notes --
# Inputs: {}
# Expected Output: {}

def run_test({}, {}, expected):
   def {}(version):
       return {}             # Mocked API

   class Solution():
       def {}(self, {}):
{}

   sol = Solution()
   result = sol.{}({})
   print("✅" if result == expected else f"❌ Got " + str(result) + ", expected " + str(expected))

# -- 🔁 Sample Runs
run_test({}, {}, {})
run_test({}, {}, {})
run_test({}, {}, {})
]], {
    i(1, "First Bad Version"),                          -- Problem name
    i(2, "You are given API is_bad_version(version)..."), -- Problem description
    i(3, "n, first_bad"),                               -- Inputs
    i(4, "4"),                                          -- Expected Output
    i(5, "n"),                                          -- run_test param 1:
    i(6, "first_bad"),                                  -- run_test param 2
    i(7, "is_bad_version"),                             -- mock function name
    i(8, "version >= first_bad"),                       -- mock logic
    i(9, "first_bad_version"),                          -- method name
    rep(5),                                             -- method param
    t({                                                 -- Method body
      "           left, right = 1, n",
      "           while left < right:",
      "               mid = left + (right - left) // 2",
      "               if is_bad_version(mid):",
      "                   right = mid",
      "               else:",
      "                   left = mid + 1",
      "           return left"
     }),
    rep(9),                                             -- method call function
    rep(5),                                             -- method call param
    i(10, "5"),                                         -- Sample 1 param 1
    i(11, "4"),                                         -- Sample 1 param 2
    i(12, "4"),                                         -- Sample 1 expected

    i(13, "2"),                                         -- Sample 2 param 1
    i(14, "1"),                                         -- Sample 2 param 2
    i(15, "1"),                                         -- Sample 2 expected

    i(16, "10"),                                        -- Sample 3 param 1
    i(17, "7"),                                         -- Sample 3 param 2
    i(18, "7"),                                         -- Sample 3 expected
    })),
}
