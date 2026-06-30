-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local function is_remove_unused_imports_action(action)
  local kind = action.kind or ""
  local command = action.command and action.command.command

  return kind == "source.removeUnusedImports"
    or kind:match("^source%.removeUnusedImports%.")
    or command == "typescript.removeUnusedImports"
    or command == "javascript.removeUnusedImports"
end

local function apply_code_action(action, client, bufnr)
  if action.data and not (action.edit or action.command) and client.supports_method(client, "codeAction/resolve") then
    local resolved = client:request_sync("codeAction/resolve", action, 1000, bufnr)
    action = resolved and resolved.result or action
  end

  if action.edit then
    vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding or "utf-16")
  end

  if action.command then
    client:request_sync(
      "workspace/executeCommand",
      {
        command = action.command.command,
        arguments = action.command.arguments,
        workDoneToken = action.command.workDoneToken,
      },
      1000,
      bufnr
    )
  end
end

-- Remove unused imports on save without applying broader "remove unused code" fixes.
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = vim.api.nvim_create_augroup("ts_imports", { clear = true }),
  pattern = { "*.js", "*.jsx", "*.ts", "*.tsx" },
  callback = function(args)
    local params = {
      textDocument = vim.lsp.util.make_text_document_params(args.buf),
      range = {
        start = { line = 0, character = 0 },
        ["end"] = { line = vim.api.nvim_buf_line_count(args.buf), character = 0 },
      },
      context = {
        only = { "source.removeUnusedImports" },
        diagnostics = {},
      },
    }

    local results = vim.lsp.buf_request_sync(args.buf, "textDocument/codeAction", params, 1000)
    if not results then
      return
    end

    for client_id, result in pairs(results) do
      local client = vim.lsp.get_client_by_id(client_id)

      if client then
        for _, action in ipairs(result.result or {}) do
          if is_remove_unused_imports_action(action) then
            apply_code_action(action, client, args.buf)
            return
          end
        end
      end
    end
  end,
})
