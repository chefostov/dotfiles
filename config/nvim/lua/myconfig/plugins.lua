-- lua/myconfig/plugins.lua
local M = {}

M.setup = function()
    require("lazy").setup({
        -- Добавяне на Neotree и неговите зависимости
        { 
            "nvim-neo-tree/neo-tree.nvim",
            branch = "v3.x",  -- използваме последната версия 3.x
            dependencies = {
                "nvim-lua/plenary.nvim",         -- задължителна зависимост
                "nvim-tree/nvim-web-devicons",   -- иконки (по избор)
                "MunifTanjim/nui.nvim",          -- NUI библиотеката
            },
            config = function()
                -- Тук добавяме настройките за Neotree
                require("neo-tree").setup({
                    filesystem = {
                        follow_current_file = true,    -- Автоматично следи активния файл
                        hijack_netrw_behavior = "open_current",  -- Използва Neotree вместо netrw
                        use_libuv_file_watcher = true, -- Автоматично обновяване при промяна на файлове
                    },
                    window = {
                        position = "left",            -- Позиция на прозореца
                        width = 30,                   -- Ширина на прозореца
                    },
                    default_component_configs = {
                        icon = {
                            folder_closed = "",       -- Икони за затворени папки
                            folder_open = "",         -- Икони за отворени папки
                            default = "*",             -- Икона по подразбиране за файлове
                        },
                    },
                })
            end,
        },
    })
end

return M

