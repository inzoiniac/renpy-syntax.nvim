local M = {}

function M.setup()
  -- Define o filetype renpy para arquivos .rpy
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.rpy",
    callback = function()
      vim.bo.filetype = "renpy"
    end,
  })

  -- Define o commentstring e ativa o highlight quando o filetype for renpy
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "renpy",
    callback = function()
      vim.bo.commentstring = "# %s"
      vim.cmd("syntax enable")               -- Garante que a syntax esteja ativada
      vim.cmd("runtime! syntax/renpy.vim")   -- Carrega seu syntax
    end,
  })
end

return M
