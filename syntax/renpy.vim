" ================================
" Ren'Py Syntax Highlighting
" ================================

" Protege contra múltiplas ativações
if exists("b:current_syntax")
  finish
endif


" === [1] Comandos principais do Ren'Py ===
syntax keyword renpyStatement label jump call return python menu scene show hide with play stop queue pause window voice channel define image init transform default
highlight link renpyStatement Keyword

" === [2] Controle de fluxo ===
syntax keyword renpyConditional if elif else while for break continue
highlight link renpyConditional Conditional

" === [3] Comandos visuais e de som ===
syntax keyword renpyVisual scene show hide with at behind onlayer zorder transform
highlight link renpyVisual Type

syntax keyword renpyAudio play stop queue voice sound music
highlight link renpyAudio PreProc

syntax keyword renpyWindow window hide show
highlight link renpyWindow Statement

" === [4] Variáveis e definições ===
syntax keyword renpyDefine define default init $
highlight link renpyDefine Define

" === [5] Diálogos ===
syntax match renpyCharacter /^[a-zA-Z0-9_]\+\s*\"/
highlight link renpyCharacter Identifier

syntax match renpyDialogue /^ *\".\{-}\"/
highlight link renpyDialogue String

" === [6] Menu ===
syntax keyword renpyMenu menu
highlight link renpyMenu Keyword

syntax match renpyMenuOption /^ *\".\{-}\" *:/
highlight link renpyMenuOption Constant

" === [7] Labels ===
syntax match renpyLabel /^label \zs\w\+/
highlight link renpyLabel Function

" === [8] Comentários ===
syntax match renpyComment /^ *#.*$/
highlight link renpyComment Comment

" === [9] Propriedades de layout (vbox, hbox, grid, etc.) ===
syntax keyword renpyLayoutProperty xpos ypos xanchor yanchor xalign yalign xoffset yoffset anchor align pos offset size
syntax keyword renpyLayoutProperty xsize ysize xminimum xmaximum yminimum ymaximum xfill yfill spacing order area padding
highlight link renpyLayoutProperty Type

" === [10] Propriedades de estilo geral (usadas em screens/buttons) ===
syntax keyword renpyStyleProperty style background foreground text_hover text_idle text_selected text_insensitive hover_sound insensitive alternate tooltip at auto action hovered unhovered
highlight link renpyStyleProperty Type

" === [11] Elementos de Screen Language ===
syntax keyword renpyScreenElement screen frame window side vbox hbox grid fixed viewport imagemap textbutton imagebutton text input bar timer key use modal tag default
highlight link renpyScreenElement Structure

" === [12] Widgets interativos ===
syntax keyword renpyWidget textbutton imagebutton button text input bar scrollbar viewport imagemap hotspot key
highlight link renpyWidget Statement

" === [13] Propriedades específicas de botões ===
syntax keyword renpyButtonProperty action hovered unhovered tooltip sensitive insensitive alternate background foreground text_hover text_idle text_selected text_insensitive at style
highlight link renpyButtonProperty Constant

" === [14] ATL (Animation and Transformation Language) ===
syntax keyword renpyATL on show hide transform linear ease easein easeout easeinout pause repeat parallel block choice
syntax keyword renpyATL alpha rotate zoom xzoom yzoom xanchor yanchor xpos ypos align anchor offset subpixel
syntax keyword renpyATL matrix rotate_pad blur xysize crop time delay
highlight link renpyATL PreProc

" === [15] Imagemap, Hotspot, Hotbar ===
syntax keyword renpyImagemap imagemap hotspot hotbar ground idle hover selected insensitive focus mask action hovered unhovered alt tooltip
highlight link renpyImagemap Constant

" === [16] Screen Actions (Ren'Py built-in actions) ===
syntax keyword renpyScreenAction Jump Return Hide Show SetVariable ToggleVariable ToggleScreen VariableInput Call Function SetScreenVariable
syntax keyword renpyScreenAction Start Skip Rollback With Preference Help FileSave FileLoad Screenshot Quit Confirm SkipUntilDialogue Notify
highlight link renpyScreenAction Function

" === [17] Widgets Especiais: input, bar, timer, viewport ===
syntax keyword renpySpecialWidget input bar timer viewport scrollbar drag drop draggable droppable mousearea
highlight link renpySpecialWidget Statement

" === [17.1] Propriedades específicas do input ===
syntax keyword renpyInputProperty value default length allow exclude pixel_width copypaste editable mask multiline prefix suffix clip caps
highlight link renpyInputProperty Type

" === [17.2] InputValue types ===
syntax keyword renpyInputValue VariableInputValue FieldInputValue FunctionInputValue
highlight link renpyInputValue Constant




" === [15] Blocos de código Python embutido ===
syntax region renpyPython start="^\s*python\s*:" end="^\s*$" contains=@python
highlight link renpyPython Statement

syntax region renpyInitPython start="^\s*init\s\+python\s*:" end="^\s*$" contains=@python
highlight link renpyInitPython PreProc

" === [Final] Inclui syntax do Python para regiões embutidas ===
runtime! syntax/python.vim

let b:current_syntax = "renpy"

