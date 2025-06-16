local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep  -- 👈 Enables text repetition

return {
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
  })
}