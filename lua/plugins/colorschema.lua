return {
    -- desactiva o tokyonight
    { "folke/tokyonight.nvim", enabled = false },

    -- adiciona o tema que quiseres, ex. Catppuccin
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        opts = {
            flavour = "mocha", -- latte, frappe, macchiato, mocha
        },
    },

    -- diz ao LazyVim para usar este tema
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "catppuccin",
        },
    },
}