-- lua/myconfig/keymaps.lua
local M = {}

M.setup = function()
    local map = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }

    -- Примерни клавишни комбинации
    map("n", "<leader>ff", ":Telescope find_files<CR>", opts)
    map("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
    -- togglе-ва Neotree
    map("n", "<leader>e", ":Neotree toggle<CR>", opts) 
    -- Клавишни комбинации за навигация между сплитове
    map("n", "<leader>l", "<C-w>h", opts)  -- Лидер + л за преминаване към левия сплит
    map("n", "<leader>r", "<C-w>l", opts)  -- Лидер + р за преминаване към десния сплит
 -- Клавишна комбинация за toggle между сплитовете
    map("n", "<leader>s", ":lua ToggleSplitFocus()<CR>", opts)  -- Лидер + s за смяна на фокуса между сплитове
     -- Клавишна комбинация за създаване на нов вертикален сплит
    map("n", "<leader>v", ":vs<CR>", opts)  -- Лидер + v за нов вертикален сплит
end
-- Функция за toggle между основните сплитове (без Neotree)
function ToggleSplitFocus()
    local current_win = vim.fn.winnr()  -- Взимаме текущия прозорец
    local total_wins = vim.fn.winnr('$')  -- Общ брой прозорци (сплитове)

    -- Въртим през всички прозорци, за да намерим основните сплитове
    for i = 1, total_wins do
        local buftype = vim.fn.getbufvar(vim.fn.winbufnr(i), "&filetype")
        
        -- Пропускаме Neotree или други специфични буфери
        if buftype ~= "neo-tree" then
            -- Ако текущият прозорец е 1 (ляв), премини към десния, и обратно
            if current_win == i then
                if current_win == 1 then
                    vim.cmd("wincmd l")  -- Преминава към десния сплит
                else
                    vim.cmd("wincmd h")  -- Преминава към левия сплит
                end
                break
            end
        end
    end
end
return M

