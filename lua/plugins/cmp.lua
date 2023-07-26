return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        {
            "L3MON4D3/LuaSnip",
            version = "2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        },
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'PhilRunninger/cmp-rpncalc',
    },
    config = function()
        local cmp = require 'cmp'
        cmp.setup {
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end

            },
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace })
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'buffer' },
                { name = 'path' },
                { name = 'rpncalc' }
            }),
            performance = {
                max_view_entries = 5
            }
        }
    end
}
