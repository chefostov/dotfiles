vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Инсталиране на lazy.nvim, ако не е инсталиран
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- последната стабилна версия
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Зареждане на плъгините чрез lazy.nvim
require("lazy").setup({
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
  { "lewis6991/gitsigns.nvim" },
  { "folke/tokyonight.nvim" },
  {  "nvim-neo-tree/neo-tree.nvim",
            branch = "v3.x",  -- използваме последната версия 3.x
            dependencies = {
                "nvim-lua/plenary.nvim",         -- задължителна зависимост
                "nvim-tree/nvim-web-devicons",   -- иконки (по избор)
                "MunifTanjim/nui.nvim",          -- NUI библиотеката (липсващата зависимост)
	}},
    {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        signs = {
          add          = { text = '│' },
          change       = { text = '󰚉' },
          delete       = { text = '󱔷' },
          topdelete    = { text = '󰈘' },
          changedelete = { text = '~' },
        },
        current_line_blame = true,  -- Показва вината за текущия ред
      }

      -- Настройка на highlight групите за Git статусите
      vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = '#00ff00' })  -- Зелен за добавени редове
      vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = '#ffff00' })  -- Жълт за променени редове
      vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = '#ff0000' })  -- Червен за изтрити редове
    end
},
    {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
    { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
    { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
    { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
    { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
  },
}
})

-- Зареждане на настройките
local options = require("myconfig.options")
if not options then
  print("Error loading options.lua")
else
  options.setup()
end

local keymaps = require("myconfig.keymaps")
if not keymaps then
  print("Error loading keymaps.lua")
else
  keymaps.setup()
end

local autocmds = require("myconfig.autocmds")
if not autocmds then
  print("Error loading autocmds.lua")
else
  autocmds.setup()
end
