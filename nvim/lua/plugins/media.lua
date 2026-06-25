return {
  -- MeanderingProgrammer/render-markdown.nvim
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
    opts = {
      preset = "obsidian",
      file_types = { "markdown", "Avante" },
      patterns = {
        markdown = {
          disable = true,
          directives = {
            { id = 17, name = "conceal_lines" },
            { id = 18, name = "conceal_lines" },
          },
        },
      },
      anti_conceal = {
        ignore = {
          code_background = true,
          indent = true,
          sign = true,
          virtual_lines = true,
        },
      },
      heading = {
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      },
      checkbox = {
        custom = {
          todo = { raw = '[-]', rendered = '󰥔 ', highlight = 'RenderMarkdownTodo', scope_highlight = nil },
        },
      },
    },
  },

  -- snrogers/mermaider
  {
    "snrogers/mermaider.nvim",
    dependencies = {
      "folke/snacks.nvim", -- image display via snacks
    },
    enabled = true,
    config = function()
      require("mermaider").setup({
        temp_dir = vim.fn.expand("$HOME/.cache/mermaider"),
        auto_render = true,
        auto_render_on_open = true,
        auto_preview = true,
        throttle_delay = 500,
        inline_render = true,
        max_width_window_percentage = 80,
        max_height_window_percentage = 80,
        split_direction = "vertical",
        split_width = 50,
        theme = "forest",
        background_color = "#1e1e2e",
        mmdc_options = "",
        css_file = nil,
        mermaid_config_file = nil,
      })
    end,
    ft = { "mmd", "mermaid" },
  },

  -- makerj/vim-pdf
  {
    "makerj/vim-pdf",
  },
}
