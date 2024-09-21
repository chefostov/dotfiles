-- lua/myconfig/options.lua
local M = {}

M.setup = function()
    -- Деактивиране на netrw, за да не се стартира
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- Задаване на Space като лидер кий
    vim.g.mapleader = " "  -- Лидер кий е Space
    vim.g.maplocalleader = " "  -- Локален лидер кий също е Space

    -- Хибридни номера
    vim.opt.number = true
    vim.opt.relativenumber = true 

    -- Показва пълния път до файла в статус линията
    vim.opt.statusline = "%f %y %m %= %l:%c %p%%"

    -- Табове и отстъпи
    vim.opt.expandtab = true         -- Преобразува табулациите в интервали
    vim.opt.shiftwidth = 4           -- Брой интервали за отстъп
    vim.opt.tabstop = 4              -- Дължина на табулацията в интервали
    vim.opt.smartindent = true       -- Интелигентно индентиране

    -- Търсене
    vim.opt.ignorecase = true        -- Игнориране на главни букви при търсене
    vim.opt.smartcase = true         -- При търсене с главни букви, разграничава малки/главни букви
    vim.opt.hlsearch = true          -- Маркиране на намерените съвпадения

    -- Визуални настройки
    vim.opt.termguicolors = true     -- Разрешаване на 24-битови цветове
    vim.opt.cursorline = true        -- Подчертаване на текущия ред

    -- Подобрения за производителността
    vim.opt.updatetime = 300         -- Намаляване на времето за изчакване преди обновяване

      -- Задаване на цветова тема
    vim.cmd("colorscheme tokyonight")  -- Тук задаваш темата, например Tokyo Night

    -- Допълнителни настройки за цветовата тема (ако има такива)
    vim.g.tokyonight_style = "night"    -- Стил за Tokyo Night (може да е "night", "storm", или "day")
    vim.g.tokyonight_transparent = true -- Прозрачност на фона
    -- Ако искаш да премахнеш фона и от други елементи (например лентата за състояние)
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })  -- Премахване на фона на нормалния текст
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })  -- Премахване на фона за плаващите прозорци
    -- Примерен HEX код за светлосиния цвят (замени го със своя)
    local custom_split_color = "#7aa2f7"  -- Можеш да смениш цвета със своя светлосин
    local border_color = "#7aa2f7"  -- Цветът за бордъра


    -- Задаване на цвят за вертикалните и хоризонталните разделители (сплитове)
    vim.api.nvim_set_hl(0, "VertSplit", { fg = custom_split_color, bg = "none" })
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = custom_split_color, bg = "none" })
    vim.opt.fillchars = { vert = "▏" }  -- Можеш да пробваш други символи като '┃', '╎', или '⎸'
    -- Премахване на фона за нормалния и плаващия текст
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
     -- Бордър за статус линията (outline)
    vim.api.nvim_set_hl(0, "StatusLine", { fg = "#7aa2f7", bg = "#222436", sp = border_color, underline = true })
    vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#aaaaaa", bg = "#1a1b26", sp = border_color, underline = true })


    -- Добавя глобален статус лайн за всички сплитове
    vim.opt.laststatus = 3
end

return M


