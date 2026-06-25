return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        -- { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  { -- optional blink completion source for require statements and module annotations
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "Kaiser-Yang/blink-cmp-git",
      "Kaiser-Yang/blink-cmp-avante",
      "erooke/blink-cmp-latex",
    },
    opts = {
      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },
        keyword = {
          range = "full",
        },
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        list = {
          selection = {
            preselect = false,
            auto_insert = true,
          },
        },
        menu = {
          -- Don't automatically show the completion menu
          auto_show = true,

          -- nvim-cmp style menu
          draw = {
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind_icon", "kind" },
            },
          },
        },
        ghost_text = {
          enabled = true,
        },
      },
      sources = {
        -- add lazydev to your completion providers
        default = { "avante", "lazydev", "lsp", "latex", "path", "git", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
          git = {
            name = "Git",
            module = "blink-cmp-git",
            opts = {},
          },
          avante = {
            name = "Avante",
            module = "blink-cmp-avante",
            opts = {},
          },
          latex = {
            name = "Latex",
            module = "blink-cmp-latex",
            opts = {
              insert_command = true,
            },
          },
        },
      },
      signature = {
        enabled = true,
      },
      fuzzy = {
        implementation = "prefer_rust_with_warning",
      },
    },
    opts_extend = { "sources.default" },
  },

  -- yetone/avante.nvim
  {
    "yetone/avante.nvim",
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    -- ⚠️ must add this setting! ! !
    build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      -- add any opts here
      -- this file can contain specific instructions for your project
      instructions_file = "avante.md",
      -- for example
      provider = "copilot",
      providers = {
        claude = {
          endpoint = "https://api.anthropic.com",
          model = "claude-sonnet-4-20250514",
          timeout = 30000, -- Timeout in milliseconds
          extra_request_body = {
            temperature = 0.75,
            max_tokens = 20480,
          },
        },
        moonshot = {
          endpoint = "https://api.moonshot.ai/v1",
          model = "kimi-k2-0711-preview",
          timeout = 30000, -- Timeout in milliseconds
          extra_request_body = {
            temperature = 0.75,
            max_tokens = 32768,
          },
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-mini/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "stevearc/dressing.nvim", -- for input provider dressing
      {
        "folke/snacks.nvim",
        opts = {
          ---@class snacks.bigfile.Config
          ---@field enabled? boolean
          blame_line = {
            width = 0.6,
            height = 0.6,
            border = "rounded",
            title = " Git Blame ",
            title_pos = "center",
            ft = "git",
          },
        },
      }, -- for input provider snacks
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
    },
  },

  -- mfussenegger/nvim-dap
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")
      if not dap.adapters["codelldb"] then
        require("dap").adapters["codelldb"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "codelldb",
            args = { "--port", "${port}" },
            -- On windows you may have to uncomment this:
            -- detached = false,
          },
        }
      end
      for _, lang in ipairs({ "c", "cpp", "cc", "rust" }) do
        if not dap.configurations[lang] then
          dap.configurations[lang] = {}
        end
        vim.list_extend(dap.configurations[lang], {
          {
            name = "Launch file",
            type = "codelldb",
            request = "launch",
            program = function()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
          },
          {
            name = "Attach to process",
            type = "codelldb",
            request = "attach",
            pid = require("dap.utils").pick_process,
            args = {},
            cwd = "${workspaceFolder}",
          },
        })
      end
    end,
  },

  -- "mason-org/mason.nvim"
  {
    "mason-org/mason.nvim",
    opts = {},
  },

  -- williamboman/mason-lspconfig.nvim
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        keys = {
          { "<leader>cn", "<cmd>Navbuddy<cr>", desc = "Navbuddy" },
        },
        dependencies = {
          {
            "SmiteshP/nvim-navic",
            opts = {
              icons = {
                File = "󰈙 ",
                Module = " ",
                Namespace = "󰌗 ",
                Package = " ",
                Class = "󰌗 ",
                Method = "󰆧 ",
                Property = " ",
                Field = " ",
                Constructor = " ",
                Enum = "󰕘",
                Interface = "󰕘",
                Function = "󰊕 ",
                Variable = "󰆧 ",
                Constant = "󰏿 ",
                String = "󰀬 ",
                Number = "󰎠 ",
                Boolean = "◩ ",
                Array = "󰅪 ",
                Object = "󰅩 ",
                Key = "󰌋 ",
                Null = "󰟢 ",
                EnumMember = " ",
                Struct = "󰌗 ",
                Event = " ",
                Operator = "󰆕 ",
                TypeParameter = "󰊄 ",
              },
              lsp = {
                auto_attach = true,
                preference = nil,
              },
              highlight = true,
              separator = " > ",
              depth_limit = 0,
              depth_limit_indicator = "..",
              safe_output = true,
              lazy_update_context = false,
              click = false,
              format_text = function(text)
                return text
              end,
            },
          },
          "MunifTanjim/nui.nvim",
        },
        opts = {
          custom_hl_groups = nil,
          icons = {
            File = "󰈙 ",
            Module = " ",
            Namespace = "󰌗 ",
            Package = " ",
            Class = "󰌗 ",
            Method = "󰆧 ",
            Property = " ",
            Field = " ",
            Constructor = " ",
            Enum = "󰕘",
            Interface = "󰕘",
            Function = "󰊕 ",
            Variable = "󰆧 ",
            Constant = "󰏿 ",
            String = " ",
            Number = "󰎠 ",
            Boolean = "◩ ",
            Array = "󰅪 ",
            Object = "󰅩 ",
            Key = "󰌋 ",
            Null = "󰟢 ",
            EnumMember = " ",
            Struct = "󰌗 ",
            Event = " ",
            Operator = "󰆕 ",
            TypeParameter = "󰊄 ",
          },
          lsp = { auto_attach = true },
          node_markers = {
            enabled = true,
            icons = {
              leaf = "  ",
              leaf_selected = " → ",
              branch = " ",
            },
          },
          source_buffer = {
            follow_node = true,
            highlight = true,
            reorient = "smart",
            scrolloff = nil,
          },
          use_default_mappings = true,
          window = {
            border = "single", -- "rounded", "double", "solid", "none"
            -- or an array with eight chars building up the border in a clockwise fashion
            -- starting with the top-left corner. eg: { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" }.
            size = "60%", -- Or table format example: { height = "40%", width = "100%"}
            position = "50%", -- Or table format example: { row = "100%", col = "0%"}
            scrolloff = nil, -- scrolloff value within navbuddy window
            sections = {
              left = {
                size = "20%",
                border = nil, -- You can set border style for each section individually as well.
              },
              mid = {
                size = "40%",
                border = nil,
              },
              right = {
                -- No size option for right most section. It fills to
                -- remaining area.
                border = nil,
                preview = "leaf", -- Right section can show previews too.
                -- Options: "leaf", "always" or "never"
              },
            },
          },
        },
      },
    },
    -- opts = {
    --   servers = {
    --     ['*'] = {
    --       keys = {
    --         {"gd", "<cmd>telescope."}
    --       }
    --     }
    --   }
    -- }
    opts = {
      -- local Keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- vim.list_extend(Keys, {
      servers = {
        ["*"] = {
          {
            "gd",
            function()
              require("telescope.builtin").lsp_definitions({
                reuse_win = false,
              })
            end,
            desc = "Goto Definition (Telescope)",
          },
          { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
          {
            "gr",
            function()
              require("telescope.builtin").lsp_references()
            end,
            desc = "Goto References (Telescope)",
          },
          {
            "go",
            function()
              require("telescope.builtin").lsp_outgoing_calls()
            end,
            desc = "List Outgoing Calls (Telescope)",
          },
          {
            "gi",
            function()
              require("telescope.builtin").lsp_implementations()
            end,
            desc = "Goto Implementation (Telescope)",
          },
          {
            "gt",
            function()
              require("telescope.builtin").lsp_type_definitions()
            end,
            desc = "Goto Type Definition (Telescope)",
          },
        },
      },
    },
  },

  -- jay-babu/mason-nvim-dap.nvim
  {
    "jay-babu/mason-nvim-dap.nvim",
  },

  -- danymat/neogen
  {
    "danymat/neogen",
    config = true,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
  },
}
