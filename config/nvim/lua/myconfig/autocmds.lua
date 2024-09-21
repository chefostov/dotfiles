-- lua/myconfig/autocmds.lua
local M = {}

M.setup = function()
    -- Автоматично стартиране на Neotree, когато Neovim е стартиран в директория
    vim.api.nvim_create_autocmd("VimEnter", {
        pattern = "*",
        callback = function()
            -- Проверка дали има стартиран файл или директория
            local bufname = vim.fn.expand("%:p")
            if bufname == "" or vim.fn.isdirectory(bufname) == 1 then
                -- Стартиране на Neotree
                vim.cmd("Neotree show")
            end
        end,
    })
end

return M

