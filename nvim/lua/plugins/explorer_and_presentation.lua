return {
  -- nvim-telescope/telescope.nvim
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-dap.nvim",
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-media-files.nvim",
      "gbrlsnchs/telescope-lsp-handlers.nvim",
    },
    keys = {
      -- Add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader><space>",
        "<cmd>Telescope buffers sort_mru=true sort_lastused=true ignore_current_buffer=true<cr>",
        desc = "Find Files (Root Dir)"
      },
      {
        "<leader>fa",
        function()
          require("telescope.builtin").live_grep({ cwd = require("lazy.core.config").options.cwd })
        end,
        desc = "Live Grep (cwd)",
      },
      {
        "<leader>fA",
        function()
          require("telescope.builtin").live_grep({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Live Grep (Root)",
      },
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.cwd })
        end,
        desc = "Find File (cwd)",
      },
      {
        "<leader>fF",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find File (Root)",
      },
      {
        "<leader>fs",
        function()
          require("telescope.builtin").lsp_workspace_symbols({ cwd = require("lazy.core.config").options.cwd })
        end,
        desc = "Workspace Symbols (cwd)",
      },
      {
        "<leader>fS",
        function()
          require("telescope.builtin").lsp_workspace_symbols({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Workspace Symbols (Root)",
      },
      { "<A-f>", "<cmd>Telescope find_files<CR>", desc = "Find files" },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
        preview = {
          treesitter = true,
          wrap = true,
        },
        wrap_results = true,
      },
      mappings = {
        i = {
          ["<CR>"] = "select_default",
          ["<C-/>"] = "which_key", -- keys from pressing <C-/>
          ["<C-d>"] = "preview_scrolling_down",
          ["<C-e>"] = "results_scrolling_up",
          ["<C-l>"] = "complete_tag",
          ["<C-n>"] = "move_selection_next",
          ["<C-p>"] = "move_selection_previous",
          ["<C-T>"] = "open_with_trouble",
          ["<C-t>"] = "open_tabnew",
          ["<C-u>"] = "preview_scrolling_up",
          ["<C-v>"] = "select_vertical",
          ["<C-x>"] = "select_horizontal",
          ["<C-y>"] = "results_scrolling_down",
        },
        n = {
          ["j"] = "move_selection_next",
          ["k"] = "move_selection_previous",
          ["H"] = "move_to_top",
          ["M"] = "move_to_middle",
          ["L"] = "move_to_bottom",
          ["gg"] = "move_to_top",
          ["G"] = "move_to_bottom",
          ["<Down>"] = "move_selection_next",
          ["<Up>"] = "move_selection_previous",
          ["<CR>"] = "select_default",
          ["<C-x>"] = "select_horizontal",
          ["<C-v>"] = "select_vertical",
          ["<C-t>"] = "select_tab",
          ["<C-T>"] = "open_with_trouble",
        },
      },
      pickers = {
        find_files = {
          previewer = true,
          wrap_results = true,
          find_cmd = { "fd", "--type", "f", "--strip-cwd-previx", "--ignore-file", "--hidden" },
        },
        buffers = {
          previewer = true,
          sort_mru = true,
          ignore_current_buffer = true,
          wrap_results = true,
        },
        builtin = {
          previewer = true,
          treesitter = true,
          wrap_results = true,
          wrap = true,
        },
        quickfix = {
          previewer = true,
        },
      },
      extensions = {
        ["media_files"] = {
          filetypes = { "png", "webp", "jpg", "jpeg", "pdf" },
          find_cmd = { "fd", "--type", "f", "--strip-cwd-previx", "--ignore-file" }, -- find command (defaults to `fd`)
        },
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({
            -- even more opts
          }),
        },
      },
      load_extensions = { "ui-select", "media_files", "dap", "lsp_handlers" },
    },
  },

  -- 3rd/image
  {
    "3rd/image.nvim",
    opts = {
      enabled = true,
      backend = "kitty",
      processor = "magick_cli", -- or "magick_rock"
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          only_render_image_at_cursor_mode = "popup", -- or "inline"
          floating_windows = false, -- If true, images will be rendered in floating markdown windows
          filetypes = { "markdown", "vimwiki" }, -- markdown extensions (i.e. quarto) can go here
        },
        neorg = {
          enabled = true,
          filetypes = { "norg" },
        },
        typst = {
          enabled = true,
          filetypes = { "typst" },
        },
        html = {
          enabled = true,
        },
        css = {
          enabled = true,
        },
      },
      max_width = nil,
      max_height = nil,
      max_width_window_percentage = nil,
      max_height_window_percentage = 50,
      scale_factor = 1.0,
      window_overlap_clear_enabled = true, -- Toggles images when windows are overlapped
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
      editor_only_render_when_focused = true, -- Auto show/hide images when the editor gains/looses focus
      tmux_show_only_in_active_window = true, -- Auto show/hide images in the correct Tmux window (needs visual-activity off)
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- Render image files as images when opened
    },
  },

  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "kyazdani42/nvim-web-devicons",
    },
    opts = {

      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = false,
      },
      sections = {
        lualine_a = {
          "mode",
        },
        lualine_b = {
          "branch",
          "diff",
          "diagnostics",
          "filesize",
          -- {
          --   git_blame.get_current_blame_text,
          --   cond = git_blame.is_blame_text_available
          -- },
          "filename",
        },
        lualine_c = {
          --'%{%get(b:, "coc_symbol_line", "")%}',
        },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress", "selectioncount", "searchcount" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {
        --lualine_a = {'tabs'},
      },
      winbar = {
        lualine_a = {
          {
            "navic",
            color_correction = nil,
            navic_opts = nil,
          },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "fzf", "neo-tree", "quickfix" },
    },
  },
  --
  -- folke/todo-comments.nvim
  {
    "folke/todo-comments.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true, -- Show icons in the signs column
      sign_priority = 8, -- sign priority
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "ERROR", "FIXME", "BUG", "FIXIT", "ISSUE" }, -- A set of other keywords that all map to this FIX keywords
          signs = true, -- Configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "info", alt = { "TASK" } },
        HACK = { icon = " ", color = "warning", alt = { "TRICK" } },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      gui_style = {
        fg = "NONE", -- The gui style to use for the fg highlight group.
        bg = "BOLD", -- The gui style to use for the bg highlight group.
      },
      merge_keywords = true, -- when true, custom keywords will be merged with the defaults
      highlight = {
        multiline = true, -- enable multiline To-do comments
        multiline_pattern = "^.", -- Lua pattern to match the next multiline from the start of the matched keyword
        multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
        before = "", -- "fg" or "bg" or empty
        keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
        after = "fg", -- "fg" or "bg" or empty
        pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
        comments_only = true, -- Uses treesitter to match keywords in comments only
        max_line_len = 400, -- ignore lines longer than this
        exclude = {}, -- List of file types to exclude highlighting
      },
      colors = {
        error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
        warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
        info = { "DiagnosticInfo", "#2563EB" },
        hint = { "DiagnosticHint", "#10B981" },
        default = { "Identifier", "#7C3AED" },
        test = { "Identifier", "#FF00FF" }, -- purple
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
        -- Regex that will be used to match keywords.
        -- Don't replace (KEYWORDS) here, the plugin does that for you
        pattern = [[\b(KEYWORDS):]], -- ripgrep regex
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

  -- makerj/vim-pdf
  {
    "makerj/vim-pdf",
  },

  -- MeanderingProgrammer/render-markdown.nvim
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- If you use the mini.nvim suite
    -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
    -- if you prefer nvim-web-devicons
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      -- Whether markdown should be rendered by default.
      enabled = true,
      -- Vim modes that will show a rendered view of the markdown file, :h mode(), for all enabled
      -- components. Individual components can be enabled for other modes. Remaining modes will be
      -- unaffected by this plugin.
      render_modes = { "n", "c", "t" },
      -- Maximum file size (in MB) that this plugin will attempt to render.
      -- File larger than this will effectively be ignored.
      max_file_size = 10.0,
      -- Milliseconds that must pass before updating marks, updates occur.
      -- within the context of the visible window, not the entire buffer.
      debounce = 100,
      -- Pre configured settings that will attempt to mimic various target user experiences.
      -- User provided settings will take precedence.
      -- | obsidian | mimic Obsidian UI                                          |
      -- | lazy     | will attempt to stay up to date with LazyVim configuration |
      -- | none     | does nothing                                               |
      preset = "obsidian",
      -- The level of logs to write to file: vim.fn.stdpath('state') .. '/render-markdown.log'.
      -- Only intended to be used for plugin development / debugging.
      log_level = "error",
      -- Print runtime of main update method.
      -- Only intended to be used for plugin development / debugging.
      log_runtime = false,
      -- Filetypes this plugin will run on.
      file_types = { "markdown", "Avante" },
      -- Takes buffer as input, if it returns true this plugin will not attach to the buffer.
      ignore = function()
        return false
      end,
      -- Whether markdown should be rendered when nested inside markdown, i.e. markdown code block
      -- inside markdown file.
      nested = true,
      -- Additional events that will trigger this plugin's render loop.
      change_events = {},
      -- Whether the treesitter highlighter should be restarted after this plugin attaches to its
      -- first buffer for the first time. May be necessary if this plugin is lazy loaded to clear
      -- highlights that have been dynamically disabled.
      restart_highlighter = false,
      injections = {
        -- Out of the box language injections for known filetypes that allow markdown to be interpreted
        -- in specified locations, see :h treesitter-language-injections.
        -- Set enabled to false in order to disable.

        gitcommit = {
          enabled = true,
          query = [[
                ((message) @injection.content
                    (#set! injection.combined)
                    (#set! injection.include-children)
                    (#set! injection.language "markdown"))
            ]],
        },
      },
      patterns = {
        -- Highlight patterns to disable for filetypes, i.e. lines concealed around code blocks

        markdown = {
          disable = true,
          directives = {
            { id = 17, name = "conceal_lines" },
            { id = 18, name = "conceal_lines" },
          },
        },
      },
      anti_conceal = {
        -- This enables hiding added text on the line the cursor is on.
        enabled = true,
        -- Modes to disable anti conceal feature.
        disabled_modes = false,
        -- Number of lines above cursor to show.
        above = 0,
        -- Number of lines below cursor to show.
        below = 0,
        -- Which elements to always show, ignoring anti conceal behavior. Values can either be
        -- booleans to fix the behavior or string lists representing modes where anti conceal
        -- behavior will be ignored. Valid values are:
        --   bullet
        --   callout
        --   check_icon, check_scope
        --   code_background, code_border, code_language
        --   dash
        --   head_background, head_border, head_icon
        --   indent
        --   link
        --   quote
        --   sign
        --   table_border
        --   virtual_lines
        ignore = {
          code_background = true,
          indent = true,
          sign = true,
          virtual_lines = true,
        },
      },
      padding = {
        -- Highlight to use when adding whitespace, should match background.
        highlight = "Normal",
      },
      latex = {
        -- Turn on / off latex rendering.
        enabled = true,
        -- Additional modes to render latex.
        render_modes = false,
        -- Executable used to convert latex formula to rendered unicode.
        converter = "latex2text",
        -- Highlight for latex blocks.
        highlight = "RenderMarkdownMath",
        -- Determines where latex formula is rendered relative to block.
        -- | above | above latex block |
        -- | below | below latex block |
        position = "below",
        -- Number of empty lines above latex blocks.
        top_pad = 0,
        -- Number of empty lines below latex blocks.
        bottom_pad = 1,
        -- Always use virtual lines for rendering instead of attempting to inline.
        virtual = true,
      },
      on = {
        -- Called when plugin initially attaches to a buffer.
        attach = function() end,
        -- Called before adding marks to the buffer for the first time.
        initial = function() end,
        -- Called after plugin renders a buffer.
        render = function() end,
        -- Called after plugin clears a buffer.
        clear = function() end,
      },
      completions = {
        -- Settings for blink.cmp completions source
        blink = { enabled = false },
        -- Settings for coq_nvim completions source
        coq = { enabled = false },
        -- Settings for in-process language server completions
        lsp = { enabled = true },
        filter = {
          callout = function()
            -- example to exclude obsidian callouts
            -- return value.category ~= 'obsidian'
            return true
          end,
          checkbox = function()
            return true
          end,
        },
      },
      heading = {
        -- Useful context to have when evaluating values.
        -- | level    | the number of '#' in the heading marker         |
        -- | sections | for each level how deeply nested the heading is |

        -- Turn on / off heading icon & background rendering.
        enabled = true,
        -- Additional modes to render headings.
        render_modes = false,
        -- Turn on / off atx heading rendering.
        atx = true,
        -- Turn on / off setext heading rendering.
        setext = true,
        -- Turn on / off sign column related rendering.
        sign = true,
        -- Replaces '#+' of 'atx_h._marker'.
        -- Output is evaluated depending on the type.
        -- | function | `value(context)`              |
        -- | string[] | `cycle(value, context.level)` |
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        -- Determines how icons fill the available space.
        -- | right   | '#'s are concealed and icon is appended to right side                      |
        -- | inline  | '#'s are concealed and icon is inlined on left side                        |
        -- | overlay | icon is left padded with spaces and inserted on left hiding additional '#' |
        position = "overlay",
        -- Added to the sign column if enabled.
        -- Output is evaluated by `cycle(value, context.level)`.
        signs = { "󰫎 " },
        -- Width of the heading background.
        -- | block | width of the heading text |
        -- | full  | full width of the window  |
        -- Can also be a list of the above values evaluated by `clamp(value, context.level)`.
        width = "full",
        -- Amount of margin to add to the left of headings.
        -- Margin available space is computed after accounting for padding.
        -- If a float < 1 is provided it is treated as a percentage of available window space.
        -- Can also be a list of numbers evaluated by `clamp(value, context.level)`.
        left_margin = 0,
        -- Amount of padding to add to the left of headings.
        -- Output is evaluated using the same logic as 'left_margin'.
        left_pad = 0,
        -- Amount of padding to add to the right of headings when width is 'block'.
        -- Output is evaluated using the same logic as 'left_margin'.
        right_pad = 0,
        -- Minimum width to use for headings when width is 'block'.
        -- Can also be a list of integers evaluated by `clamp(value, context.level)`.
        min_width = 0,
        -- Determines if a border is added above and below headings.
        -- Can also be a list of booleans evaluated by `clamp(value, context.level)`.
        border = false,
        -- Always use virtual lines for heading borders instead of attempting to use empty lines.
        border_virtual = true,
        -- Highlight the start of the border using the foreground highlight.
        border_prefix = false,
        -- Used above heading for border.
        above = "▄",
        -- Used below heading for border.
        below = "▀",
        -- Highlight for the heading icon and extends through the entire line.
        -- Output is evaluated by `clamp(value, context.level)`.
        backgrounds = {
          "RenderMarkdownH1Bg",
          "RenderMarkdownH2Bg",
          "RenderMarkdownH3Bg",
          "RenderMarkdownH4Bg",
          "RenderMarkdownH5Bg",
          "RenderMarkdownH6Bg",
        },
        -- Highlight for the heading and sign icons.
        -- Output is evaluated using the same logic as 'backgrounds'.
        foregrounds = {
          "RenderMarkdownH1",
          "RenderMarkdownH2",
          "RenderMarkdownH3",
          "RenderMarkdownH4",
          "RenderMarkdownH5",
          "RenderMarkdownH6",
        },
        -- Define custom heading patterns which allow you to override various properties based on
        -- the contents of a heading.
        -- The key is for healthcheck and to allow users to change its values, value type below.
        -- | pattern    | matched against the heading text @see :h lua-patterns |
        -- | icon       | optional override for the icon                        |
        -- | background | optional override for the background                  |
        -- | foreground | optional override for the foreground                  |
        custom = {},
      },
      paragraph = {
        -- Useful context to have when evaluating values.
        -- | text | text value of the node |

        -- Turn on / off paragraph rendering.
        enabled = true,
        -- Additional modes to render paragraphs.
        render_modes = false,
        -- Amount of margin to add to the left of paragraphs.
        -- If a float < 1 is provided it is treated as a percentage of available window space.
        -- Output is evaluated depending on the type.
        -- | function | `value(context)` |
        -- | number   | `value`          |
        left_margin = 0,
        -- Amount of padding to add to the first line of each paragraph.
        -- Output is evaluated using the same logic as 'left_margin'.
        indent = 0,
        -- Minimum width to use for paragraphs.
        min_width = 0,
      },
      code = {
        -- Turn on / off code block & inline code rendering.
        enabled = true,
        -- Additional modes to render code blocks.
        render_modes = false,
        -- Turn on / off sign column related rendering.
        sign = true,
        -- Whether to conceal nodes at the top and bottom of code blocks.
        conceal_delimiters = true,
        -- Turn on / off language heading related rendering.
        language = true,
        -- Determines where language icon is rendered.
        -- | right | right side of code block |
        -- | left  | left side of code block  |
        position = "left",
        -- Whether to include the language icon above code blocks.
        language_icon = true,
        -- Whether to include the language name above code blocks.
        language_name = true,
        -- Whether to include the language info above code blocks.
        language_info = true,
        -- Amount of padding to add around the language.
        -- If a float < 1 is provided it is treated as a percentage of available window space.
        language_pad = 0,
        -- A list of language names for which background highlighting will be disabled.
        -- Likely because that language has background highlights itself.
        -- Use a boolean to make behavior apply to all languages.
        -- Borders above & below blocks will continue to be rendered.
        disable_background = { "diff" },
        -- Width of the code block background.
        -- | block | width of the code block  |
        -- | full  | full width of the window |
        width = "block",
        -- Amount of margin to add to the left of code blocks.
        -- If a float < 1 is provided it is treated as a percentage of available window space.
        -- Margin available space is computed after accounting for padding.
        left_margin = 0,
        -- Amount of padding to add to the left of code blocks.
        -- If a float < 1 is provided it is treated as a percentage of available window space.
        left_pad = 0,
        -- Amount of padding to add to the right of code blocks when width is 'block'.
        -- If a float < 1 is provided it is treated as a percentage of available window space.
        right_pad = 0,
        -- Minimum width to use for code blocks when width is 'block'.
        min_width = 0,
        -- Determines how the top / bottom of code block are rendered.
        -- | none  | do not render a border                               |
        -- | thick | use the same highlight as the code body              |
        -- | thin  | when lines are empty overlay the above & below icons |
        -- | hide  | conceal lines unless language name or icon is added  |
        border = "thin",
        -- Used above code blocks to fill remaining space around language.
        language_border = "█",
        -- Added to the left of language.
        language_left = "",
        -- Added to the right of language.
        language_right = "",
        -- Used above code blocks for thin border.
        above = "▄",
        -- Used below code blocks for thin border.
        below = "▀",
        -- Turn on / off inline code related rendering.
        inline = true,
        -- Icon to add to the left of inline code.
        inline_left = "",
        -- Icon to add to the right of inline code.
        inline_right = "",
        -- Padding to add to the left & right of inline code.
        inline_pad = 0,
        -- Highlight for code blocks.
        highlight = "RenderMarkdownCode",
        -- Highlight for code info section, after the language.
        highlight_info = "RenderMarkdownCodeInfo",
        -- Highlight for language, overrides icon provider value.
        highlight_language = nil,
        -- Highlight for border, use false to add no highlight.
        highlight_border = "RenderMarkdownCodeBorder",
        -- Highlight for language, used if icon provider does not have a value.
        highlight_fallback = "RenderMarkdownCodeFallback",
        -- Highlight for inline code.
        highlight_inline = "RenderMarkdownCodeInline",
        -- Determines how code blocks & inline code are rendered.
        -- | none     | { enabled = false }                           |
        -- | normal   | { language = false }                          |
        -- | language | { disable_background = true, inline = false } |
        -- | full     | uses all default values                       |
        style = "full",
      },
      dash = {
        -- Turn on / off thematic break rendering.
        enabled = true,
        -- Additional modes to render dash.
        render_modes = false,
        -- Replaces '---'|'***'|'___'|'* * *' of 'thematic_break'.
        -- The icon gets repeated across the window's width.
        icon = "─",
        -- Width of the generated line.
        -- | <number> | a hard coded width value |
        -- | full     | full width of the window |
        -- If a float < 1 is provided it is treated as a percentage of available window space.
        width = "full",
        -- Amount of margin to add to the left of dash.
        -- If a float < 1 is provided it is treated as a percentage of available window space.
        left_margin = 0,
        -- Highlight for the whole line generated from the icon.
        highlight = "RenderMarkdownDash",
      },
      document = {
        -- Turn on / off document rendering.
        enabled = true,
        -- Additional modes to render document.
        render_modes = false,
        -- Ability to conceal arbitrary ranges of text based on lua patterns, @see :h lua-patterns.
        -- Relies entirely on user to set patterns that handle their edge cases.
        conceal = {
          -- Matched ranges will be concealed using character level conceal.
          char_patterns = {},
          -- Matched ranges will be concealed using line level conceal.
          line_patterns = {},
        },
      },
      bullet = {
        -- Useful context to have when evaluating values.
        -- | level | how deeply nested the list is, 1-indexed          |
        -- | index | how far down the item is at that level, 1-indexed |
        -- | value | text value of the marker node                     |

        -- Turn on / off list bullet rendering
        enabled = true,
        -- Additional modes to render list bullets
        render_modes = false,
        -- Replaces '-'|'+'|'*' of 'list_item'.
        -- If the item is a 'checkbox' a conceal is used to hide the bullet instead.
        -- Output is evaluated depending on the type.
        -- | function   | `value(context)`                                    |
        -- | string     | `value`                                             |
        -- | string[]   | `cycle(value, context.level)`                       |
        -- | string[][] | `clamp(cycle(value, context.level), context.index)` |
        icons = { "●", "○", "◆", "◇" },
        -- Replaces 'n.'|'n)' of 'list_item'.
        -- Output is evaluated using the same logic as 'icons'.
        ordered_icons = function(ctx)
          local value = vim.trim(ctx.value)
          local index = tonumber(value:sub(1, #value - 1))
          return ("%d."):format(index > 1 and index or ctx.index)
        end,
        -- Padding to add to the left of bullet point.
        -- Output is evaluated depending on the type.
        -- | function | `value(context)` |
        -- | integer  | `value`          |
        left_pad = 0,
        -- Padding to add to the right of bullet point.
        -- Output is evaluated using the same logic as 'left_pad'.
        right_pad = 0,
        -- Highlight for the bullet icon.
        -- Output is evaluated using the same logic as 'icons'.
        highlight = "RenderMarkdownBullet",
        -- Highlight for item associated with the bullet point.
        -- Output is evaluated using the same logic as 'icons'.
        scope_highlight = {},
      },
      checkbox = {
        -- Checkboxes are a special instance of a 'list_item' that start with a 'shortcut_link'.
        -- There are two special states for unchecked & checked defined in the markdown grammar.

        -- Turn on / off checkbox state rendering.
        enabled = true,
        -- Additional modes to render checkboxes.
        render_modes = false,
        -- Render the bullet point before the checkbox.
        bullet = false,
        -- Padding to add to the right of checkboxes.
        right_pad = 1,
        unchecked = {
          -- Replaces '[ ]' of 'task_list_marker_unchecked'.
          icon = "󰄱 ",
          -- Highlight for the unchecked icon.
          highlight = "RenderMarkdownUnchecked",
          -- Highlight for item associated with unchecked checkbox.
          scope_highlight = nil,
        },
        checked = {
          -- Replaces '[x]' of 'task_list_marker_checked'.
          icon = "󰱒 ",
          -- Highlight for the checked icon.
          highlight = "RenderMarkdownChecked",
          -- Highlight for item associated with checked checkbox.
          scope_highlight = nil,
        },
        -- Define custom checkbox states, more involved, not part of the markdown grammar.
        -- As a result this requires neovim >= 0.10.0 since it relies on 'inline' extmarks.
        -- The key is for healthcheck and to allow users to change its values, value type below.
        -- | raw             | matched against the raw text of a 'shortcut_link'           |
        -- | rendered        | replaces the 'raw' value when rendering                     |
        -- | highlight       | highlight for the 'rendered' icon                           |
        -- | scope_highlight | optional highlight for item associated with custom checkbox |
        -- stylua: ignore
        custom = {
            todo = { raw = '[-]', rendered = '󰥔 ', highlight = 'RenderMarkdownTodo', scope_highlight = nil },
        },
      },
      quote = {
        -- Turn on / off block quote & callout rendering.
        enabled = true,
        -- Additional modes to render quotes.
        render_modes = false,
        -- Replaces '>' of 'block_quote'.
        icon = "▋",
        -- Whether to repeat icon on wrapped lines. Requires neovim >= 0.10. This will obscure text
        -- if incorrectly configured with :h 'showbreak', :h 'breakindent' and :h 'breakindentopt'.
        -- A combination of these that is likely to work follows.
        -- | showbreak      | '  ' (2 spaces)   |
        -- | breakindent    | true              |
        -- | breakindentopt | '' (empty string) |
        -- These are not validated by this plugin. If you want to avoid adding these to your main
        -- configuration then set them in win_options for this plugin.
        repeat_linebreak = false,
        -- Highlight for the quote icon.
        -- If a list is provided output is evaluated by `cycle(value, level)`.
        highlight = {
          "RenderMarkdownQuote1",
          "RenderMarkdownQuote2",
          "RenderMarkdownQuote3",
          "RenderMarkdownQuote4",
          "RenderMarkdownQuote5",
          "RenderMarkdownQuote6",
        },
      },
      pipe_table = {
        -- Turn on / off pipe table rendering.
        enabled = true,
        -- Additional modes to render pipe tables.
        render_modes = false,
        -- Pre configured settings largely for setting table border easier.
        -- | heavy  | use thicker border characters     |
        -- | double | use double line border characters |
        -- | round  | use round border corners          |
        -- | none   | does nothing                      |
        preset = "none",
        -- Determines how individual cells of a table are rendered.
        -- | overlay | writes completely over the table, removing conceal behavior and highlights |
        -- | raw     | replaces only the '|' characters in each row, leaving the cells unmodified |
        -- | padded  | raw + cells are padded to maximum visual width for each column             |
        -- | trimmed | padded except empty space is subtracted from visual width calculation      |
        cell = "padded",
        -- Adjust the computed width of table cells using custom logic.
        cell_offset = function()
          return 0
        end,
        -- Amount of space to put between cell contents and border.
        padding = 1,
        -- Minimum column width to use for padded or trimmed cell.
        min_width = 0,
        -- Characters used to replace table border.
        -- Correspond to top(3), delimiter(3), bottom(3), vertical, & horizontal.
        -- stylua: ignore
        border = {
            '┌', '┬', '┐',
            '├', '┼', '┤',
            '└', '┴', '┘',
            '│', '─',
        },
        -- Turn on / off top & bottom lines.
        border_enabled = true,
        -- Always use virtual lines for table borders instead of attempting to use empty lines.
        -- Will be automatically enabled if indentation module is enabled.
        border_virtual = true,
        -- Gets placed in delimiter row for each column, position is based on alignment.
        alignment_indicator = "━",
        -- Highlight for table heading, delimiter, and the line above.
        head = "RenderMarkdownTableHead",
        -- Highlight for everything else, main table rows and the line below.
        row = "RenderMarkdownTableRow",
        -- Highlight for inline padding used to add back concealed space.
        filler = "RenderMarkdownTableFill",
        -- Determines how the table as a whole is rendered.
        -- | none   | { enabled = false }        |
        -- | normal | { border_enabled = false } |
        -- | full   | uses all default values    |
        style = "full",
      },
      callout = {
        -- Callouts are a special instance of a 'block_quote' that start with a 'shortcut_link'.
        -- The key is for healthcheck and to allow users to change its values, value type below.
        -- | raw        | matched against the raw text of a 'shortcut_link', case insensitive |
        -- | rendered   | replaces the 'raw' value when rendering                             |
        -- | highlight  | highlight for the 'rendered' text and quote markers                 |
        -- | quote_icon | optional override for quote.icon value for individual callout       |
        -- | category   | optional metadata useful for filtering                              |

        note = {
          raw = "[!NOTE]",
          rendered = "󰋽 Note",
          highlight = "RenderMarkdownInfo",
          category = "github",
        },
        tip = {
          raw = "[!TIP]",
          rendered = "󰌶 Tip",
          highlight = "RenderMarkdownSuccess",
          category = "github",
        },
        important = {
          raw = "[!IMPORTANT]",
          rendered = "󰅾 Important",
          highlight = "RenderMarkdownHint",
          category = "github",
        },
        warning = {
          raw = "[!WARNING]",
          rendered = "󰀪 Warning",
          highlight = "RenderMarkdownWarn",
          category = "github",
        },
        caution = {
          raw = "[!CAUTION]",
          rendered = "󰳦 Caution",
          highlight = "RenderMarkdownError",
          category = "github",
        },
        -- Obsidian: https://help.obsidian.md/Editing+and+formatting/Callouts
        abstract = {
          raw = "[!ABSTRACT]",
          rendered = "󰨸 Abstract",
          highlight = "RenderMarkdownInfo",
          category = "obsidian",
        },
        summary = {
          raw = "[!SUMMARY]",
          rendered = "󰨸 Summary",
          highlight = "RenderMarkdownInfo",
          category = "obsidian",
        },
        tldr = {
          raw = "[!TLDR]",
          rendered = "󰨸 Tldr",
          highlight = "RenderMarkdownInfo",
          category = "obsidian",
        },
        info = {
          raw = "[!INFO]",
          rendered = "󰋽 Info",
          highlight = "RenderMarkdownInfo",
          category = "obsidian",
        },
        todo = {
          raw = "[!TODO]",
          rendered = "󰗡 Todo",
          highlight = "RenderMarkdownInfo",
          category = "obsidian",
        },
        hint = {
          raw = "[!HINT]",
          rendered = "󰌶 Hint",
          highlight = "RenderMarkdownSuccess",
          category = "obsidian",
        },
        success = {
          raw = "[!SUCCESS]",
          rendered = "󰄬 Success",
          highlight = "RenderMarkdownSuccess",
          category = "obsidian",
        },
        check = {
          raw = "[!CHECK]",
          rendered = "󰄬 Check",
          highlight = "RenderMarkdownSuccess",
          category = "obsidian",
        },
        done = {
          raw = "[!DONE]",
          rendered = "󰄬 Done",
          highlight = "RenderMarkdownSuccess",
          category = "obsidian",
        },
        question = {
          raw = "[!QUESTION]",
          rendered = "󰘥 Question",
          highlight = "RenderMarkdownWarn",
          category = "obsidian",
        },
        help = {
          raw = "[!HELP]",
          rendered = "󰘥 Help",
          highlight = "RenderMarkdownWarn",
          category = "obsidian",
        },
        faq = {
          raw = "[!FAQ]",
          rendered = "󰘥 Faq",
          highlight = "RenderMarkdownWarn",
          category = "obsidian",
        },
        attention = {
          raw = "[!ATTENTION]",
          rendered = "󰀪 Attention",
          highlight = "RenderMarkdownWarn",
          category = "obsidian",
        },
        failure = {
          raw = "[!FAILURE]",
          rendered = "󰅖 Failure",
          highlight = "RenderMarkdownError",
          category = "obsidian",
        },
        fail = {
          raw = "[!FAIL]",
          rendered = "󰅖 Fail",
          highlight = "RenderMarkdownError",
          category = "obsidian",
        },
        missing = {
          raw = "[!MISSING]",
          rendered = "󰅖 Missing",
          highlight = "RenderMarkdownError",
          category = "obsidian",
        },
        danger = {
          raw = "[!DANGER]",
          rendered = "󱐌 Danger",
          highlight = "RenderMarkdownError",
          category = "obsidian",
        },
        error = {
          raw = "[!ERROR]",
          rendered = "󱐌 Error",
          highlight = "RenderMarkdownError",
          category = "obsidian",
        },
        bug = {
          raw = "[!BUG]",
          rendered = "󰨰 Bug",
          highlight = "RenderMarkdownError",
          category = "obsidian",
        },
        example = {
          raw = "[!EXAMPLE]",
          rendered = "󰉹 Example",
          highlight = "RenderMarkdownHint",
          category = "obsidian",
        },
        quote = {
          raw = "[!QUOTE]",
          rendered = "󱆨 Quote",
          highlight = "RenderMarkdownQuote",
          category = "obsidian",
        },
        cite = {
          raw = "[!CITE]",
          rendered = "󱆨 Cite",
          highlight = "RenderMarkdownQuote",
          category = "obsidian",
        },
      },
      link = {
        -- Turn on / off inline link icon rendering.
        enabled = true,
        -- Additional modes to render links.
        render_modes = false,
        -- How to handle footnote links, start with a '^'.
        footnote = {
          -- Turn on / off footnote rendering.
          enabled = true,
          -- Replace value with superscript equivalent.
          superscript = true,
          -- Added before link content.
          prefix = "",
          -- Added after link content.
          suffix = "",
        },
        -- Inlined with 'image' elements.
        image = "󰥶 ",
        -- Inlined with 'email_autolink' elements.
        email = "󰀓 ",
        -- Fallback icon for 'inline_link' and 'uri_autolink' elements.
        hyperlink = "󰌹 ",
        -- Applies to the inlined icon as a fallback.
        highlight = "RenderMarkdownLink",
        -- Applies to WikiLink elements.
        wiki = {
          icon = "󱗖 ",
          body = function()
            return nil
          end,
          highlight = "RenderMarkdownWikiLink",
          scope_highlight = nil,
        },
        -- Define custom destination patterns so icons can quickly inform you of what a link
        -- contains. Applies to 'inline_link', 'uri_autolink', and wikilink nodes. When multiple
        -- patterns match a link the one with the longer pattern is used.
        -- The key is for healthcheck and to allow users to change its values, value type below.
        -- | pattern   | matched against the destination text                            |
        -- | icon      | gets inlined before the link text                               |
        -- | kind      | optional determines how pattern is checked                      |
        -- |           | pattern | @see :h lua-patterns, is the default if not set       |
        -- |           | suffix  | @see :h vim.endswith()                                |
        -- | priority  | optional used when multiple match, uses pattern length if empty |
        -- | highlight | optional highlight for 'icon', uses fallback highlight if empty |
        custom = {
          web = { pattern = "^http", icon = "󰖟 " },
          discord = { pattern = "discord%.com", icon = "󰙯 " },
          github = { pattern = "github%.com", icon = "󰊤 " },
          gitlab = { pattern = "gitlab%.com", icon = "󰮠 " },
          google = { pattern = "google%.com", icon = "󰊭 " },
          neovim = { pattern = "neovim%.io", icon = " " },
          reddit = { pattern = "reddit%.com", icon = "󰑍 " },
          stackoverflow = { pattern = "stackoverflow%.com", icon = "󰓌 " },
          wikipedia = { pattern = "wikipedia%.org", icon = "󰖬 " },
          youtube = { pattern = "youtube%.com", icon = "󰗃 " },
        },
      },
      sign = {
        -- Turn on / off sign rendering.
        enabled = true,
        -- Applies to background of sign text.
        highlight = "RenderMarkdownSign",
      },
      inline_highlight = {
        -- Mimics Obsidian inline highlights when content is surrounded by double equals.
        -- The equals on both ends are concealed and the inner content is highlighted.

        -- Turn on / off inline highlight rendering.
        enabled = true,
        -- Additional modes to render inline highlights.
        render_modes = false,
        -- Applies to background of surrounded text.
        highlight = "RenderMarkdownInlineHighlight",
      },
      indent = {
        -- Mimic org-indent-mode behavior by indenting everything under a heading based on the
        -- level of the heading. Indenting starts from level 2 headings onward by default.

        -- Turn on / off org-indent-mode.
        enabled = false,
        -- Additional modes to render indents.
        render_modes = false,
        -- Amount of additional padding added for each heading level.
        per_level = 2,
        -- Heading levels <= this value will not be indented.
        -- Use 0 to begin indenting from the very first level.
        skip_level = 1,
        -- Do not indent heading titles, only the body.
        skip_heading = false,
        -- Prefix added when indenting, one per level.
        icon = "▎",
        -- Priority to assign to extmarks.
        priority = 0,
        -- Applied to icon.
        highlight = "RenderMarkdownIndent",
      },
      html = {
        -- Turn on / off all HTML rendering.
        enabled = true,
        -- Additional modes to render HTML.
        render_modes = false,
        comment = {
          -- Turn on / off HTML comment concealing.
          conceal = true,
          -- Optional text to inline before the concealed comment.
          text = nil,
          -- Highlight for the inlined text.
          highlight = "RenderMarkdownHtmlComment",
        },
        -- HTML tags whose start and end will be hidden and icon shown.
        -- The key is matched against the tag name, value type below.
        -- | icon      | gets inlined at the start |
        -- | highlight | highlight for the icon    |
        tag = {},
      },
      win_options = {
        -- Window options to use that change between rendered and raw view.

        -- @see :h 'conceallevel'
        conceallevel = {
          -- Used when not being rendered, get user setting.
          default = vim.o.conceallevel,
          -- Used when being rendered, concealed text is completely hidden.
          rendered = 3,
        },
        -- @see :h 'concealcursor'
        concealcursor = {
          -- Used when not being rendered, get user setting.
          default = vim.o.concealcursor,
          -- Used when being rendered, show concealed text in all modes.
          rendered = "",
        },
      },
      overrides = {
        -- More granular configuration mechanism, allows different aspects of buffers to have their own
        -- behavior. Values default to the top level configuration if no override is provided. Supports
        -- the following fields:
        --   enabled, render_modes, max_file_size, debounce, anti_conceal, bullet, callout, checkbox,
        --   code, dash, document, heading, html, indent, inline_highlight, latex, link, padding,
        --   paragraph, pipe_table, quote, sign, win_options, yaml

        -- Override for different buflisted values, @see :h 'buflisted'.
        buflisted = {},
        -- Override for different buftype values, @see :h 'buftype'.
        buftype = {
          nofile = {
            render_modes = true,
            padding = { highlight = "NormalFloat" },
            sign = { enabled = false },
          },
        },
        -- Override for different filetype values, @see :h 'filetype'.
        filetype = {},
      },
      custom_handlers = {
        -- Mapping from treesitter language to user defined handlers.
        -- @see [Custom Handlers](doc/custom-handlers.md)
      },
      yaml = {
        -- Turn on / off all yaml rendering.
        enabled = true,
        -- Additional modes to render yaml.
        render_modes = false,
      },
    },
  },

  -- f-person/git-blame.nvim
  {
    "f-person/git-blame.nvim",
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "s1n7ax/nvim-window-picker",
      opts = {},
    },
    keys = {},
    opts = {
      buffers = {
        -- This will find and focus the file in the active buffer every time
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
        group_empty_dirs = true, -- when true, empty folders will be grouped together
        show_unloaded = true,
        window = {
          mappings = {
            ["<cr>"] = "open",
            ["d"] = "buffer_delete",
            ["s"] = "split_with_window_picker",
            ["t"] = "open_tabnew",
            ["w"] = "open_with_window_picker",
            ["v"] = "vsplit_with_window_picker",
            ["oc"] = { "order_by_created", nowait = false },
            ["od"] = { "order_by_diagnostics", nowait = false },
            ["om"] = { "order_by_modified", nowait = false },
            ["on"] = { "order_by_name", nowait = false },
            ["os"] = { "order_by_size", nowait = false },
            ["ot"] = { "order_by_type", nowait = false },
            ["P"] = {
              "toggle_preview", -- Enter preview mode, which shows the current file or directory in a floating window
              config = {
                float_config = { border = "rounded" }, -- see `:h nvim_open_win` for details on borders
                use_float = true, -- If false, will use a split window instead of a floating window
                use_image_nvim = false, -- If true, will use image.nvim to render image files instead of opening them
              },
            },
          },
        },
      },
      close_if_last_window = true,
      commands = {},
      default_component_configs = {
        container = {
          enable_character_fade = true,
        },
        git_status = {
          symbols = {
            -- Change type
            added = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
            deleted = "✖", -- This can only be used in the git_status source
            renamed = "➜", -- This can only be used in the git_status source
            -- Status type
            untracked = "★",
            ignored = "◌",
            unstaged = "✗",
            staged = "✓",
            conflict = "",
          },
          window = {
            position = "float",
            mappings = {
              ["A"] = "git_add_all",
              ["gu"] = "git_unstage_file",
              ["ga"] = "git_add_file",
              ["gr"] = "git_revert_file",
              ["gc"] = "git_commit",
              ["gp"] = "git_push",
              ["gg"] = "git_commit_and_push",
              ["?"] = "show_help",
            },
          },
        },
        icon = {
          default = "",
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
          highlight = "NeoTreeFileIcon",
          ---@diagnostic disable-next-line: unused-local
          provider = function(icon, node, state) -- Default icon provider utilizes nvim-web-devicons if available
            if node.type == "file" or node.type == "terminal" then
              local success, web_devicons = pcall(require, "nvim-web-devicons")
              local name = node.type == "terminal" and "terminal" or node.name
              if success then
                local devicon, hl = web_devicons.get_icon(name)
                icon.text = devicon or icon.text
                icon.highlight = hl or icon.highlight
              end
            end
          end,
          symlink = "",
        },
        ident = {
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
          highlight = "NeoTreeIndentMarker",
          ident_marker = "│",
          ident_size = 2,
          last_ident_marker = "└",
          padding = 1,
          with_expanders = nil,
          with_markers = true,
        },
        modified = {
          symbol = "●",
          highlight = "NeoTreeModified",
        },
        name = {
          highlight = "NeoTreeFileName",
          trailing_slash = false,
          use_git_status_colors = true,
        },
      },
      file_system = {
        filtered_items = {
          visible = false, -- when true, they will just be displayed differently than normal items
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_hidden = true, -- Only works on Windows for hidden files/directories
          hide_by_name = {
            "node_modules",
            ".DS_Store",
            "thumbs.db",
            ".vim",
            ".idea",
            ".vscode",
            ".pytest_cache",
            ".pycache",
            ".pyc",
          },
          hide_by_pattern = {}, -- uses glob style patterns
          always_show = { -- Remains visible even if other settings would normally hide it
            ".gitignore",
          },
          never_show = {}, -- Remains hidden even if visible is toggled to true, this overrides always_show
          never_show_by_pattern = {}, -- uses glob style patterns
        },
        follow_current_file = false, -- This will find and focus the file in the active buffer every time
        group_empty_dirs = false, -- when true, empty folders will be grouped together
        hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
        use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes instead of relying on nvim autocmd events.
      },
      enable_diagnostics = true,
      enable_git_status = true,
      open_files_do_not_replace_types = { "terminal", "trouble", "qf", "edgy" }, -- when opening files, do not use windows containing these filetypes or buftypes
      open_files_using_relative_path = false, -- when true, uses relative path when opening files from the tree (relative to cwd)
      popup_border_style = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" }, -- "double", "rounded", "solid", "shadow", or a table of borders like { "╔", "═", "╗", "║", "╝", "═", "╚", "║" }
      window = {
        fuzzy_finder_mappings = {
          ["<C-n>"] = "move_cursor_down",
          ["<C-p>"] = "move_cursor_up",
          ["<esc>"] = "close",
        },
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        mappings = {
          ["<cr>"] = "open",
          ["<tab>"] = "toggle_node",
          ["?"] = "show_help",
          ["/"] = "",
          ["A"] = "add_directory", -- Also accepts the config table like `add`. This is a good way to create nested directories.
          ["a"] = {
            "add",
            -- Some commands may take optional config table, see `:h neo-tree-mappings` for details
            config = {
              show_path = "relative", -- "none", "relative", "absolute"
            },
          },
          ["C"] = "close_all_nodes",
          ["c"] = {
            "copy", -- takes text input for destination
            config = {
              show_path = "relative", -- "none", "relative", "absolute"
            },
          },
          ["d"] = "delete",
          ["f"] = "fuzzy_finder",
          ["h"] = "close_node",
          ["i"] = "show_file_details", -- toggle file details
          ["l"] = "open",
          ["m"] = {
            "move", -- takes text input for destination
            config = {
              show_path = "relative", -- "none", "relative", "absolute"
            },
          },
          ["P"] = {
            "toggle_preview", -- Enter preview mode, which shows the current file or directory in a floating window
            config = {
              float_config = { border = "rounded" }, -- see `:h nvim_open_win` for details on borders
              use_float = true, -- If false, will use a split window instead of a floating window
              use_image_nvim = true, -- If true, will use image.nvim to render image files instead of opening them
            },
          },
          ["p"] = "paste_from_clipboard",
          ["q"] = "close_window",
          ["r"] = "rename",
          ["s"] = "split_with_window_picker",
          ["t"] = "open_tabnew",
          ["w"] = "open_with_window_picker",
          ["v"] = "vsplit_with_window_picker",
          ["x"] = "cut_to_clipboard",
          ["y"] = "copy_to_clipboard",
          ["zM"] = "close_all_nodes",
          ["zR"] = "expand_all_nodes",
        },
        position = "left",
        width = 40,
      },
      sort_case_insensitive = false, -- Used when sorting files and directories in the tree
      sort_function = nil, -- Uses a custom function for sorting files and directories in the tree (see `:h neo-tree-sort-func` for details)
    },
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        always_show_bufferline = true,
        buffer_close_icon = "",
        close_command = "bdelete! %d",
        close_icon = "",
        color_icons = true,
        custom_filter = function(buf_number, buf_numbers)
          if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
            return true
          end
          if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
            return true
          end
          if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
            return true
          end
          if buf_numbers[1] ~= buf_number then
            return true
          end
        end,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, _, _)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        diagnostics_update_in_insert = true,
        get_element_icon = function(element)
          local icon, hl = require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = false })
          return icon, hl
        end,
        indicator = {
          style = "icon",
          icon = "▎",
        },
        left_trunc_marker = "",
        max_name_length = 18,
        max_prefix_length = 15,
        mode = "tabs",
        modified_icon = "●",
        name_formatter = function(buf) -- Buf contains a "name", "path" and "bufnr"
          -- remove extension from markdown files for example
          if buf.name:match("%.md") then
            return vim.fn.fnamemodify(buf.name, ":t:r")
          end
          -- or return the full path
          return buf.name
        end,
        numbers = function(opts)
          return string.format("%s|%s.)", opts.ordinal, opts.raise(opts.id))
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left",
          },
        },
        right_trunc_marker = "",
        separator_style = "slant",
        show_buffer_close_icons = true,
        show_buffer_icons = true,
        show_close_icon = false,
        show_tab_indicators = true,
        sort_by = "tabs",
        tab_size = 18,
      },
    },
  },
  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
    version = "*",
    opt = {
      -- type of hints you want to get following types are supported
      -- 'statusline-winbar' | 'floating-big-letter' | 'floating-letter'
      -- 'statusline-winbar' draw on 'statusline' if possible, if not 'winbar'
      -- will be 'floating-big-letter' draw big letter on a floating window
      -- 'floating-letter' draw letter on a floating window
      -- used
      hint = "statusline-winbar",

      -- when you go to window selection mode, status bar will show one of
      -- following letters on them so you can use that letter to select the window
      selection_chars = "FJDKSLA;CMRUEIWOQP",

      -- This section contains picker specific configurations
      picker_config = {
        -- Whether should select window by clicking left mouse button on it
        handle_mouse_click = false,
        statusline_winbar_picker = {
          -- You can change the display string in status bar.
          -- It supports '%' printf style. Such as `return char .. ': %f'` to display
          -- buffer file path. See :h 'stl' for details.
          ---@diagnostic disable-next-line: unused-local
          selection_display = function(char, windowid)
            return "%=" .. char .. "%="
          end,

          -- Whether you want to use winbar instead of the statusline
          -- "always" means to always use winbar,
          -- "never" means to never use winbar
          -- "smart" means to use winbar if cmdheight=0 and statusline if cmdheight > 0
          use_winbar = "never", -- "always" | "never" | "smart"
        },

        floating_big_letter = {
          -- Window picker plugin provides bunch of big letter fonts
          -- fonts will be lazy loaded as they are being requested
          -- additionally, user can pass in a table of fonts into font
          -- property to use instead

          font = "ansi-shadow", -- ansi-shadow |
        },
      },

      -- whether to show 'Pick window:' prompt
      show_prompt = true,

      -- Prompt message to show to get the user input
      prompt_message = "Pick window: ",

      -- If you want to manually filter out the windows, pass in a function that
      -- takes two parameters. You should return window ids that should be
      -- included in the selection
      -- EX:-
      -- function(window_ids, filters)
      --    -- folder the window_ids
      --    -- return only the ones you want to include
      --    return {1000, 1001}
      -- end
      filter_func = nil,

      -- Following filters are only applied when you are using the default filter
      -- defined by this plugin. If you pass in a function to "filter_func"
      -- property, you are on your own
      filter_rules = {
        -- when there is only one window available to pick from, use that window
        -- without prompting the user to select
        autoselect_one = true,

        -- Whether you want to include the window you are currently on to window
        -- selection or not
        include_current_win = false,

        -- Whether to include windows marked as unfocusable
        include_unfocusable_windows = false,

        -- filter using buffer options
        bo = {
          -- If the filetype is one of following, the window will be ignored
          filetype = { "NvimTree", "neo-tree", "notify", "snacks_notif" },

          -- If the filetype is one of following, the window will be ignored
          buftype = { "terminal" },
        },

        -- filter using window options
        wo = {},

        -- If the filepath contains one of following names, the window
        -- will be ignored
        file_path_contains = {},

        -- If the filename contains one of following names, the window will be
        -- ignored
        file_name_contains = {},
      },

      -- You can pass in the highlight name or a table of content to set as
      -- highlight
      highlights = {
        enabled = true,
        statusline = {
          focused = {
            fg = "#ededed",
            bg = "#e35e4f",
            bold = true,
          },
          unfocused = {
            fg = "#ededed",
            bg = "#44cc41",
            bold = true,
          },
        },
        winbar = {
          focused = {
            fg = "#ededed",
            bg = "#e35e4f",
            bold = true,
          },

          unfocused = {
            fg = "#ededed",
            bg = "#44cc41",
            bold = true,
          },
        },
      },
    },
  },
  {
    "SmiteshP/nvim-navic",
    opts = {
      highlight = true,
      separator = "  ",
      depth_limit = 5,
      depth_limit_indicator = "..",
      safe_output = true,
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      bigfile = {
        notify = true, -- show notification when big file detected
        size = 1.5 * 1024 * 1024, -- 1.5MB
        line_length = 1000, -- average line length (useful for minified files)
        -- Enable or disable features when big file detected
        ---@param ctx {buf: number, ft:string}
        setup = function(ctx)
          if vim.fn.exists(":NoMatchParen") ~= 0 then
            vim.cmd([[NoMatchParen]])
          end
          Snacks.util.wo(0, { foldmethod = "manual", statuscolumn = "", conceallevel = 0 })
          vim.b.minianimate_disable = true
          vim.schedule(function()
            if vim.api.nvim_buf_is_valid(ctx.buf) then
              vim.bo[ctx.buf].syntax = ctx.ft
            end
          end)
        end,
      },
      icons = {
        ERROR = " ",
        WARN = " ",
        INFO = " ",
        DEBUG = " ",
        TRACE = "✎ ",
      },
      image = {
        ---@class snacks.image.Config
        ---@field enabled? boolean enable image viewer
        ---@field wo? vim.wo|{} options for windows showing the image
        ---@field bo? vim.bo|{} options for the image buffer
        ---@field formats? string[]
        --- Resolves a reference to an image with src in a file (currently markdown only).
        --- Return the absolute path or url to the image.
        --- When `nil`, the path is resolved relative to the file.
        ---@field resolve? fun(file: string, src: string): string?
        ---@field convert? snacks.image.convert.Config
        formats = {
          "png",
          "jpg",
          "jpeg",
          "gif",
          "bmp",
          "webp",
          "tiff",
          "heic",
          "avif",
          "mp4",
          "mov",
          "avi",
          "mkv",
          "webm",
          "pdf",
        },
        force = true, -- try displaying the image, even if the terminal does not support it
        doc = {
          -- enable image viewer for documents
          -- a treesitter parser must be available for the enabled languages.
          enabled = true,
          -- render the image inline in the buffer
          -- if your env doesn't support unicode placeholders, this will be disabled
          -- takes precedence over `opts.float` on supported terminals
          inline = false,
          -- render the image in a floating window
          -- only used if `opts.inline` is disabled
          float = true,
          max_width = 80,
          max_height = 40,
          -- Set to `true`, to conceal the image text when rendering inline.
          -- (experimental)
          ---@param lang string tree-sitter language
          ---@param type snacks.image.Type image type
          conceal = function(lang, type)
            -- only conceal math expressions
            return type == "math"
          end,
        },
        img_dirs = { "img", "images", "assets", "static", "public", "media", "attachments" },
        -- window options applied to windows displaying image buffers
        -- an image buffer is a buffer with `filetype=image`
        wo = {
          wrap = false,
          number = false,
          relativenumber = false,
          cursorcolumn = false,
          signcolumn = "no",
          foldcolumn = "0",
          list = false,
          spell = false,
          statuscolumn = "",
        },
        cache = vim.fn.stdpath("cache") .. "/snacks/image",
        debug = {
          request = false,
          convert = false,
          placement = false,
        },
        env = { "kitty" },
        -- icons used to show where an inline image is located that is
        -- rendered below the text.
        icons = {
          math = "󰪚 ",
          chart = "󰄧 ",
          image = " ",
        },
        ---@class snacks.image.convert.Config
        convert = {
          notify = true, -- show a notification on error
          ---@type snacks.image.args
          mermaid = function()
            local theme = vim.o.background == "light" and "neutral" or "dark"
            return { "-i", "{src}", "-o", "{file}", "-t", theme, "-s", "{scale}" } -- "-b", "transparent",
          end,
          ---@type table<string,snacks.image.args>
          magick = {
            default = { "{src}[0]", "-scale", "1920x1080>" }, -- default for raster images
            vector = { "-density", 192, "{src}[0]" }, -- used by vector images like svg
            math = { "-density", 192, "{src}[0]", "-trim" },
            pdf = { "-density", 192, "{src}[0]", "-background", "white", "-alpha", "remove", "-trim" },
          },
        },
        math = {
          enabled = true, -- enable math expression rendering
          -- in the templates below, `${header}` comes from any section in your document,
          -- between a start/end header comment. Comment syntax is language-specific.
          -- * start comment: `// snacks: header start`
          -- * end comment:   `// snacks: header end`
          typst = {
            tpl = [[
        #set page(width: auto, height: auto, margin: (x: 2pt, y: 2pt))
        #show math.equation.where(block: false): set text(top-edge: "bounds", bottom-edge: "bounds")
        #set text(size: 12pt, fill: rgb("${color}"))
        ${header}
        ${content}]],
          },
          latex = {
            font_size = "Large", -- see https://www.sascha-frank.com/latex-font-size.html
            -- for latex documents, the doc packages are included automatically,
            -- but you can add more packages here. Useful for markdown documents.
            packages = { "amsmath", "amssymb", "amsfonts", "amscd", "mathtools" },
            tpl = [[
        \documentclass[preview,border=0pt,varwidth,12pt]{standalone}
        \usepackage{${packages}}
        \begin{document}
        ${header}
        { \${font_size} \selectfont
          \color[HTML]{${color}}
        ${content}}
        \end{document}]],
          },
        },
      },
      input = {},
      scroll = {
        enabled = false,
      },
    },
  },
  -- snrogers/mermaider
  {
    "snrogers/mermaider.nvim",
    dependencies = {
      "3rd/image.nvim", -- Required for image display
    },
    enabled = true,
    config = function()
      require("mermaider").setup({
        -- Mermaid CLI command
        -- mermaider_cmd = "npx -y -p @mermaid-js/mermaid-cli mmdc -i {{IN_FILE}} -o {{OUT_FILE}}.png -s 3",

        -- File locations
        temp_dir = vim.fn.expand("$HOME/.cache/mermaider"),

        -- Auto-rendering behavior
        auto_render = true, -- Auto render on save
        auto_render_on_open = true, -- Auto render when opening files
        auto_preview = true, -- Auto show preview after render
        throttle_delay = 500, -- Throttle auto-render (ms)

        -- Display settings
        inline_render = true, -- Inline vs split window
        max_width_window_percentage = 80, -- Max image width (% of window)
        max_height_window_percentage = 80, -- Max image height (% of window)

        -- Split window settings (when inline_render = false)
        split_direction = "vertical", -- "vertical" or "horizontal"
        split_width = 50, -- Split width percentage

        -- Mermaid styling
        theme = "forest", -- Mermaid theme
        background_color = "#1e1e2e", -- Background color
        mmdc_options = "", -- Additional CLI options

        -- Custom files
        css_file = nil, -- Path to custom CSS
        mermaid_config_file = nil, -- Path to mermaid config JSON
      })
    end,
    ft = { "mmd", "mermaid" },
  },
}
