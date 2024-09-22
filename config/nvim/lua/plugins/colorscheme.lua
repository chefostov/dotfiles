return {
  "catppuccin/nvim",
  priority = 1000, -- Висок приоритет, за да се зареди първо
  opts = function()
    return {
      transparent_background = true,
      custom_highlights = function(colors)
        return {
          Comment = { fg = colors.flamingo },
          TabLineSel = { bg = colors.pink },
          CmpBorder = { fg = colors.surface2 },
          Pmenu = { bg = colors.none },
          -- Конфигурация за курсор хайлайт
          CursorLine = { bg = colors.surface1, blend = 50 },
          ColorColumn = { bg = colors.surface1, blend = 50 },
          CursorLineNr = { fg = colors.pink, bold = true },
        }
      end,
    }
  end,
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd("colorscheme catppuccin") -- Задаване на темата след настройка
  end,
}
