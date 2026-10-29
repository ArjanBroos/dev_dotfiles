require("nvim-treesitter").install({
  "java",
  "rust",
  "python",
  "c_sharp",
  "javascript",
  "typescript",
  "tsx",
  "lua",
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("TreesitterHighlighting", { clear = true }),
  pattern = {
    "java",
    "rust",
    "python",
    "cs",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "lua",
  },
  callback = function(event)
    vim.treesitter.start(event.buf)
  end,
})
