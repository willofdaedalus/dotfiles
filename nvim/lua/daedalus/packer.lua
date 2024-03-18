-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use ('wbthomason/packer.nvim')

	use{
		'lukas-reineke/indent-blankline.nvim',
		commit = "9637670",
	}

	use('navarasu/onedark.nvim')
	use('wakatime/vim-wakatime')
	use('vlime/vlime')
	use('github/copilot.vim')
	use('nvim-lualine/lualine.nvim')
	use('mbbill/undotree')
	use('tpope/vim-fugitive')
	use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
	use('nvim-treesitter/nvim-treesitter-context')
	use('lewis6991/gitsigns.nvim')
	use('onsails/lspkind.nvim')
	use('stevearc/dressing.nvim')
	use('davisdude/vim-love-docs')
	use('OmniSharp/omnisharp-vim')
	use('ThePrimeagen/harpoon')
	use('joshdick/onedark.vim')
	use('mfussenegger/nvim-dap')
	use('vimwiki/vimwiki')
	use('mfussenegger/nvim-jdtls')

	use {
		'goolord/alpha-nvim',
		requires = { 'nvim-tree/nvim-web-devicons' },
		config = function ()
			require'alpha'.setup(require'alpha.themes.startify'.config)
		end
	}

	use('folke/tokyonight.nvim')
	use('ajmwagar/vim-deus')

	use {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	}

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},             -- Required
			{                                      -- Optional
			'williamboman/mason.nvim',
			run = function()
				pcall(vim.cmd, 'MasonUpdate')
			end,
		},
		{'williamboman/mason-lspconfig.nvim'}, -- Optional

		-- Autocompletion
		{'hrsh7th/nvim-cmp'},     -- Required
		{'hrsh7th/cmp-nvim-lsp'}, -- Required
		{'L3MON4D3/LuaSnip'},     -- Required
	}
}

	use({
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup()
		end,
	})
end)
