return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  { import = "nvchad.blink.lazyspec" },

  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
  			"vim", "lua", "vimdoc",
       "html", "css"
  		},
  	},
  },

  {
    "phaazon/hop.nvim",
    keys = {
      { "<leader><leader>s", "<cmd>HopChar2<cr>", mode = "n", desc = "Hop 2 chars" },
      { "<leader><leader>w", "<cmd>HopWord<cr>", mode = "n", desc = "Hop word forward" },
      { "<leader><leader>b", "<cmd>HopWordBC<cr>", mode = "n", desc = "Hop word backward" },
      { "<leader><leader>j", "<cmd>HopLineStartAC<cr>", mode = "n", desc = "Hop line down" },
      { "<leader><leader>k", "<cmd>HopLineStartBC<cr>", mode = "n", desc = "Hop line up" },
      { "<leader><leader>f", "<cmd>HopChar1AC<cr>", mode = "n", desc = "Hop char forward" },
      { "<leader><leader>F", "<cmd>HopChar1BC<cr>", mode = "n", desc = "Hop char backward" },
      { "<leader><leader>l", "<cmd>HopLine<cr>", mode = "n", desc = "Hop any line" },
      { "<leader><leader>c", "<cmd>HopChar1<cr>", mode = "n", desc = "Hop any char" },
    },
    config = function()
      require("hop").setup({
        keys = "etovxqpdygfblzhckisuran",
        case_insensitive = true,
      })
    end,
  },
}
