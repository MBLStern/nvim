-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- add your plugins here
        {
            'nvim-telescope/telescope.nvim',
            version = '0.1.5',
            -- or                            , branch = '0.1.x',
            dependencies = { 'nvim-lua/plenary.nvim' }
        },
        {
            "catppuccin/nvim",
            name = "catppuccin",
            priority = 1000
        },
        { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
        { 'mbbill/undotree' },
        { 'tpope/vim-fugitive' },
        { 'VonHeikemen/lsp-zero.nvim',
            branch = 'v3.x',
            dependencies = {
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
            {
                'mfussenegger/nvim-dap',
                dependencies = { "rcarriga/nvim-dap-ui",
                    "leoluz/nvim-dap-go",
                    "mfussenegger/nvim-jdtls",
                    "nvim-neotest/nvim-nio" },
            },
            { "ThePrimeagen/harpoon" }
        },
       { 'Civitasv/cmake-tools.nvim' },
        {
            'lervag/vimtex',
            lazy = false,
            init = function()
                -- VimTeX configuration goes here, e.g.
                vim.g.vimtex_view_method = "zathura"
            end
        },
        { 'Aasim-A/scrollEOF.nvim' }
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})
