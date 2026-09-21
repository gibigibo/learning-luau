# Luau Notebook

Everything I've learned about coding in Roblox, organized by topic. I update it after every new topic.

**Last updated:** September 21, 2026

## Contents

1. [Working in Studio](#working-in-studio)
2. [How a script is ordered](#how-a-script-is-ordered)
3. [Style and readability](#style-and-readability)
4. [Comments](#comments)
5. [Variables](#variables)
6. [Operators](#operators)
7. [Conditions](#conditions)
8. [Loops](#loops)
9. [Types (optional for now)](#types-optional-for-now)
10. [Objects and properties](#objects-and-properties)
11. [Roblox value types](#roblox-value-types)
12. [Services and GetService](#services-and-getservice)
13. [Parents and children and script.Parent](#parents-and-children-and-scriptparent)
14. [Functions](#functions)
15. [Events](#events)
16. [Creating objects: Instance.new](#creating-objects-instancenew)
17. [Reading an error](#reading-an-error)
18. [Lua and Luau](#lua-and-luau)
19. [Gotchas](#gotchas)

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

### Copies and references

A variable takes a **copy** of a value, not a link to it:

```lua
local normalSpeed = humanoid.WalkSpeed   -- copies the number 16
humanoid.WalkSpeed += 10                 -- WalkSpeed is now 26
print(normalSpeed)                       -- still 16
```

Objects are the exception. A variable holding an object holds a **reference** to it, like an address, so changing something through the variable changes the real thing in the game:

```lua
local part = workspace.PracticePart
part.Transparency = 0.5                  -- the actual part changes
```

Numbers, text and true/false are copied. Objects are referenced.

### print: `..` versus commas

```lua
print("The speed is " .. humanoid.WalkSpeed)   -- one string, built by me
print("The speed is", humanoid.WalkSpeed)      -- two values, handed to print
```

- `..` is an **operator**. It builds one new string and accepts only text and numbers. It crashes on `nil` and on objects.
- `,` is a **separator**. It hands several values to a function, and it works the same way in every function: `Vector3.new(1, 2, 3)`, `sortGarbage(coal, ocean)`.
- `print` accepts any number of values of any type, puts a space between them, and turns each one into text on its own. An object prints as its name, and `nil` prints as `nil` instead of crashing.
- Rule of thumb: `..` for a sentence shown to a player or stored in a variable, commas for checking what's inside something while developing.
- `tostring(value)` turns anything into text, including `nil`, if I do need it inside a `..`.

### local and scope

`local` decides **where** a variable exists, not what's inside it. The term for that is **scope**.

```lua
local function test()
	local insideOnly = "A"
	globalOne = "B"
end

test()
print(insideOnly)   -- nil: it died at the end of the function
print(globalOne)    -- B
```

- With `local`, the variable lives only in the block where it was created, up to the closest `end`.
- Without `local`, the name goes into the script's global table. Global means the whole file, not the whole game: every script runs in its own environment, so another script reading that name gets `nil` and the warning `Unknown global 'x'`.
- Changing the value of an existing `local` later is not a new variable and does not make it global. `local` is decided once, at creation.
- Luau doesn't require declaring anything: assigning to a name creates it, and reading a name that doesn't exist gives `nil` instead of an error. That's why a missing `local` still runs, and why a typo is only caught when reading the name, not when assigning to it.
- Reasons to always use `local`: it's faster, it can't overwrite a variable belonging to another function in the same file, and the editor can catch typos for me.

---

## Operators

### Math

| Symbol | What it does |
|---|---|
| `+` | Addition |
| `-` | Subtraction |
| `*` | Multiplication |
| `/` | Division |
| `%` | Remainder |
| `^` | Power |

```lua
local coins = 10
coins = coins + 5     -- 15
coins = coins * 2     -- 30

print(10 % 3)         -- 1: the remainder
print(2 ^ 3)          -- 8
```

Shorthand: `coins += 5` is the same as `coins = coins + 5`. There is also `-=`, `*=`, `/=` and `..=`.

Joining text has its own operator, `..`, in the Variables chapter.

### Comparison

| Symbol | What it checks |
|---|---|
| `==` | Equal to |
| `~=` | Not equal to |
| `<` | Less than |
| `>` | Greater than |
| `<=` | Less than or equal to |
| `>=` | Greater than or equal to |

A comparison always produces `true` or `false`:

```lua
print(5 > 3)        -- true
print(5 == 5)       -- true
print(5 == "5")     -- false: a number is not a string
```

**The classic trap:** `=` puts a value into a variable, `==` checks equality. A line like `if coins = 10 then` is a syntax error.

---

## Conditions

```lua
if coins >= 10 then
	print("rich")
elseif coins > 0 then
	print("some")
else
	print("broke")
end
```

- `elseif` is one word. `else if` with a space opens a new `if` that needs its own `end`.
- Only two values count as false: `false` and `nil`. Everything else counts as true, including `0` and empty text.
- So `if raceActive then` is enough. `== true` adds nothing when the value is always true or false.

### and, or, not

- `a and b`: true only if both are.
- `a or b`: true if at least one is.
- `not a`: flips it. `if humanoid and not raceActive then` means "a character touched, and the race isn't running".
- `and` stops as soon as it knows the answer. In `if humanoid and humanoid.WalkSpeed <= 50`, if `humanoid` is `nil`, the right side never runs, so there's no error. The order matters.

### and / or hand back values

`and` and `or` don't only produce true or false. They hand back one of the two values:

- `a and b` gives `a` if `a` is false, otherwise `b`.
- `a or b` gives `a` if `a` is true, otherwise `b`.

That's why this one line works like an `if`:

```lua
return boolean and "Yes" or "No"
```

The trap: it breaks when the middle value is `false` or `nil`. `true and false or "oops"` gives `"oops"`. In Luau there's a cleaner form without the trap: `if boolean then "Yes" else "No"`, which plain Lua doesn't have.

---

## Loops

*A first look. The full chapter comes with stage 4.*

```lua
while raceActive do
	task.wait(1)
	timePassed += 1
end
```

- A `while` loop repeats as long as its condition is true.
- **Every loop needs a `task.wait()`.** Without it the loop never lets anything else in the game run, Studio freezes, and the script is stopped with an error.
- The script **stays inside the loop** until it ends. Nothing below it runs in the meantime, which is why event connections go **above** the loop.
- A loop at the bottom of a script runs once, when the script starts. If its condition is false at that moment, it's skipped and never checked again. To run it later, put it inside a function and call that function when needed.

Two other loops:

```lua
for i = 1, 10 do
	print(i)          -- 1 to 10
end

repeat
	task.wait(1)
until not raceActive  -- checks at the end, so it runs at least once
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

### `.` and `:`

Everything inside an object is reached with a dot. The one special case is running a function that belongs to the object, which uses a colon.

```lua
part.Transparency = 0.5     -- a number inside the part
part:Destroy()              -- a function inside the part
```

| What it is | Symbol | Example |
|---|---|---|
| Property | `.` | `part.Anchored`, `part.Name` |
| Child in Explorer | `.` | `workspace.Ocean`, `script.Parent` |
| Event | `.` | `part.Touched` |
| Function of the object | `:` | `part:Destroy()`, `character:FindFirstChild("X")` |
| Function of an event | `:` | `part.Touched:Connect(onTouch)` |

Quick test: no parentheses means a dot. Parentheses on a function that belongs to an object mean a colon. Functions that only produce a new value, like `Color3.fromRGB(...)`, `Vector3.new(...)` and `Instance.new(...)`, use a dot, because there is no object for them to work on.

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
| Parent | another object | `workspace.Ocean` |

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

## Parents and children and script.Parent

- **Parent:** the object something sits inside, in Explorer.
- **Children:** everything inside it.
- `script.Parent` is the object the script itself sits inside.

```lua
-- Script inside ColorPart
local colorPart = script.Parent
colorPart.Color = Color3.fromRGB(50, 240, 255)
```

Why it's useful: I can duplicate the part together with its script, and the code works on every copy without changing any names.

`Parent` is not only something I read. Setting it **moves the object**, exactly like dragging it in Explorer:

```lua
workspace.Coal.Parent = workspace.Ocean   -- Coal is now inside Ocean
```

- The value of `Parent` is another object, not a number or a color. It answers "who am I inside of".
- `part.Parent = nil` takes an object out of the world but keeps it in memory, so it can be put back. `Destroy` is final.
- The parent decides whether code runs at all: a Script inside `Workspace` or `ServerScriptService` runs, the same script inside a storage service or under `Players` does not.

### Looking for a child

| Function | Looks for | Returns |
|---|---|---|
| `FindFirstChild("Humanoid")` | A child with that **name** | The child, or `nil` |
| `FindFirstChildWhichIsA("Humanoid")` | A child of that **class** | The child, or `nil` |
| `FindFirstChildOfClass("Humanoid")` | That exact class | The child, or `nil` |

```lua
local humanoid = character:FindFirstChildWhichIsA("Humanoid")
```

Why search instead of writing `character.Humanoid`: a direct path **throws an error** when the thing isn't there, and the search returns `nil` quietly. That is what makes it usable in an `if`.

The name explains the behaviour:

| Part of the name | What it means |
|---|---|
| `Find` | It searches, so it may fail. It returns `nil` instead of erroring |
| `FirstChild` | It stops at the first match, and looks only at direct children |
| `WhichIsA` | The test is the class, not the name |

A quick way to see it working:

```lua
print(character, character:FindFirstChildWhichIsA("Humanoid"))
-- a player:      Alpharenko Humanoid
-- anything else: Workspace nil
```

---

## Functions

A function is a named block of code that runs only when I call it.

```lua
-- Prints my favorite food
local function printFood()
	print("Pizza and Sushi, but mostly Sushi")
end

printFood()
```

- `function` opens the block and `end` closes it. `local` creates a variable named `printFood`, and the value inside that variable is the function.
- **Parentheses mean "run it now".** `printFood()` runs the function. `printFood` without parentheses is just the value inside the variable.
- Empty parentheses mean "run it, and give it nothing".
- A line that's only a name, like `printFood`, is a syntax error. Luau expects an assignment or a function call there.

```lua
print(printFood)   -- function: 0x1e39c5bab4c9511f
```

`print` prints what's inside a variable. A function can't be shown as text, so Luau prints its type and an ID. The function itself doesn't run.

### Functions I was already using

Anything followed by parentheses is a function call:

| Code | What goes in the parentheses |
|---|---|
| `print("hello")` | The text to print |
| `Color3.fromRGB(255, 11, 15)` | Three numbers. Gives back a color |
| `Vector3.new(35, 35, 35)` | Three numbers. Gives back a Vector3 |
| `game:GetService("Players")` | The service name. Gives back the service |

Some functions **do** something, like `print`. Others **give back** a value, like `Color3.fromRGB`, and that value goes into a property or a variable.

No parentheses, no function call: `workspace.PracticePart` gets an object, and `part.Anchored` is a property.

### Parameters

The parentheses in the definition list what the function expects to get:

```lua
local function printFood(food)
	print("My favorite food is " .. food)
end

printFood("Sushi")   -- My favorite food is Sushi
printFood("Pizza")   -- My favorite food is Pizza
```

- `food` is a **parameter**: a variable that gets its value when the function is called.
- It exists only inside the function. After `end`, there is no `food`.

More than one parameter is just more names, separated by commas:

```lua
local function sortGarbage(trash, recyclable)   -- parameters
	trash:Destroy()
	Instance.new("ParticleEmitter").Parent = recyclable
end

sortGarbage(workspace.Coal, workspace.Ocean)    -- arguments
```

| Word | Where it is | What it is |
|---|---|---|
| Parameter | The definition line | An empty name waiting for a value |
| Argument | The call line | The value I actually hand over |

What connects them is the **order**, nothing else. The first argument goes into the first parameter. Swapping the two calls above would destroy the ocean and put sparkles on the coal, and the code would run without complaining.

A parameter holds whatever was passed in, including an object. Inside the function, `recyclable` **is** the Ocean part.

### return: handing a value back

Printing is not the same as handing a value back. `print` writes into the Output window, which is a screen I look at, not something the code can use.

```lua
local function shout()
	print("hello")     -- writes to Output
end

local function give()
	return "hello"     -- hands the value back
end

shout()          -- Output: hello
print(give())    -- Output: hello
print(shout())   -- Output: hello, and then an empty line, because shout gave back nil
```

- A function without `return` hands back `nil`. That's why `"I love to eat " .. printFood()` fails with `attempt to concatenate string with nil`.
- `return` also stops the function. Nothing after it runs.
- On Codewars and Exercism, the test calls my function and checks what it **returns**. Printing the right answer doesn't count.
- In Output, a line printed inside a function is tagged with the line of the `print` inside the function, not the line that called it. Same text, different source.

---

## Events

An event is an object that fires when something happens. I connect a function to it, and from then on the function runs every time the event fires.

```lua
-- Script inside a part
local trap = script.Parent

local function onTouch(otherPart)
	print(otherPart.Name .. " touched the trap")
end

trap.Touched:Connect(onTouch)
```

- `trap.Touched` is a signal object. It doesn't do anything by itself, it just fires.
- `:Connect` is a function of that signal. It registers my function as a listener.
- `onTouch` goes in **without parentheses**: the function itself, not its result.
- The `Connect` line runs once, when the game starts, and prints nothing. The script then finishes, but the connection stays alive.

### Reading an event in the docs

```text
BasePart.Touched(otherPart: BasePart): RBXScriptSignal
```

| Part | Meaning |
|---|---|
| `BasePart` | The class the event belongs to. Every Part is a BasePart |
| `.Touched` | The name of the event |
| `(otherPart: BasePart)` | What the event hands to my function: the other part that touched |
| `: RBXScriptSignal` | What `part.Touched` itself is: a signal, not a function |

A colon means "of type". That's why it's `:Connect` and not a call on `Touched` itself. The same signal also has `Once` and `Wait`.

### Touched fires a lot

- A character is made of many parts, and each one fires `Touched` separately. Output groups identical lines and counts them: `Touched (x20)`.
- `Touched` doesn't care who touched: a player, another part, or the ground.
- A part that isn't `Anchored` rests on the floor, so `Touched` fires the moment the game starts, before any player is involved.
- If the function contains `task.wait`, new calls keep starting while the first one is still waiting, so several copies of it run at the same time. The fix is a debounce, which needs `if`.

Inside the function there are always two different objects: the part the script sits in, and the one that touched it.

### Is the toucher a player?

```lua
local function onTouch(otherPart)
	local character = otherPart.Parent
	local humanoid = character:FindFirstChildWhichIsA("Humanoid")
	if humanoid then
		-- it's a character
	end
end
```

`otherPart` is a single body part, its parent is the whole character, and a character always contains a Humanoid. Anything else, like the floor or another part, gives `nil`.

### One function for two parts

A handler receives only what the event hands it. `Touched` hands over who touched, never which part was touched, so one function connected to two parts can't tell them apart. `Connect` accepts only the function, so an extra value after a comma never arrives.

To pass extra information, wrap the call in a small function without a name:

```lua
startLine.Touched:Connect(function(otherPart)
	partTouched(otherPart, startLine)
end)

local function partTouched(otherPart, line)
	if line == startLine then
		-- ...
	end
end
```

`line == startLine` compares the objects themselves, which works because variables hold references to objects. The other option is simply a separate function for each part.

### Debounce

To stop one touch from running the function many times, the part stops firing events while the work is happening:

```lua
part.CanTouch = false
-- do the thing, including any task.wait
part.CanTouch = true
```

The line that turns it back on has to come **after** the waiting. If it comes before, the part reopens while the first run is still going, and a second copy of the function starts alongside it.

---

## Creating objects: Instance.new

`Instance.new("ClassName")` creates a new object from code: the same thing as inserting it by hand in Studio.

```lua
local sparkle = Instance.new("ParticleEmitter")
sparkle.Parent = workspace.Ocean
```

- The first line creates the object, but **it is nowhere in the game yet**. Nothing appears on screen and nothing shows in Explorer.
- The second line gives it a parent, and only then it exists in the world and starts working.
- The name in quotes is the class: `Part`, `Folder`, `ParticleEmitter`, `Fire`, and so on. The same list Insert Object shows.
- Properties are set the same way as on any other object, before or after setting the parent.

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
- The message names the object it looked inside, with its full path, for example `MeshPart "Workspace.Alpharenko.RightFoot"`. That alone often tells me what an object is and where it sits.
- The lines from `Stack Begin` to `Stack End` show the path the code took to reach the error.
- **The script stops at the line with the error.** Nothing after it runs.
- Script Analysis does **not** catch this kind of error, because the editor can't know what will exist in the game. It only shows up in Output.

**How to fix it:** check the exact name and location in Explorer.

---

## Lua and Luau

Luau is Roblox's version of Lua. It started from Lua 5.1 and was released as open source in 2021. Almost all basic code is the same in both.

| Only in Luau | Example |
|---|---|
| Shorthand assignment | `coins += 5` |
| Types | `local name: string = "Daniel"` and `--!strict` |
| `if` that produces a value | `if active then "Yes" else "No"` |
| `continue` in loops | skips one round of a loop |

- Luau removed things that are unsafe in a game running on millions of devices, such as reading files from the player's computer.
- Codewars and Exercism run plain Lua, so none of the Luau-only features work there.
- When searching for help, add "Luau" or "Roblox". Plain Lua tutorials mostly work, except for file access and loading external code.

---

## Gotchas

| Gotcha | What to remember |
|---|---|
| `..` doesn't add a space | `"my cat is" .. "Maki"` prints `my cat isMaki` |
| Types don't stop the game | `local myName: string = 45` only gets a warning in the editor, and still runs |
| Stopping the game resets everything | To see what a script did, check Properties while the game is running |
| Names are case-sensitive | `practicePart` is not `PracticePart`. The error: `is not a valid member of` |
| Format only fixes indentation | Spaces inside a line are added by hand |
| A function name without `()` doesn't run it | `printFood` alone is a syntax error, and `print(printFood)` prints `function: 0x...` |
| A function without `return` hands back `nil` | `"text " .. myFunction()` fails with `attempt to concatenate string with nil` |
| Names in Explorer don't have to be unique | `workspace.ColorPart` returns the first match, so a second part with the same name looks like a broken script |
| `Anchored` freezes a part where it is | It doesn't lift it into the air. Move it up first, and set Anchored while the game is stopped |
| Players exist only while the game is running | A script can't be placed on a player in advance |
| `Instance.new` alone shows nothing | The object has no parent yet. It appears only after `Parent` is set |
| `CanCollide = false` doesn't stop `Touched` | That's how invisible trigger zones work. The property that stops the event is `CanTouch` |
| `character.Humanoid` throws if it isn't there | Use `FindFirstChildWhichIsA("Humanoid")`, which returns `nil` instead |
| A number copied from a property stops tracking it | `local speed = humanoid.WalkSpeed` keeps the old number after the property changes |
| A loop without `task.wait()` freezes Studio | Every `while` and `repeat` needs one inside |
| Code below a loop waits for the loop to end | Connect events above the loop |
| One handler for two parts can't tell them apart | Wrap it and pass the part, or write one function per part |
