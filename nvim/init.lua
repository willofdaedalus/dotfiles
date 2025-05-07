-- Set <Space> as the leader key
vim.g.mapleader = ' '

-- THICK CURSOR
vim.opt.guicursor = "n-v-i-c:block-Cursor"

-- Load plugin configurations from a separate file
require('plugins')

-- General Editor Settings
vim.opt.nu = true
vim.opt.rnu = true
vim.opt.hlsearch = false     -- No highlight on search
vim.opt.wrap = false         -- Disable line wrapping
vim.opt.tabstop = 4          -- Set tab width
vim.opt.shiftwidth = 4
vim.opt.expandtab = false    -- Use hard tabs (change to true if needed)
vim.opt.ruler = true
vim.opt.scrolloff = 8        -- Keep cursor 8 lines away from screen edge
vim.opt.termguicolors = true -- Enable true color
vim.opt.updatetime = 50      -- Faster UI response
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 4

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.opt.undofile = true
vim.opt.breakindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.confirm = true

vim.opt.clipboard = 'unnamedplus'
-- Clipboard Sync with System
vim.keymap.set('n', '<leader>x', ':!chmod +x %<CR>')

-- -- yank to the clipboard
-- vim.keymap.set({ "n", "v", "x" }, '<leader>y', '"+y')
-- vim.keymap.set({ "n", "v", "x" }, '<leader>p', '"+p')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>') -- Clear search highlight
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
vim.keymap.set('n', '<C-h>', '<C-w><C-h>')
vim.keymap.set('n', '<C-l>', '<C-w><C-l>')
vim.keymap.set('n', '<C-j>', '<C-w><C-j>')
vim.keymap.set('n', '<C-k>', '<C-w><C-k>')



-- Better Navigation & Editing
vim.keymap.set('n', 'x', '"_x') -- Delete without yanking
vim.keymap.set('i', 'jk', '<ESC>')
vim.keymap.set('i', 'JK', '<ESC>')
vim.keymap.set('n', '<leader>w', [[:%s/\s\+$//e<CR>]]) -- Trim trailing whitespace
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gvzz")         -- Move selected text down
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gvzz")         -- Move selected text up
vim.keymap.set('v', '<', '<gv')                        -- Indent left
vim.keymap.set('v', '>', '>gv')                        -- Indent right
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)          -- Open file explorer
vim.keymap.set('n', '<C-d>', '<C-d>zz')                -- Center after page down
vim.keymap.set('n', '<C-u>', '<C-u>zz')                -- Center after page up
vim.keymap.set('n', 'n', 'nzz')                        -- Keep search results centered
vim.keymap.set('n', 'N', 'Nzz')

-- Replace current word everywhere
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])


require("catppuccin").setup({
    integrations = {
        cmp = true,
        fzf = true,
        gitsigns = true,
        neogit = true,
        harpoon = true,
        treesitter = true,
        treesitter_context = true,
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
                ok = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
                ok = { "underline" },
            },
            inlay_hints = {
                background = true,
            },
        },
    }
})
vim.cmd.colorscheme "catppuccin-macchiato"


-- HARPOON STUFF
local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
