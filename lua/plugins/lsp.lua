return {
	'neovim/nvim-lspconfig',
	dependencies = {
		{'williamboman/mason.nvim', config = true, built = 'MasonUpdate'},
		'williamboman/mason-lspconfig.nvim',
		{'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
		'folke/neodev.nvim',
		},
	config = function()
		vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
		vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
		vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
		vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

		local on_attach = function(_, bufnr)
			local nmap = function(keys, func, desc)
				if desc then
					desc = 'LSP: ' .. desc
				end
				vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
			end
			  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
			  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
			  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
			  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
			  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
			  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
			  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
			  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
			  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
			  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
			  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
			  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
				  vim.lsp.buf.format()
			  end, { desc = 'Format current buffer with LSP' })

		end

		require("neodev").setup({})

		local servers = {
			rust_analyzer = {},
			pyright = {},
			lua_ls = {
				Lua = {
					completion = {
						callSnippet = "Replace"
					}
				}
			},
		}

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

		local mason_lspconfig = require 'mason-lspconfig'


		mason_lspconfig.setup {
			ensure_installed = vim.tbl_keys(servers)
		}

		mason_lspconfig.setup_handlers {
			function(server_name)
				require('lspconfig')[server_name].setup {
					capabilities = capabilities,
					on_attach = on_attach,
					settings = servers[server_name]
				}
			end
		}



	end
}
