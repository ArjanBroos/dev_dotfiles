require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    -- "jdtls",
    -- "pyright",
    -- "ts_ls",
  },
  automatic_enable = false,
})
-- vim.lsp.config("roslyn_ls", {
--   cmd = { vim.fn.expand("~/.dotnet/tools/roslyn-language-server"), "--stdio" },
-- })
-- vim.lsp.enable({
--   "rust_analyzer",
--   "roslyn_ls",
-- })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspCompletion", { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, event.buf, {
        autotrigger = false,
      })
    end
  end,
})

vim.keymap.set("i", "<C-.>", vim.lsp.completion.get, { desc = "Request LSP completion" })
vim.keymap.set("n", "<leader>fo", vim.lsp.buf.format, { desc = "Format buffer" })
