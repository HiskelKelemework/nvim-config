-- Plugin configuration for gitsigns.nvim
return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        vim.keymap.set("n", "<leader>gp", gs.preview_hunk, { buffer = bufnr, desc = "Preview git hunk" })
        vim.keymap.set("n", "<leader>gb", gs.toggle_current_line_blame, { buffer = bufnr, desc = "Toggle git blame" })
      end,
    })
  end,
}