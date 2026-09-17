# Luau Notebook

Everything I've learned about coding in Roblox, organized by topic. I update it after every new topic.

**Last updated:** September 17, 2026

## Contents

1. [Working in Studio](#working-in-studio)
2. [How a script is ordered](#how-a-script-is-ordered)
3. [Style and readability](#style-and-readability)
4. [Comments](#comments)
5. [Variables](#variables)
6. [Types (optional for now)](#types-optional-for-now)
7. [Objects and properties](#objects-and-properties)
8. [Roblox value types](#roblox-value-types)
9. [Services and GetService](#services-and-getservice)
10. [Parents and children](#parents-and-children)
11. [Reading an error](#reading-an-error)
12. [Mistakes I made and what I learned](#mistakes-i-made-and-what-i-learned)

---

## Working in Studio

| Window | What it does |
|---|---|
| Explorer | Every object in the game, as a tree of "what is inside what" |
| Properties | The properties of the object I selected |
| Output | Prints and errors **while the game is running** |
| Script Analysis | Warnings **while I'm writing**, before I even run anything |
| Command Bar | The bar at the bottom of the screen. Runs one line of code immediately, without Play, using `Ctrl+Enter` |

**Rules to remember**

- A script runs only when the game runs (the blue Play button), top to bottom, once.
- A regular Script runs only if it's inside `ServerScriptService` or `Workspace`.
- When I stop the game (the red square), **everything resets** to edit mode: both changes I made by hand and changes the script made.
- To see what a script did: press Play, select the object in Explorer, and look at Properties **while the game is running**.
- Keep the Output window open. Always.

---

## How a script is ordered

Code is read top to bottom, so everything has to be defined **before** it's used.

The common skeleton, in six parts:

```lua
-- 1. Services
local Players = game:GetService("Players")

-- 2. References to objects in the game
local door = workspace.Door

-- 3. Settings that never change
local OPEN_TIME = 3

-- 4. State: variables that change while the game runs
local isOpen = false

-- 5. Functions
local function openDoor()
	-- ...
end

-- 6. Events: connect everything at the bottom
door.Touched:Connect(openDoor)
```

> I haven't learned functions and events yet. The skeleton is here so I get used to the order.

---

## Style and readability

**Indentation:** every word that opens a block (`then`, `do`, `function`) pushes the lines after it one Tab in. The `end` that closes the block goes back to the same column.

**The Format button** (Script tab) fixes indentation. It does **not** add spaces inside a line. I do that by hand.

**Spaces:** a space on both sides of `=`, and a space after every comma.

```lua
part.Transparency = 0.5
part.Size = Vector3.new(35, 35, 35)
```

**Blank lines** between different parts of the code.

**Names:**

| Style | Used for | Example |
|---|---|---|
| camelCase | Variables and functions | `isOpen`, `openDoor` |
| PascalCase | Services | `Players`, `ReplicatedStorage` |
| UPPER_CASE | Settings that never change | `OPEN_TIME` |

**Comments** explain **why** I did something, not **what** the line does.

---

## Comments

```lua
-- one line comment

--[[
	a comment
	on several lines
]]

--[[
print("this code is turned off")
print("delete the opening and closing to turn it back on")
]]

--[==[
	use this form only if the comment contains ]] inside it
]==]
```

**Shortcut:** select a few lines and press `Ctrl + /` to add or remove a comment on each line.

---

## Variables

`local` creates a new variable. When I change the value of a variable that already exists, I **don't** write `local` again.

```lua
local firstCat = "Miso"
local secondCat = "Kaki"
print("My first cat is " .. firstCat .. " and my second cat is " .. secondCat)

secondCat = "Maki"   -- no local: changing a variable that already exists
print("Sorry, my second cat is " .. secondCat)
```

**Basic value types:**

| Type | Example |
|---|---|
| number | `45`, `0.5` |
| string (text) | `"Miso"` |
| boolean (true or false) | `true`, `false` |
| nil (nothing) | `nil` |

**Joining strings:** `..` joins text, but it **doesn't add a space**. The space goes inside the quotes.

```lua
print("my cat is " .. secondCat)   -- my cat is Maki
print("my cat is" .. secondCat)    -- my cat isMaki
```

---

## Types (optional for now)

I can say what type of value a variable is supposed to hold:

```lua
local myName: string = "Daniel"
```

- The check happens **only in the editor**: a yellow underline under the mistake, an orange mark on the scrollbar, and a list in the Script Analysis window.
- **At runtime it's ignored.** That's why `local myName: string = 45` still prints 45.
- `--!strict` at the top of the script turns on strict checking.

---

## Objects and properties

**The dot `.` means "inside".** I read a path from left to right, like an address:

```lua
workspace.PracticePart.Color = Color3.fromRGB(15, 27, 255)
```

| Part | Meaning |
|---|---|
| `workspace` | The game world |
| `.PracticePart` | The part with this name, **inside** workspace |
| `.Color` | Its Color property (the same row I see in Properties) |
| `=` | Put the value on the right in here |
| `Color3.fromRGB(15, 27, 255)` | The value: a color |

**Saving an object in a variable** saves me from writing the full path on every line:

```lua
-- Changing a part's properties
local part = workspace.PracticePart

part.Color = Color3.fromRGB(255, 11, 15)
part.Size = Vector3.new(35, 35, 35)
part.Transparency = 0.5
part.Anchored = true
```

**Things to watch:**

- The name in the code has to be **exactly** the same as in Explorer, including upper and lower case.
- Properties can be linked: when I changed `Color`, `BrickColor` updated by itself to the closest color.
- A part that isn't `Anchored` gets moved by physics. For example, when it grows, it gets pushed and settles at an angle.

---

## Roblox value types

Every property accepts **one type** of value:

| Property | Type | Example |
|---|---|---|
| Transparency | number, from 0 to 1 | `0.5` |
| Anchored | boolean | `true` |
| Color | Color3 | `Color3.fromRGB(255, 11, 15)` |
| Size | Vector3 | `Vector3.new(35, 35, 35)` |
| Position | Vector3 | `Vector3.new(0, 10, 0)` |

### Color3: a color made of three numbers (red, green, blue)

```lua
Color3.fromRGB(15, 27, 255)   -- numbers from 0 to 255
Color3.new(0.06, 0.1, 1)      -- numbers from 0 to 1
Color3.fromHex("#0F1BFF")     -- hex code, like in design tools
```

```lua
part.Color = "blue"   -- error: text is not a Color3
part.Color = 255      -- error: one number is not a color
```

### Vector3: three numbers in space (X, Y, Z)

For `Size` they are width, height and depth. For `Position` they are the location.

---

## Services and GetService

- `game` is the root of the whole game.
- Everything at the top level of Explorer (Workspace, Players, Lighting...) is a **service**.
- `workspace` with a lowercase w is a ready-made shortcut, **only** for the Workspace service.

```lua
local Workspace = game:GetService("Workspace")   -- same as workspace
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
```

It's common to get all services this way, at the top of the script.

| Symbol | Meaning | Example |
|---|---|---|
| `.` | Get what's inside | `workspace.PracticePart` |
| `:` | Run a function of this object | `game:GetService("Players")` |

---

## Parents and children

*Learning this right now.*

- **Parent:** the object something sits inside, in Explorer.
- **Children:** everything inside it.
- `script.Parent` is the object the script itself sits inside.

```lua
-- Script inside ColorPart
local colorPart = script.Parent
colorPart.Color = Color3.fromRGB(50, 240, 255)
```

Why it's useful: I can duplicate the part together with its script, and the code works on every copy without changing any names.

---

## Reading an error

```text
practicePart is not a valid member of Workspace "Workspace"  -  Server - ChangeColor:2
```

| Part | Meaning |
|---|---|
| `practicePart` | The name I looked for |
| `is not a valid member of` | "Doesn't exist inside" |
| `Workspace "Workspace"` | Where I looked: the type, and the name in quotes |
| `ChangeColor:2` | The script name and the line number |

- Clicking the red line in Output jumps to that line in the code.
- The lines from `Stack Begin` to `Stack End` show the path the code took to reach the error.
- **The script stops at the line with the error.** Nothing after it runs.
- Script Analysis does **not** catch this kind of error, because the editor can't know what will exist in the game. It only shows up in Output.

**How to fix it:** check the exact name and location in Explorer.

---

## Mistakes I made and what I learned

| What happened | What I learned |
|---|---|
| Output printed `isMaki` with no space | `..` doesn't add a space |
| I expected an error from `local myName: string = 45` | Types are checked only in the editor, not at runtime |
| Properties showed old values, so I thought my script didn't work | Stopping the game resets everything. Check while the game is running |
| I wrote `practicePart` with a lowercase p | Names are case-sensitive. The error: `is not a valid member of` |
| I pressed Format and expected it to add spaces | Format only fixes indentation |
