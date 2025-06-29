-- lua/renpy-syntax/rpy_cmp.lua

local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
	return {}
end

local source = {}

local keywords = {
	-- Comandos principais
	"label",
	"jump",
	"call",
	"return",
	"python",
	"menu",
	"scene",
	"show",
	"hide",
	"with",
	"play",
	"stop",
	"queue",
	"pause",
	"window",
	"voice",
	"channel",
	"define",
	"image",
	"init",
	"transform",
	"default",
	"style",
	"screen",

	-- Controle de fluxo
	"if",
	"elif",
	"else",
	"while",
	"for",
	"break",
	"continue",
	"pass",

	-- Visual e áudio
	"at",
	"behind",
	"onlayer",
	"zorder",
	"sound",
	"music",

	-- Layout e UI
	"xpos",
	"ypos",
	"xanchor",
	"yanchor",
	"xalign",
	"yalign",
	"xoffset",
	"yoffset",
	"anchor",
	"align",
	"pos",
	"offset",
	"size",
	"xsize",
	"ysize",
	"xminimum",
	"xmaximum",
	"yminimum",
	"ymaximum",
	"xfill",
	"yfill",
	"spacing",
	"order",
	"area",
	"padding",

	-- Estilo visual
	"background",
	"foreground",
	"text_hover",
	"text_idle",
	"text_selected",
	"text_insensitive",
	"hover_sound",
	"insensitive",
	"alternate",
	"tooltip",
	"auto",
	"action",
	"hovered",
	"unhovered",

	-- Elementos de tela
	"frame",
	"window",
	"side",
	"vbox",
	"hbox",
	"grid",
	"fixed",
	"viewport",
	"imagemap",
	"textbutton",
	"imagebutton",
	"text",
	"input",
	"bar",
	"timer",
	"key",
	"use",
	"modal",
	"tag",
	"has",
	"add",

	-- Widgets interativos
	"button",
	"scrollbar",
	"hotspot",
	"drag",
	"drop",
	"draggable",
	"droppable",
	"mousearea",

	-- ATL
	"on",
	"linear",
	"ease",
	"easein",
	"easeout",
	"easeinout",
	"repeat",
	"parallel",
	"block",
	"choice",
	"alpha",
	"rotate",
	"zoom",
	"xzoom",
	"yzoom",
	"matrix",
	"rotate_pad",
	"blur",
	"xysize",
	"crop",
	"time",
	"delay",
	"subpixel",

	-- Imagemap e Hotbar
	"ground",
	"idle",
	"hover",
	"selected",
	"focus",
	"mask",
	"alt",

	-- Ações de Screen
	"Jump",
	"Return",
	"Hide",
	"Show",
	"SetVariable",
	"ToggleVariable",
	"ToggleScreen",
	"VariableInput",
	"Call",
	"Function",
	"SetScreenVariable",
	"Start",
	"Skip",
	"Rollback",
	"With",
	"Preference",
	"Help",
	"FileSave",
	"FileLoad",
	"Screenshot",
	"Quit",
	"Confirm",
	"SkipUntilDialogue",
	"Notify",
	"SetCharacterVolume",
	"ToggleMute",
	"Language",
	"InLanguage",

	-- Input Properties
	"value",
	"length",
	"allow",
	"exclude",
	"pixel_width",
	"copypaste",
	"editable",
	"mask",
	"multiline",
	"prefix",
	"suffix",
	"clip",
	"caps",

	-- InputValue types
	"VariableInputValue",
	"FieldInputValue",
	"FunctionInputValue",
}

function source:is_available()
	return vim.bo.filetype == "renpy"
end

function source:complete(params, callback)
	local prefix = params.context.cursor_before_line:match("%w*$") or ""
	local items = {}

	for _, word in ipairs(keywords) do
		if word:sub(1, #prefix) == prefix then
			table.insert(items, {
				label = word,
				kind = cmp.lsp.CompletionItemKind.Keyword,
				documentation = {
					kind = "markdown",
					value = string.format("Keyword Ren'Py: `%s`", word),
				},
			})
		end
	end

	callback({ items = items, isIncomplete = false })
end

function source:resolve(item, callback)
	callback(item)
end

function source:cancel() end

return source
