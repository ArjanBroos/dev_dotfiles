vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up half a screen and center cursor" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down half a screen and center cursor" })

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("QuickfixMappings", { clear = true }),
  pattern = "qf",
  callback = function(event)
    vim.keymap.set("n", "<CR>", "<CR><Cmd>cclose<CR>", {
      buffer = event.buf,
      desc = "Open entry and close quickfix",
    })
  end,
})
