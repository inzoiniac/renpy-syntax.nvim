local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
	return {}
end

local source = {}

local completion_items = {
	{
		label = "label",
		kind = cmp.lsp.CompletionItemKind.Keyword,
		insertText = "label ${1:name}:\n    $0",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**label** - Define a point in script that can be called or jumped to

Syntax: `label name(parameters):`

Creates a named location in the script. Labels can:
- Be jumped to with `jump` (no return)
- Be called with `call` (returns when finished)
- Accept optional parameters like functions

Example:
```renpy
label start:
    "Game begins here"
    call chapter1
    
label chapter1:
    "Chapter 1 content"
    return
```]],
		},
	},
	{
		label = "jump",
		kind = cmp.lsp.CompletionItemKind.Keyword,
		insertText = "jump ${1:label_name}",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**jump** - Transfer control to another label (no return)

Syntax: `jump label_name`

Jumps to the specified label without saving return point. Unlike `call`, there's no way to return to where you jumped from.

Example:
```renpy
label start:
    jump game_start  # Goes to game_start, can't return here

label game_start:
    "The game begins!"
```

Use `call` instead if you need to return.]],
		},
	},
	{
		label = "call",
		kind = cmp.lsp.CompletionItemKind.Keyword,
		insertText = "call ${1:label_name}",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**call** - Transfer control to label and return when done

Syntax: `call label_name(args)` or `call label_name from location`

Calls a label like a function. Pushes current location onto call stack, allowing `return` to bring control back.

Example:
```renpy
label start:
    call greet_player
    "Back in start label"
    
label greet_player:
    "Hello, player!"
    return  # Returns to caller
```

Can pass parameters: `call fight("goblin", hp=50)`]],
		},
	},
	{
		label = "return",
		kind = cmp.lsp.CompletionItemKind.Keyword,
		insertText = "return${1: ${2:value}}",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**return** - Return from a called label

Syntax: `return` or `return value`

Returns control to the statement after the `call` that invoked current label. Optional value is stored in `_return` variable.

Example:
```renpy
label check_health:
    if player_hp > 0:
        return True
    else:
        return False

label start:
    call check_health
    if _return:
        "Player is alive!"
```]],
		},
	},

	{
		label = "scene",
		kind = cmp.lsp.CompletionItemKind.Keyword,
		insertText = "scene ${1:image_name}${2: with ${3:dissolve}}",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**scene** - Clear layer and show background image

Syntax: `scene image_name [at transform] [with transition]`

Removes all displayables from a layer (default: master layer) and shows an image. Typically used for backgrounds.

Example:
```renpy
scene bg room          # Clear and show room background
scene bg park with dissolve  # Fade to park
scene                  # Just clear the layer
```

Use `show` to add images without clearing layer.]],
		},
	},
	{
		label = "show",
		kind = cmp.lsp.CompletionItemKind.Keyword,
		insertText = "show ${1:image_name}${2: at ${3:position}}${4: with ${5:dissolve}}",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**show** - Display an image on a layer

Syntax: `show image_name [at transform] [with transition]`

Shows an image on a layer (default: master). Replaces any existing image with same tag.

Example:
```renpy
show eileen happy at left     # Show character at left
show bg room with fade        # Show background with fade
show overlay effect with dissolve
```

Attributes can specify variants:
```renpy
show eileen happy           # Shows eileen with happy expression
show eileen sad at right    # Change expression and position
```]],
		},
	},
	{
		label = "hide",
		kind = cmp.lsp.CompletionItemKind.Keyword,
		insertText = "hide ${1:image_name}${2: with ${3:dissolve}}",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**hide** - Remove an image from layer

Syntax: `hide image_name [with transition]`

Hides image from layer using its tag. Often unnecessary as `show` automatically replaces images with same tag.

Example:
```renpy
hide eileen              # Hide eileen sprite
hide eileen with dissolve # Fade out eileen
```

Note: `hide` is rarely needed. Use `show` to change character sprites/expressions instead.]],
		},
	},
	{
		label = "with",
		kind = cmp.lsp.CompletionItemKind.Keyword,
		insertText = "with ${1:dissolve}",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**with** - Apply transition effect

Syntax: `with transition_name`

Applies a transition between old and new scene states. Common transitions:
- `dissolve` - Crossfade (default 0.5s)
- `fade` - Fade to black then in
- `vpunch` / `hpunch` - Screen shake
- `None` - Instant (removes transients)

Example:
```renpy
show bg room
show eileen happy
with dissolve  # Both changes happen with dissolve

scene bg park with fade  # Built into statement
```]],
		},
	},

	{
		label = "play",
		kind = cmp.lsp.CompletionItemKind.Keyword,
		insertText = 'play ${1|music,sound,voice|} "${2:filename.ogg}"${3: fadeout ${4:1.0} fadein ${5:1.0}}',
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**play** - Play audio file on a channel

Syntax: `play channel "filename" [fadein time] [fadeout time] [loop]`

Plays audio file, interrupting any currently playing file.

Channels:
- `music` - Background music (loops by default)
- `sound` - Sound effects (plays once by default)
- `voice` - Voice acting (syncs with dialogue)

Example:
```renpy
play music "background.ogg" fadein 1.0
play sound "explosion.mp3"
play music ["song1.ogg", "song2.ogg"] # Playlist
```]],
		},
	},
	{
		label = "stop",
		kind = cmp.lsp.CompletionItemKind.Keyword,
		insertText = "stop ${1|music,sound,voice|}${2: fadeout ${3:1.0}}",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**stop** - Stop audio playback on channel

Syntax: `stop channel [fadeout time]`

Stops currently playing audio and clears queue. If fadeout not specified, uses `config.fadeout_audio`.

Example:
```renpy
stop music               # Stop immediately
stop music fadeout 2.0   # Fade out over 2 seconds
stop sound               # Stop sound effects
```]],
		},
	},
	{
		label = "queue",
		kind = cmp.lsp.CompletionItemKind.Keyword,
		insertText = 'queue ${1|music,sound,voice|} "${2:filename.ogg}"',
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**queue** - Add audio to playback queue

Syntax: `queue channel "filename" [fadein time]`

Queues audio file to play after current audio finishes. Useful for music playlists.

Example:
```renpy
play music "intro.ogg"
queue music "main_theme.ogg"  # Plays after intro
queue music ["song2.ogg", "song3.ogg"]
```]],
		},
	},
	{
		label = "menu",
		kind = cmp.lsp.CompletionItemKind.Keyword,
		insertText = 'menu:\n    "${1:What will you do?}"\n    \n    "${2:Choice 1}":\n        ${3:jump ${4:label_name}}\n    \n    "${5:Choice 2}":\n        $0',
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**menu** - Present choices to player

Syntax:
```renpy
menu:
    "Choice 1":
        jump somewhere
    "Choice 2":
        call some_label
```

With caption (optional narration before choices):
```renpy
menu:
    "What will you do?"
    
    "Go left":
        jump left_path
    "Go right":
        jump right_path
```

Conditional choices:
```renpy
menu:
    "Talk to friend":
        jump talk_scene
    "Fight" if player_brave:
        call combat
```

Note: Each choice MUST have an action (jump, call, pass, etc)]],
		},
	},

	{
		label = "if",
		kind = cmp.lsp.CompletionItemKind.Keyword,
		insertText = "if ${1:condition}:\n    $0",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**if** - Conditional execution

Syntax: `if condition:`

Executes block only if condition is True.

Example:
```renpy
if player_health > 50:
    "You're feeling strong!"
elif player_health > 20:
    "You're a bit tired."
else:
    "You need rest badly."
```]],
		},
	},
	{
		label = "elif",
		kind = cmp.lsp.CompletionItemKind.Keyword,
		insertText = "elif ${1:condition}:\n    $0",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**elif** - Else-if conditional

Syntax: `elif condition:`

Checks condition if previous `if`/`elif` was False. Part of if-elif-else chain.

Example:
```renpy
if score > 90:
    "Perfect!"
elif score > 70:
    "Good job!"
elif score > 50:
    "Not bad."
else:
    "Keep trying!"
```]],
		},
	},
	{
		label = "else",
		kind = cmp.lsp.CompletionItemKind.Keyword,
		insertText = "else:\n    $0",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**else** - Default condition

Syntax: `else:`

Executes if all previous conditions were False.

Example:
```renpy
if has_key:
    "You unlock the door."
else:
    "The door is locked."
```]],
		},
	},

	{
		label = "python",
		kind = cmp.lsp.CompletionItemKind.Keyword,
		insertText = "python:\n    $0",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**python** - Execute Python code block

Syntax: `python:` (followed by indented Python code)

Runs Python code. Use for complex logic.

Example:
```renpy
python:
    import random
    player_luck = random.randint(1, 20)
    if player_luck > 15:
        outcome = "critical success"
    else:
        outcome = "normal"
```

For single line: `$ variable = value`]],
		},
	},
	{
		label = "init",
		kind = cmp.lsp.CompletionItemKind.Keyword,
		insertText = "init${1: ${2:priority}} python:\n    $0",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**init** - Initialize game data before start

Syntax: `init:` or `init priority python:`

Code in init blocks runs before game starts. Used for:
- Defining characters, images, transforms
- Setting up variables
- Configuration

Example:
```renpy
init python:
    def custom_function():
        return "Hello"

init:
    define e = Character("Eileen")
    image bg room = "images/room.png"
```

Priority (optional): Controls execution order. Lower runs first (default: 0).]],
		},
	},
	{
		label = "define",
		kind = cmp.lsp.CompletionItemKind.Keyword,
		insertText = "define ${1:variable_name} = ${2:value}",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**define** - Define constant at init time

Syntax: `define name = value`

Creates a variable during initialization. Like `init python: name = value` but shorter.

Example:
```renpy
define e = Character("Eileen", color="#c8ffc8")
define config.name = "My Visual Novel"
define narrator = Character(None)
```

For variables that change: use `default` instead.]],
		},
	},
	{
		label = "default",
		kind = cmp.lsp.CompletionItemKind.Keyword,
		insertText = "default ${1:variable_name} = ${2:value}",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**default** - Set default value for variable

Syntax: `default name = value`

Sets initial value for variable. Created on game start or if variable doesn't exist.

Example:
```renpy
default player_name = "Player"
default health = 100
default inventory = []
```

Unlike `define`, `default` variables can change during gameplay and are saved.]],
		},
	},

	{
		label = "transform",
		kind = cmp.lsp.CompletionItemKind.Keyword,
		insertText = "transform ${1:name}:\n    ${2:xalign 0.5 yalign 0.5}\n    $0",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**transform** - Define reusable transformation/animation

Syntax:
```renpy
transform name:
    properties and ATL animation
```

Creates named transform for positioning, sizing, or animating displayables.

Example:
```renpy
transform left:
    xalign 0.0
    yalign 1.0

transform bounce:
    yoffset 0
    linear 0.5 yoffset -30
    linear 0.5 yoffset 0
    repeat

show eileen at left
show ball at bounce
```]],
		},
	},
	{
		label = "at",
		kind = cmp.lsp.CompletionItemKind.Keyword,
		insertText = "at ${1:transform_name}",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**at** - Apply transform to displayable

Syntax: `show image at transform`

Applies one or more transforms to an image.

Example:
```renpy
show eileen at left          # Position at left
show sprite at left, bounce  # Multiple transforms
show bg at truecenter        # Built-in transform
```

Built-in positions: left, center, right, truecenter, topleft, topright, etc.]],
		},
	},

	{
		label = "screen",
		kind = cmp.lsp.CompletionItemKind.Keyword,
		insertText = "screen ${1:name}:\n    $0",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**screen** - Define custom UI screen

Syntax: `screen name(parameters):`

Creates custom UI overlay with widgets, buttons, text, etc.

Example:
```renpy
screen stats_display:
    frame:
        xalign 1.0 yalign 0.0
        vbox:
            text "HP: {player_hp}"
            text "MP: {player_mp}"

# Show screen
show screen stats_display
```

Used for: HUDs, custom menus, inventory, etc.]],
		},
	},
	{
		label = "image",
		kind = cmp.lsp.CompletionItemKind.Keyword,
		insertText = 'image ${1:name} = "${2:path/to/image.png}"',
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**image** - Define an image

Syntax: `image name = displayable`

Associates a name with an image file or displayable.

Example:
```renpy
image eileen happy = "images/eileen_happy.png"
image bg room = "backgrounds/room.jpg"
image logo = Text("My Game", size=60)
```

Images in `images/` folder auto-define by filename:
- `images/eileen happy.png` → `image eileen happy`]],
		},
	},

	{
		label = "window",
		kind = cmp.lsp.CompletionItemKind.Keyword,
		insertText = "window ${1|show,hide,auto|}",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**window** - Control dialogue window visibility

Syntax: `window show/hide/auto [transition]`

Controls when dialogue window (textbox) appears:
- `window show` - Shows window
- `window hide` - Hides window
- `window auto` - Auto show/hide (default behavior)

Example:
```renpy
window hide dissolve  # Hide window with fade
scene bg room with fade
window show dissolve  # Show window with fade
"Now we can talk."
```

Used for clean scene transitions.]],
		},
	},
	{
		label = "pause",
		kind = cmp.lsp.CompletionItemKind.Keyword,
		insertText = "pause${1: ${2:1.0}}",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**pause** - Pause game for player interaction

Syntax: `pause [time]`

Pauses game, waiting for player to click or time to pass.

Example:
```renpy
pause        # Wait for click
pause 2.0    # Wait 2 seconds or click
pause 1.5 hard  # Must wait 1.5 seconds
```

Useful after scene changes or for dramatic timing.]],
		},
	},
	{
		label = "vbox",
		kind = cmp.lsp.CompletionItemKind.Property,
		insertText = "vbox:\n    $0",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**vbox** - Vertical box layout

Arranges children vertically (top to bottom).

Example:
```renpy
screen menu_screen:
    vbox:
        spacing 20
        textbutton "Start Game" action Start()
        textbutton "Load Game" action ShowMenu("load")
        textbutton "Quit" action Quit()
```]],
		},
	},
	{
		label = "hbox",
		kind = cmp.lsp.CompletionItemKind.Property,
		insertText = "hbox:\n    $0",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**hbox** - Horizontal box layout

Arranges children horizontally (left to right).

Example:
```renpy
screen stats:
    hbox:
        spacing 30
        text "HP: [hp]"
        text "MP: [mp]"
        text "Gold: [gold]"
```]],
		},
	},
	{
		label = "frame",
		kind = cmp.lsp.CompletionItemKind.Property,
		insertText = "frame:\n    $0",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**frame** - Box with background/border

Container with customizable background and padding.

Example:
```renpy
screen info_box:
    frame:
        xalign 0.5 yalign 0.5
        padding (30, 20)
        vbox:
            text "Important Info"
            text "Details here"
```]],
		},
	},
	{
		label = "viewport",
		kind = cmp.lsp.CompletionItemKind.Property,
		insertText = 'viewport:\n    ${1:scrollbars "vertical"}\n    ${2:mousewheel True}\n    $0',
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**viewport** - Scrollable container

Creates scrollable area for content larger than container.

Example:
```renpy
screen inventory:
    viewport:
        scrollbars "vertical"
        mousewheel True
        ysize 400
        vbox:
            for item in inventory:
                textbutton item action Return(item)
```]],
		},
	},

	{
		label = "textbutton",
		kind = cmp.lsp.CompletionItemKind.Property,
		insertText = 'textbutton "${1:label}" action ${2:action}',
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**textbutton** - Text-based button

Creates clickable button with text label.

Example:
```renpy
screen main_menu:
    vbox:
        textbutton "Start Game" action Start()
        textbutton "Load Game" action ShowMenu("load")
        textbutton "Options" action ShowMenu("preferences")
        textbutton "Quit" action Quit(confirm=True)
```

Common actions: Start(), Jump(), Call(), ShowMenu(), Quit()]],
		},
	},
	{
		label = "imagebutton",
		kind = cmp.lsp.CompletionItemKind.Property,
		insertText = 'imagebutton:\n    idle "${1:idle.png}"\n    hover "${2:hover.png}"\n    action ${3:Jump("${4:label}")}',
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**imagebutton** - Image-based button

Button using images for different states.

Example:
```renpy
screen custom_menu:
    imagebutton:
        idle "button_idle.png"
        hover "button_hover.png"
        action Jump("start")
        xpos 100 ypos 200
```

States: idle, hover, selected_idle, selected_hover, insensitive]],
		},
	},
	{
		label = "text",
		kind = cmp.lsp.CompletionItemKind.Property,
		insertText = 'text "${1:content}"',
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**text** - Display text

Shows text in screens. Supports interpolation and styling.

Example:
```renpy
screen hud:
    text "Score: [score]" xpos 10 ypos 10
    text "Level [level]" size 40 color "#ff0000"
    text player_name font "myfont.ttf"
```

Use [brackets] for variable interpolation.]],
		},
	},
	{
		label = "input",
		kind = cmp.lsp.CompletionItemKind.Property,
		insertText = 'input value ${1:VariableInputValue("${2:variable_name}")}',
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**input** - Text input field

Allows player to enter text.

Example:
```renpy
screen name_input:
    frame:
        vbox:
            text "Enter your name:"
            input value VariableInputValue("player_name")
            textbutton "Continue" action Return()

label start:
    call screen name_input
    "Hello, [player_name]!"
```]],
		},
	},
	{
		label = "bar",
		kind = cmp.lsp.CompletionItemKind.Property,
		insertText = "bar value ${1:value} range ${2:max_value}",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**bar** - Progress/stat bar

Displays a filled bar (health, progress, etc).

Example:
```renpy
screen health_bar:
    frame:
        bar value player_hp range 100:
            xsize 200
            ysize 20
```

Can be interactive (for volume, brightness, etc) or just display.]],
		},
	},

	{
		label = "linear",
		kind = cmp.lsp.CompletionItemKind.Function,
		insertText = "linear ${1:duration} ${2:property} ${3:value}",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**linear** - Linear interpolation in ATL

Smoothly changes property over time.

Example:
```renpy
transform fade_in:
    alpha 0.0
    linear 1.0 alpha 1.0

transform slide_left:
    xalign 1.0
    linear 0.5 xalign 0.0
```]],
		},
	},
	{
		label = "ease",
		kind = cmp.lsp.CompletionItemKind.Function,
		insertText = "ease ${1:duration} ${2:property} ${3:value}",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**ease** - Ease-in-out interpolation in ATL

Smoothly accelerates and decelerates.

Example:
```renpy
transform bounce:
    yoffset 0
    ease 0.5 yoffset -50
    ease 0.5 yoffset 0
    repeat
```]],
		},
	},
	{
		label = "repeat",
		kind = cmp.lsp.CompletionItemKind.Keyword,
		documentation = {
			kind = "markdown",
			value = [[**repeat** - Loop ATL animation

Repeats animation from beginning.

Example:
```renpy
transform pulse:
    zoom 1.0
    linear 0.5 zoom 1.1
    linear 0.5 zoom 1.0
    repeat
```]],
		},
	},
	{
		label = "parallel",
		kind = cmp.lsp.CompletionItemKind.Keyword,
		insertText = "parallel:\n    $0",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**parallel** - Run ATL animations simultaneously

Executes multiple animation blocks at same time.

Example:
```renpy
transform move_and_fade:
    parallel:
        linear 1.0 xalign 0.5
    parallel:
        alpha 0.0
        linear 1.0 alpha 1.0
```]],
		},
	},
	{
		label = "Jump",
		kind = cmp.lsp.CompletionItemKind.Function,
		insertText = 'Jump("${1:label}")',
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**Jump()** - Screen action to jump to label

Jumps to specified label from screen button.

Example:
```renpy
screen menu:
    textbutton "Start Game" action Jump("start")
    textbutton "Chapter 2" action Jump("chapter2")
```]],
		},
	},
	{
		label = "Call",
		kind = cmp.lsp.CompletionItemKind.Function,
		insertText = 'Call("${1:label}")',
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**Call()** - Screen action to call label

Calls label and returns after it finishes.

Example:
```renpy
screen game_menu:
    textbutton "Stats" action Call("show_stats")
```]],
		},
	},
	{
		label = "Show",
		kind = cmp.lsp.CompletionItemKind.Function,
		insertText = 'Show("${1:screen_name}")',
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**Show()** - Screen action to show screen

Shows another screen.

Example:
```renpy
screen main:
    textbutton "Inventory" action Show("inventory")
```]],
		},
	},
	{
		label = "Hide",
		kind = cmp.lsp.CompletionItemKind.Function,
		insertText = 'Hide("${1:screen_name}")',
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**Hide()** - Screen action to hide screen

Hides specified screen.

Example:
```renpy
screen popup:
    textbutton "Close" action Hide("popup")
```]],
		},
	},
	{
		label = "Return",
		kind = cmp.lsp.CompletionItemKind.Function,
		insertText = "Return(${1:value})",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**Return()** - Screen action to return value

Returns from screen with optional value.

Example:
```renpy
screen choice_menu:
    vbox:
        textbutton "Option A" action Return("a")
        textbutton "Option B" action Return("b")

label start:
    call screen choice_menu
    if _return == "a":
        "You chose A"
```]],
		},
	},
	{
		label = "SetVariable",
		kind = cmp.lsp.CompletionItemKind.Function,
		insertText = 'SetVariable("${1:variable}", ${2:value})',
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**SetVariable()** - Set variable from screen

Sets a variable to specified value.

Example:
```renpy
screen difficulty:
    textbutton "Easy" action SetVariable("difficulty", 1)
    textbutton "Hard" action SetVariable("difficulty", 3)
```]],
		},
	},
	{
		label = "ToggleVariable",
		kind = cmp.lsp.CompletionItemKind.Function,
		insertText = 'ToggleVariable("${1:variable}")',
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = [[**ToggleVariable()** - Toggle boolean variable

Toggles variable between True/False.

Example:
```renpy
screen options:
    textbutton "Fullscreen" action ToggleVariable("persistent.fullscreen")
```]],
		},
	},
	{
		label = "xalign",
		kind = cmp.lsp.CompletionItemKind.Property,
		insertText = "xalign ${1:0.5}",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = "**xalign** - Horizontal alignment (0.0=left, 0.5=center, 1.0=right)",
		},
	},
	{
		label = "yalign",
		kind = cmp.lsp.CompletionItemKind.Property,
		insertText = "yalign ${1:0.5}",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = "**yalign** - Vertical alignment (0.0=top, 0.5=center, 1.0=bottom)",
		},
	},
	{
		label = "xpos",
		kind = cmp.lsp.CompletionItemKind.Property,
		insertText = "xpos ${1:100}",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = "**xpos** - Absolute horizontal position in pixels",
		},
	},
	{
		label = "ypos",
		kind = cmp.lsp.CompletionItemKind.Property,
		insertText = "ypos ${1:100}",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = "**ypos** - Absolute vertical position in pixels",
		},
	},
	{
		label = "xanchor",
		kind = cmp.lsp.CompletionItemKind.Property,
		insertText = "xanchor ${1:0.5}",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = "**xanchor** - Horizontal anchor point of displayable (0.0=left edge, 1.0=right edge)",
		},
	},
	{
		label = "yanchor",
		kind = cmp.lsp.CompletionItemKind.Property,
		insertText = "yanchor ${1:0.5}",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = "**yanchor** - Vertical anchor point of displayable (0.0=top edge, 1.0=bottom edge)",
		},
	},
	{
		label = "xsize",
		kind = cmp.lsp.CompletionItemKind.Property,
		insertText = "xsize ${1:200}",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = "**xsize** - Width in pixels",
		},
	},
	{
		label = "ysize",
		kind = cmp.lsp.CompletionItemKind.Property,
		insertText = "ysize ${1:100}",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = "**ysize** - Height in pixels",
		},
	},
	{
		label = "spacing",
		kind = cmp.lsp.CompletionItemKind.Property,
		insertText = "spacing ${1:10}",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = "**spacing** - Space between children in box layouts (pixels)",
		},
	},
	{
		label = "padding",
		kind = cmp.lsp.CompletionItemKind.Property,
		insertText = "padding (${1:left}, ${2:top}, ${3:right}, ${4:bottom})",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = "**padding** - Internal padding (left, top, right, bottom) or single value for all sides",
		},
	},
	{
		label = "alpha",
		kind = cmp.lsp.CompletionItemKind.Property,
		insertText = "alpha ${1:1.0}",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = "**alpha** - Opacity (0.0=transparent, 1.0=opaque)",
		},
	},
	{
		label = "zoom",
		kind = cmp.lsp.CompletionItemKind.Property,
		insertText = "zoom ${1:1.0}",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = "**zoom** - Scale factor (1.0=original size, 2.0=double size)",
		},
	},
	{
		label = "rotate",
		kind = cmp.lsp.CompletionItemKind.Property,
		insertText = "rotate ${1:0}",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = "**rotate** - Rotation in degrees (clockwise)",
		},
	},
	{
		label = "style",
		kind = cmp.lsp.CompletionItemKind.Keyword,
		insertText = "style ${1:style_name}",
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = "**style** - Define or apply style for customizing UI appearance",
		},
	},
	{
		label = "voice",
		kind = cmp.lsp.CompletionItemKind.Keyword,
		insertText = 'voice "${1:audio/voice.ogg}"',
		insertTextFormat = 2,
		documentation = {
			kind = "markdown",
			value = "**voice** - Play voice file synchronized with dialogue line",
		},
	},
	{
		label = "nvl",
		kind = cmp.lsp.CompletionItemKind.Keyword,
		documentation = {
			kind = "markdown",
			value = "**nvl** - NVL-mode (Novel Visual) for full-screen text display",
		},
	},
}

function source:is_available()
	return vim.bo.filetype == "renpy"
end

function source:complete(params, callback)
	local prefix = params.context.cursor_before_line:match("%S+$") or ""
	local items = {}

	for _, item in ipairs(completion_items) do
		if item.label:lower():find(prefix:lower(), 1, true) == 1 then
			table.insert(items, item)
		end
	end

	callback({ items = items, isIncomplete = false })
end

function source:resolve(item, callback)
	callback(item)
end

function source:cancel() end

return source
