-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Jump directly to the Nth open buffer/tab in the bufferline (<leader> = space)
for i = 1, 9 do
  vim.keymap.set(
    "n",
    "<leader>" .. i,
    "<cmd>BufferLineGoToBuffer " .. i .. "<cr>",
    { desc = "Go to buffer " .. i }
  )
end

-- Delete the current buffer but keep the window layout and move to the next
-- listed buffer instead of falling back to the file explorer.
local function smart_bufdelete()
  if pcall(require, "snacks") and Snacks and Snacks.bufdelete then
    Snacks.bufdelete()
  else
    local ok, bufremove = pcall(require, "mini.bufremove")
    if ok then
      bufremove.delete(0, false)
    else
      vim.cmd("bdelete")
    end
  end
end

vim.keymap.set("n", "<leader>bd", smart_bufdelete, { desc = "Delete Buffer (keep layout)" })

-- Make `:bd` / `:Bd` use the smart delete too
vim.api.nvim_create_user_command("Bd", smart_bufdelete, {})
vim.cmd([[cnoreabbrev <expr> bd (getcmdtype() == ':' && getcmdline() ==# 'bd') ? 'Bd' : 'bd']])

-- Copy the current file's absolute path to the system clipboard
vim.keymap.set("n", "<leader>yp", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path)
end, { desc = "Yank absolute file path" })

-- Copy the current file's relative path to the system clipboard
vim.keymap.set("n", "<leader>yr", function()
  local path = vim.fn.expand("%")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path)
end, { desc = "Yank relative file path" })
