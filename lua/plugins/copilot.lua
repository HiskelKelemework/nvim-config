return {
  "github/copilot.vim",
  build = ":Copilot auth",                                  -- Runs auth on first install (one-time)
  cmd = { "Copilot", "Copilot enable", "Copilot disable" }, -- Lazy-load on these commands
  event = "InsertEnter",                                    -- Optional: Also load on insert mode entry
  config = function()
    vim.g.copilot_no_tab_map = true                         -- Avoid overriding Tab (customize as needed)
  end,
}
