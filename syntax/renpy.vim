" ================================
" Ren'Py Syntax Highlighting
" ================================

" Protege contra múltiplas ativações
if exists("b:current_syntax")
  finish
endif

" === [1] Comandos principais do Ren'Py ===
syntax keyword renpyStatement label jump call return python menu scene show hide with play stop queue pause window voice channel define image init transform default
syntax keyword renpyStatement style transform screen define default init image
highlight link renpyStatement Keyword

" === [2] Controle de fluxo ===
syntax keyword renpyConditional if elif else while for break continue pass
highlight link renpyConditional Conditional

" === [3] Visual e Áudio ===
syntax keyword renpyVisual scene show hide with at behind onlayer zorder transform
highlight link renpyVisual Type

syntax keyword renpyAudio play stop queue voice sound music
highlight link renpyAudio PreProc

syntax keyword renpyWindow window hide show
highlight link renpyWindow Statement

" === [4] Definições, Variáveis e Configurações ===
syntax keyword renpyDefine define default init python
syntax match renpyDotNamespace /\<\%(store\|persistent\|config\|renpy\)\.\w\+/
highlight link renpyDefine Define
highlight link renpyDotNamespace Identifier

" === [5] Diálogos e Falas ===
syntax match renpyCharacter /^[a-zA-Z0-9_]\+\s*\"/
syntax match renpyDialogue /^ *\".\{-}\"/
syntax match renpyTextTag /{[a-zA-Z0-9=_\.\/\[\]-]\+}/
highlight link renpyCharacter Identifier
highlight link renpyDialogue String
highlight link renpyTextTag Special

" === [6] Menus ===
syntax keyword renpyMenu menu
syntax match renpyMenuOption /^ *\".\{-}\" *:/
highlight link renpyMenu Keyword
highlight link renpyMenuOption Constant

" === [7] Labels ===
syntax match renpyLabel /^label \zs\w\+/
highlight link renpyLabel Function

" === [8] Comentários ===
syntax match renpyComment /^ *#.*$/
highlight link renpyComment Comment

" === [9] Layout e UI ===
syntax keyword renpyLayoutProperty xpos ypos xanchor yanchor xalign yalign xoffset yoffset anchor align pos offset size
syntax keyword renpyLayoutProperty xsize ysize xminimum xmaximum yminimum ymaximum xfill yfill spacing order area padding
highlight link renpyLayoutProperty Type

" === [10] Estilo Visual ===
syntax keyword renpyStyleProperty background foreground text_hover text_idle text_selected text_insensitive hover_sound insensitive alternate tooltip at auto action hovered unhovered
highlight link renpyStyleProperty Type

" === [11] Elementos de Tela ===
syntax keyword renpyScreenElement screen frame window side vbox hbox grid fixed viewport imagemap textbutton imagebutton text input bar timer key use modal tag has add default
highlight link renpyScreenElement Structure

" === [12] Widgets Interativos ===
syntax keyword renpyWidget textbutton imagebutton button text input bar scrollbar viewport imagemap hotspot key timer
highlight link renpyWidget Statement

" === [13] Propriedades de Botões ===
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

" === [16] Ações de Screen ===
syntax keyword renpyScreenAction Jump Return Hide Show SetVariable ToggleVariable ToggleScreen VariableInput Call Function SetScreenVariable
syntax keyword renpyScreenAction Start Skip Rollback With Preference Help FileSave FileLoad Screenshot Quit Confirm SkipUntilDialogue Notify
syntax keyword renpyScreenAction SetCharacterVolume ToggleMute Language InLanguage
highlight link renpyScreenAction Function

" === [17] Widgets Especiais e Input ===
syntax keyword renpySpecialWidget input bar timer viewport scrollbar drag drop draggable droppable mousearea
highlight link renpySpecialWidget Statement

syntax keyword renpyInputProperty value default length allow exclude pixel_width copypaste editable mask multiline prefix suffix clip caps
highlight link renpyInputProperty Type

syntax keyword renpyInputValue VariableInputValue FieldInputValue FunctionInputValue
highlight link renpyInputValue Constant

" === [18] Python embutido ===
syntax region renpyPython start="^\s*python\s*:" end="^\s*$" contains=@python
highlight link renpyPython Statement

syntax region renpyInitPython start="^\s*init\s\+python\s*:" end="^\s*$" contains=@python
highlight link renpyInitPython PreProc

syntax region renpyInitLevelPython start="^\s*init\s\+\d\+\s\+python\s*:" end="^\s*$" contains=@python
highlight link renpyInitLevelPython PreProc

" === [Final] Inclui syntax do Python para regiões embutidas ===
runtime! syntax/python.vim

let b:current_syntax = "renpy"

