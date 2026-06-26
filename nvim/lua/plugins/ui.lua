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
          -- "pdf",
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
}
