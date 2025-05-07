-- Ensure lazy.nvim is installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git", "clone", "--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", lazypath
	})
end
vim.opt.rtp:prepend(lazypath)

local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }
	local fzf = require("fzf-lua")
	vim.keymap.set('n', 'gd', function() fzf.lsp_definitions() end, opts)
	vim.keymap.set('n', 'gr', function() fzf.lsp_references() end, opts)
	vim.keymap.set('n', 'gI', function() fzf.lsp_implementations() end, opts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
	vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, opts)
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
	vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
	vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
	vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
end

-- Initialize lazy.nvim with plugins
require("lazy").setup({
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" }
	},
	{
		"catppuccin/nvim",
		as = "catppuccin",
	},
	{
		"lewis6991/gitsigns.nvim",
	},
	{
		"williamboman/mason.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "pyright", "gopls", "lua_ls", "clangd", "rust_analyzer" },
				automatic_installation = true,
			})

			-- Set up null-ls for additional formatting/import functionality
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.goimports,
					null_ls.builtins.formatting.clang_format,
					null_ls.builtins.formatting.isort,
				},
			})

			-- Enhanced LSP setup with import configuration
			local lspconfig = require("lspconfig")

			-- Configure gopls with imports
			lspconfig.gopls.setup({
				on_attach = on_attach,
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
						gofumpt = true,
						usePlaceholders = true,
						completeUnimported = true,
						experimentalPostfixCompletions = true,
					},
				},
			})

			-- Configure rust-analyzer with imports
			lspconfig.rust_analyzer.setup({
				on_attach = on_attach,
				settings = {
					["rust-analyzer"] = {
						imports = {
							granularity = {
								group = "module",
							},
							prefix = "self",
						},
						cargo = {
							buildScripts = {
								enable = true,
							},
						},
						procMacro = {
							enable = true,
						},
						checkOnSave = {
							command = "clippy",
						},
					}
				}
			})
			-- Configure pyright with imports
			lspconfig.pyright.setup({
				on_attach = on_attach,
				settings = {
					python = {
						analysis = {
							autoSearchPaths = true,
							diagnosticMode = "workspace",
							useLibraryCodeForTypes = true
						}
					}
				}
			})

			-- Set up other LSPs with default config
			for _, server in ipairs({ "lua_ls", "clangd", "omnisharp" }) do
				lspconfig[server].setup({
					on_attach = on_attach,
				})
			end

			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = { "*.go", "*.rs", "*.py", "*.lua" },
				callback = function()
					vim.lsp.buf.format({ async = false })
				end,
			})
		end,
	},
	{
		"ibhagwan/fzf-lua",
		keys = {
			{ "<leader><leader>", function() require("fzf-lua").files() end },
			{ "<leader>/",        function() require("fzf-lua").live_grep() end },
		},
		opts = {
			"max-perf"
		},
	},
	-- Add a dedicated formatter plugin for more control
	{
		dependencies = { "nvim-lua/plenary.nvim" },
		"nvimtools/none-ls.nvim",
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		config = function()
			require("lsp_signature").setup({
				bind = true,
				handler_opts = {
					border = "rounded"
				},
				hint_enable = false, -- Disable virtual text hints
			})
		end,
	},
	-- NeoGit
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration
		},
		cmd = "Neogit",
		keys = {
			{ "<leader>gg", "<cmd>Neogit<CR>", desc = "Open Neogit" },
		},
		config = function()
			require("neogit").setup()
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "lua", "python", "go", "c", "cpp", "rust", "ocaml", "c_sharp" },
				highlight = { enable = true },
				indent = { enable = true },
				playground = { enable = true },
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = "nvim-treesitter/nvim-treesitter", -- Ensure treesitter is already installed
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable context by default
				max_lines = 0, -- Limit the number of lines to show (0 for no limit)
				min_window_height = 0, -- Minimum height to trigger context (0 for no limit)
				patterns = {
					-- Enable context for specific languages
					-- If you want to limit it to certain languages, you can specify here.
					default = {
						"function",
						"method",
						"for_statement",
						"while_statement",
					},
				},
			})
		end,
	},
	-- UndoTree
	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		keys = {
			{ "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" },
		},
	},
	-- Lualine (Statusline) with navic integration
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", "SmiteshP/nvim-navic" },
		config = function()
			require("lualine").setup({
				options = { theme = "catppuccin" },
				sections = {
					lualine_c = {
						{ "filename" },
						{
							function() return require("nvim-navic").get_location() end,
							cond = function()
								return package
									.loaded["nvim-navic"] and require("nvim-navic").is_available()
							end
						},
					}
				}
			})
		end,
	},
	-- AutoClose (Auto-closing brackets)
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = true
	},
	-- Comment.nvim (gc to comment)
	{
		"numToStr/Comment.nvim",
		event = "BufRead",
		config = function()
			require("Comment").setup()
		end,
	},
})