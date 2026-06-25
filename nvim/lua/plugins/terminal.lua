return {
  -- {
  --   "nvzone/floaterm",
  --   dependencies = "nvzone/volt",
  --   opts = {
  --     border = "single",
  --     mappings = {
  --       sidebar = function(buf)
  --         vim.keymap.set("n", "<A-a>", function()
  --           require("floaterm.api").new_term({})
  --         end, { buffer = buf })
  --         vim.keymap.set("n", "<A-e>", function()
  --           require("floaterm.api").edit_name()
  --         end, { buffer = buf })
  --       end,
  --       term = function(buf)
  --         vim.keymap.set({ "n", "t" }, "<A-n>", function()
  --           require("floaterm.api").cycle_term_bufs("prev")
  --         end, { buffer = buf })
  --         vim.keymap.set({ "n", "t" }, "<A-m>", function()
  --           require("floaterm.api").cycle_term_bufs("next")
  --         end, { buffer = buf })
  --         vim.keymap.set({ "n", "t" }, "<A-t>", function()
  --           require("floaterm.api").toggle()
  --         end, { buffer = buf })
  --       end,
  --     },
  --     size = {
  --       h = 0.8,
  --       w = 0.8,
  --     },
  --   },
  -- },
  {
    "voldikss/vim-floaterm",
  },
}
