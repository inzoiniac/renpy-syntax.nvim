local M = {}

function M.setup()
  -- Define o filetype renpy para arquivos .rpy
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.rpy",
    callback = function()
      vim.bo.filetype = "renpy"
    end,
  })

  -- Define o commentstring
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "renpy",
    callback = function()
      vim.bo.commentstring = "# %s"
    end,
  })

  -- Carrega o syntax manualmente
  vim.cmd("runtime! syntax/renpy.vim")
end

return M
