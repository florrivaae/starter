vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- Set diagnostics after VimEnter to ensure it runs after all plugins
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.diagnostic.config({
      virtual_text = false,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })
  end,
  once = true,
})

-- Show diagnostic
vim.keymap.set('n', '<leader>df', function()
  vim.diagnostic.open_float({
    border = "rounded",
    focusable = true,
    header = "Diagnostics:",
  })
end, { desc = "Show line diagnostics" })

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- Enable formatting on save for all LSP clients
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function(args)
    vim.lsp.buf.format({ async = false })
  end,
})

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- load lsp servers
vim.lsp.enable('clangd')

-- Use vim.defer_fn to ensure this runs after plugin initialization
vim.defer_fn(function()
  vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  })
end, 100)

-- use powershell for terminals within vim
vim.o.shell = 'powershell'

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)
