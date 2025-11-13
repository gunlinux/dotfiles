return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects", -- For textobject functionality
    },

    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "python",
          "lua",
          "vim",
          "bash",
          "markdown",
          "markdown_inline",
          "vimdoc",
          "regex",
          "go",
          "html",
          "javascript",
          "typescript",
          "css",
          "json",
          "yaml",
          "toml",
          "jinja",
        },

        sync_install = false, -- Install parsers synchronously (for better startup experience)
        auto_install = true,
        auto_tag = {
          enable = true, -- Enable auto tagging for HTML/XML
        },

        highlight = {
          enable = true,
          disable = {},                              -- Disable highlighting for specific languages
          additional_vim_regex_highlighting = false, -- Use treesitter for all highlighting
        },

        indent = {
          enable = true, -- Enable treesitter-based indentation
        },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = "<c-s>",
            node_decremental = "<c-backspace>",
          },
        },

        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- Whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
        },
      })
      vim.filetype.add({
        extension = {
          htmx = "htmx",  -- объявляем отдельный filetype
        },
      })
      vim.treesitter.language.register("htmldjango", "htmx")
      vim.treesitter.language.register("htmldjango", "html")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    ft = { "python", "go", "lua", "html" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("treesitter-context").setup({
        enable = true,           -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 0,           -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 1,   -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 1, -- Maximum number of lines to show for a single context
        trim_scope = "outer",    -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = "topline",        -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20,
      })
    end,
  }
}
