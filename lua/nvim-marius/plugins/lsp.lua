return {
    'neovim/nvim-lspconfig',
    dependencies = {
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },
        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-cmdline' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-nvim-lsp-signature-help' },
        { 'L3MON4D3/LuaSnip' },
        { 'saadparwaiz1/cmp_luasnip' },
    },
    config = function()
        -- luasnip setup
        local ls = require("luasnip")
        vim.keymap.set({ "i", "s" }, "<C-l>", function() ls.jump(1) end, { silent = true })
        vim.keymap.set({ "i", "s" }, "<M-l>", function() ls.jump(-1) end, { silent = true })


        -- cmp setup
        local cmp = require("cmp")

        cmp.setup({
            snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            window = {
                -- completion = cmp.config.window.bordered(),
                -- documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-r>'] = cmp.mapping.select_next_item(),
                ['<C-f>'] = cmp.mapping.select_prev_item(),
                ['<C-x>'] = cmp.mapping.scroll_docs(4),
                ['<C-z>'] = cmp.mapping.scroll_docs(-4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-E>'] = cmp.mapping.abort(),
                ['<C-CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                    { name = 'path' },
                    { name = 'nvim_lsp_signature_help' }
                },
                {
                    { name = 'buffer' },
                })
        })

        -- lsp setup

        local lspconfig = require('lspconfig')
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        local handlers = {
            function(server_name)
                if server_name ~= "jdtls" then
                    lspconfig[server_name].setup({
                        on_attach = on_attach,
                        capabilities = capabilities,
                    })
                end
            end,
            ["lua_ls"] = function()
                lspconfig.lua_ls.setup {
                    on_init = function(client)
                        local path = client.workspace_folders[1].name
                        if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                            return
                        end

                        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                            runtime = {
                                -- Tell the language server which version of Lua you're using
                                -- (most likely LuaJIT in the case of Neovim)
                                version = 'LuaJIT'
                            },
                            -- Make the server aware of Neovim runtime files
                            workspace = {
                                checkThirdParty = false,
                                library = {
                                    vim.env.VIMRUNTIME
                                    -- Depending on the usage, you might want to add additional paths here.
                                    -- "${3rd}/luv/library"
                                    -- "${3rd}/busted/library",
                                }
                                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                                -- library = vim.api.nvim_get_runtime_file("", true)
                            }
                        })
                    end,
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { 'vim' }
                            },
                        },
                    }
                }
            end,
            ["vhdl_ls"] = function()
                lspconfig.vhdl_ls.setup({
                    on_attach = on_attach,
                    capabilities = capabilities
                })
            end,
            ["gopls"] = function()
                lspconfig.gopls.setup({
                    settings = {
                        gopls = {
                            gofumpt = true
                        },
                    },
                    on_attach = on_attach,
                    capabilities = capabilities
                })
            end,
            ["clangd"] = function()
                lspconfig.clangd.setup({
                    on_attach = on_attach,
                    capabilities = capabilities
                })
            end,
        }

        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = {
                "lua_ls",
                "clangd",
                "gopls",
                "jdtls",
                "vhdl_ls",
            },
            handlers = handlers,
        })



        -- keymaps
        vim.keymap.set("n", "<leader>ff", function() vim.lsp.buf.format() end)
        vim.keymap.set("n", "<leader>gd", function() vim.lsp.buf.definition() end)

        -- auto format
        vim.api.nvim_create_autocmd("BufWritePre", {
            callback = function()
                vim.lsp.buf.format({ async = false })
            end
        })
    end
}
