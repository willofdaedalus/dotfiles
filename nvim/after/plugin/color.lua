require('onedark').setup {
    style = 'deep',
	transparent = true
}
require('onedark').load()

function EnableBackColor(color)
	color = color or "onedark"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

end

EnableBackColor()
