-- Plugin configuration for nvim-lspconfig and nvim-cmreturn {
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Mason for managing LSP servers
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    -- Existing CMP dependencies
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
  },
  config = function()
    -- Initialize Mason
    require("mason").setup()

    -- Initialize Mason-LSPConfig
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "pyright", "clangd", "jdtls", "prismals" }, -- Match your servers
      automatic_installation = true,                                             -- Auto-install servers
    })

    -- LSP settings
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Define server configurations
    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT", -- For Neovim
            },
            diagnostics = {
              globals = { "vim" }, -- Recognize Neovim globals
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true), -- Include Neovim runtime files
              checkThirdParty = false,                           -- Avoid third-party prompts
            },
            telemetry = {
              enable = false, -- Disable telemetry
            },
          },
        },
      },
      pyright = {}, -- No specific settings needed
      ts_ls = {},   -- No specific settings needed
      clangd = {},  -- No specific settings needed
      jdtls = {},   -- No specific settings needed
    }

    -- Set up each server with its configuration
    for lsp, config in pairs(servers) do
      lspconfig[lsp].setup(vim.tbl_deep_extend("force", { capabilities = capabilities }, config))
    end

    -- CMP settings (unchanged from your config)
    local cmp = require("cmp")
    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
      }),
    })
  end,
}
