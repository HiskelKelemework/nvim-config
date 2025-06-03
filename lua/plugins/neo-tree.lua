-- Plugin configuration for neo-tree.nvim
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      enable_git_status = true,
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        sync_root_with_cwd = true,     -- Sync tree root with Neovim's current working directory
        follow_current_file = {
          enabled = true,              -- Automatically focus the file in the active buffer
          leave_dirs_open = false,     -- Close auto-expanded directories when focusing a file
        },
        use_libuv_file_watcher = true, -- Use OS-level file watchers for better performance
        filtered_items = {
          visible = false,             -- Hide filtered items by default
          hide_dotfiles = true,        -- Hide dotfiles (e.g., .git, .gitignore)
          hide_gitignored = true,      -- Respect .gitignore
          hide_by_name = {             -- Specific files/directories to hide
            'node_modules',
            'dist',
            '.DS_Store',
          },
          always_show = { -- Always show these, even if filtered
            '.gitignore',
          },
        }
      },
      default_component_configs = {
        git_status = {
          symbols = {
            added = "✚",
            modified = "✹",
            deleted = "✖",
            renamed = "➜",
            untracked = "★",
            ignored = "◌",
            unstaged = "✗",
            staged = "✓",
            conflict = "",
          },
        },
      },
      window = {
        position = "right",
        width = 40,
      },
    })
  end,
}
