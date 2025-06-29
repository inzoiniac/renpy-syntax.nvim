local M = {}

function M.setup()
	-- Define o filetype renpy para arquivos .rpy
	vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
		pattern = "*.rpy",
		callback = function()
			vim.bo.filetype = "renpy"
		end,
	})

	-- Define commentstring e carrega syntax quando o filetype for renpy
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "renpy",
		callback = function()
			vim.bo.commentstring = "# %s"
			vim.cmd("syntax enable")
			vim.cmd("runtime! syntax/renpy.vim")

			-- Setup opcional do cmp, se estiver disponível
			local ok, cmp = pcall(require, "cmp")
			if ok and cmp.register_source then
				local ok2, source = pcall(require, "renpy-syntax.rpy_cmp")
				if ok2 then
					cmp.register_source("renpy", source)
				end
			end
		end,
	})
end

return M
