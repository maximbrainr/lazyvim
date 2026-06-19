return {
    "stevearc/conform.nvim",
    opts = function(_, opts)
        opts.formatters_by_ft = opts.formatters_by_ft or {}
        -- Run prettier first, then eslint_d LAST so ESLint's rules win
        -- (e.g. single quotes). Otherwise prettier re-adds double quotes
        -- and ESLint reports "Strings must use singlequote".
        opts.formatters_by_ft.javascript = { "prettier", "eslint_d" }
        opts.formatters_by_ft.typescript = { "prettier", "eslint_d" }
        opts.formatters_by_ft.javascriptreact = { "prettier", "eslint_d" }
        opts.formatters_by_ft.typescriptreact = { "prettier", "eslint_d" }
        return opts
    end,
}