require("lsp_lines").setup()

-- Disable virtual_text since it's redundant due to lsp_lines.
vim.diagnostic.config({
	virtual_text = false,
	virtual_lines = { only_current_line = true },
})

vim.keymap.set("", "<Leader>l",require("lsp_lines").toggle,{ desc = "Toggle lsp_lines" })

