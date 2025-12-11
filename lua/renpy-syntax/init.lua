local M = {}
local augroup = vim.api.nvim_create_augroup("RenpySyntaxGroup", { clear = true })

function M.setup()
	-- Define o filetype renpy para arquivos .rpy
	vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
		pattern = "*.rpy",
		group = augroup,
		callback = function()
			vim.bo.filetype = "renpy"
		end,
	})

	-- Define commentstring e carrega syntax quando o filetype for renpy
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "renpy",
		group = augroup,
		callback = function()
			vim.bo.commentstring = "# %s"
			vim.cmd("syntax enable")
			vim.cmd("runtime! syntax/renpy.vim")

			-- Setup opcional do cmp, se estiver disponível
			local ok, cmp = pcall(require, "cmp")
			if ok then
				-- LIMPA TUDO relacionado ao módulo
				package.loaded["renpy-syntax.rpy_cmp"] = nil
				package.loaded["renpy-syntax"] = nil
				-- Recarrega e registra novamente
				local ok2, source = pcall(require, "renpy-syntax.rpy_cmp")
				if ok2 and cmp.register_source then
					cmp.register_source("renpy", source)
					-- Força configuração das sources para o filetype renpy
					vim.schedule(function()
						cmp.setup.filetype("renpy", {
							sources = {
								{ name = "renpy" },
								{ name = "buffer" },
							},
						})
					end)
				end
			end
		end,
	})
end
return M
