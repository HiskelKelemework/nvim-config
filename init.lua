-- Neovim configuration optimized for QWERTY keyboard
-- File: ~/.config/nvim/init.lua
-- Set leader key to space for QWERTY-friendly access
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic settings for performance and usability
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.number = true             -- Show line numbers
vim.opt.relativenumber = true     -- Relative line numbers
vim.opt.tabstop = 2               -- 2 spaces for tabs
vim.opt.shiftwidth = 2            -- 2 spaces for indent
vim.opt.expandtab = true          -- Use spaces instead of tabs
vim.opt.smartindent = true        -- Smart indentation
vim.opt.wrap = false              -- Disable line wrap
vim.opt.termguicolors = true      -- Enable 24-bit RGB colors
vim.opt.cursorline = true         -- Highlight current line
vim.opt.clipboard = "unnamedplus" -- Sync with system clipboard

-- set ripgrep to be the default grep
vim.o.grepprg = "rg --vimgrep --smart-case"
vim.o.grepformat = "%f:%l:%c:%m"

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- enable matchit to enhance brace/parenthesis matching
vim.g.loaded_matchit = 1
vim.cmd("packadd matchit")

-- Diagnostic Config
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
}

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup("plugins")

-- Load keymaps
require("remap")
