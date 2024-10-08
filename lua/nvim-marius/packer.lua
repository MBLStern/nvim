vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use({ "catppuccin/nvim", as = "catppuccin" })
    use('nvim-treesitter/nvim-treesitter', { run = 'TSUpdate' })
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- LSP Support
            { 'neovim/nvim-lspconfig' },
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
        use { 'mfussenegger/nvim-dap',
            requires = { "rcarriga/nvim-dap-ui",
                "leoluz/nvim-dap-go",
                "mfussenegger/nvim-jdtls",
                "nvim-neotest/nvim-nio" },
        },
        use("ThePrimeagen/harpoon")
    }
    use('Civitasv/cmake-tools.nvim')
    use {
        'lervag/vimtex',
        lazy = false,
        init = function()
            -- VimTeX configuration goes here, e.g.
            vim.g.vimtex_view_method = "zathura"
        end
    }
    use('Aasim-A/scrollEOF.nvim')
end)
