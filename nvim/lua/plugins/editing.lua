return {
  {
    "jiaoshijie/undotree",
    dependencies = { "nvim-lua/plenary.nvim" },
    ---@module 'undotree.collector'
    ---@type UndoTreeCollector.Opts
    opts = {
      -- your options
      float_diff = true, -- using float window previews diff, set this `true` will disable layout option
      layout = "left_bottom", -- "left_bottom", "left_left_bottom"
      position = "left", -- "right", "bottom"
      ignore_filetype = {
        "undotree",
        "undotreeDiff",
        "qf",
        "TelescopePrompt",
        "spectre_panel",
        "tsplayground",
      },
      window = {
        winblend = 30,
      },
      keymaps = {
        j = "move_next",
        k = "move_prev",
        gj = "move2parent",
        J = "move_change_next",
        K = "move_change_prev",
        ["<cr>"] = "action_enter",
        p = "enter_diffbuf",
        q = "quit",
      },
    },
    keys = { -- load the plugin only when using it's keybinding:
      { "<leader>ut", "<cmd>lua require('undotree').toggle()<cr>", desc = "UndoTree Toggle" },
    },
  },

  -- folke/todo-comments.nvim
  {
    "folke/todo-comments.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true,
      sign_priority = 8,
      keywords = {
        FIX = {
          icon = " ",
          color = "error",
          alt = { "ERROR", "FIXME", "BUG", "FIXIT", "ISSUE" },
          signs = true,
        },
        TODO = { icon = " ", color = "info", alt = { "TASK" } },
        HACK = { icon = " ", color = "warning", alt = { "TRICK" } },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      gui_style = {
        fg = "NONE",
        bg = "BOLD",
      },
      merge_keywords = true,
      highlight = {
        multiline = true,
        multiline_pattern = "^.",
        multiline_context = 10,
        before = "",
        keyword = "wide",
        after = "fg",
        pattern = [[.*<(KEYWORDS)\s*:]],
        comments_only = true,
        max_line_len = 400,
        exclude = {},
      },
      colors = {
        error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
        warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
        info = { "DiagnosticInfo", "#2563EB" },
        hint = { "DiagnosticHint", "#10B981" },
        default = { "Identifier", "#7C3AED" },
        test = { "Identifier", "#FF00FF" },
      },
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
        pattern = [[\b(KEYWORDS):]],
      },
    },
  },

  -- dhruvasagar/vim-table-mode
  {
    "dhruvasagar/vim-table-mode",
  },

  -- RaafatTurki/hex.nvim
  {
    "RaafatTurki/hex.nvim",
  },

  -- f-person/git-blame.nvim
  {
    "f-person/git-blame.nvim",
  },

  -- hat0uma/csvview.nvim
  {
    "hat0uma/csvview.nvim",
    ft = { "csv", "tsv", "csv_semicolon", "csv_whitespace", "csv_pipe" },
    opts = {},
  },

  -- jbyuki/venn.nvim — ASCII diagram drawing
  {
    "jbyuki/venn.nvim",
    keys = {
      { "<leader>gv", "<cmd>lua Toggle_venn()<CR>", desc = "Venn: Toggle drawing mode" },
    },
    config = function()
      function _G.Toggle_venn()
        local venn_enabled = vim.inspect(vim.b.venn_enabled)
        local venn_strock = vim.inspect(vim.b.venn_strock)

        if venn_enabled == "nil" then
          vim.b.venn_enabled = true
          vim.cmd("setlocal ve=all")
          vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
          vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
          vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
          vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
          vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true })
          vim.api.nvim_buf_set_keymap(0, "v", "F", ":VBoxH<CR>", { noremap = true })
        else
          vim.cmd("setlocal ve=")
          vim.api.nvim_buf_del_keymap(0, "n", "J")
          vim.api.nvim_buf_del_keymap(0, "n", "K")
          vim.api.nvim_buf_del_keymap(0, "n", "L")
          vim.api.nvim_buf_del_keymap(0, "n", "H")
          vim.api.nvim_buf_del_keymap(0, "v", "f")
          vim.api.nvim_buf_del_keymap(0, "v", "F")
          vim.b.venn_enabled = nil
        end
      end
    end,
  },
}
