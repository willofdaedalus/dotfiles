vim.opt.guicursor = ""
-- leader key for vim
vim.g.mapleader = ' '

vim.keymap.set("n", "[c", function()
  require("treesitter-context").go_to_context()
end, { silent = true })

-- custom keymappings
-- copy to system clipboard
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("i", "JK", "<ESC>")
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set('n', '<leader>w', [[:%s/\s\+$//e<CR>]])
-- move selected text up or down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gvzz")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gvzz")
-- indent selected text faster
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- make file executable
vim.keymap.set("n", "<leader>x", ":!chmod +x %<CR>", { silent = true })
-- enter netrw
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader><leader>", ":so<CR>")
-- create a new file in current directory
vim.keymap.set("n", "<leader>n", ":!touch ")

-- imported from theprimeagen
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
-- neat keymaps again stolen from primeagen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- replace current text
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- remove trailing whitespace
vim.cmd([[
nnoremap <silent> <F5> :lua remove_trailing_whitespace()<CR>
]])

function remove_trailing_whitespace()
	local saved_search = vim.fn.getreg('/')
	vim.cmd([[
	let _s=@/ | %s/\s\+$//e | let @/=_s | nohl | unlet _s
	]])
	vim.fn.setreg('/', saved_search)
end
