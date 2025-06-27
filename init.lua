-- Define o filetype quando abrir .rpy
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.rpy",
  callback = function()
    vim.bo.filetype = "renpy"
  end,
})

-- Define commentstring para o filetype renpy
vim.api.nvim_create_autocmd("filetype", {
  pattern = "renpy",
  callback = function()
    vim.bo.commentstring = "# %s"
  end,
})
