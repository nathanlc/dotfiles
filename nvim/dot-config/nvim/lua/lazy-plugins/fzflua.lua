return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local fzf = require("fzf-lua")
    local actions = require("fzf-lua.actions")

    fzf.setup({
      -- global options
      keymap = {
        builtin = {
          ["<Esc>"] = "abort",
          ["<C-o>"] = "toggle-preview",
          ["<C-j>"] = "preview-half-page-down",
          ["<C-k>"] = "preview-half-page-up",
        },
        fzf = {
          ["tab"] = "toggle",
          ["shift-tab"] = "toggle-all",
          ["ctrl-o"] = "toggle-preview",
          ["ctrl-n"] = "down",
          ["ctrl-p"] = "up",
          ["ctrl-h"] = "previous-history",
          ["ctrl-l"] = "next-history",
          ["ctrl-j"] = "preview-half-page-down",
          ["ctrl-k"] = "preview-half-page-up",
        },
      },
      winopts = {
        toggle_behavior = "extend",
        width = 1,
        height = 0.9,
        row = 1,
        preview = {
          layout = "vertical",
          vertical = "up:60%",
        },
      },
      actions = {
        files = {
          ["enter"]  = actions.file_edit_or_qf,
          ["ctrl-s"] = actions.file_split,
          ["ctrl-v"] = actions.file_vsplit,
          ["ctrl-t"] = actions.file_tabedit,
          ["ctrl-q"] = actions.file_sel_to_qf,
        }
      },
      -- picker specific options
      files = {
        cwd_prompt = false,
        winopts = {
          preview = {
            hidden = true,
          },
        },
        file_ignore_patterns = {
          "node_modules/",
          "dist/",
        },
        fzf_opts = {
          ['--history'] = vim.fn.stdpath("data") .. '/fzf-lua-files-history',
        },
      },
      buffers = {
        winopts = {
          preview = {
            hidden = true,
          }
        }
      },
      oldfiles = {
        include_current_session = false,
        winopts = {
          preview = {
            hidden = true,
          }
        }
      },
      grep = {
        fzf_opts = {
          ['--history'] = vim.fn.stdpath("data") .. '/fzf-lua-grep-history',
        },
      },
    })
  end
}
