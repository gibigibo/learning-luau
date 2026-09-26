# Luau Notebook

Everything I've learned about coding in Roblox, organized by topic. I update it after every new topic.

**Last updated:** September 26, 2026

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
- To see what a script did: press Play, select the object in Explorer, and look at Properties **while the game is running**. That includes things a script added, like a ParticleEmitter inside my character's Head (Workspace, then my name, then Head).
- Keep the Output window open. Always.
- **Don't edit code while the game is running.** Signs that it's running: the red square is lit, and there are Client and Server tabs. Edits made in test mode are not saved, and a second tab with the same script name is a warning sign.

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

`+` doesn't join text. In Lua it's only for math, and on normal text it fails with an `attempt to perform arithmetic` error.

### Text has its own functions

Text values come with functions of their own, called with a colon, like `part:Destroy()`:

```lua
local word = "Hello"
print(word:rep(3))     -- HelloHelloHello
print(word:upper())    -- HELLO: every letter, not just the first
print(word:lower())    -- hello
print(word:reverse())  -- olleH
```

- `rep` is short for repeat.
- Online they're written as `string.rep`, `string.upper` and so on. That `string` is Lua's built-in toolbox for text.

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

`%` is the easy way to tell even from odd: `n % 2` is `0` for an even number and `1` for an odd one. That holds for negative numbers too, because when dividing by a positive number, the remainder in Lua is never negative:

```lua
print(7 % 2)     -- 1: odd
print(8 % 2)     -- 0: even
print(-3 % 2)    -- 1: still odd, not -1
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
- Lines after an `if` run no matter what the check said. Anything that should happen only when the check passes goes **inside** the `if`.
- Only two values count as false: `false` and `nil`. Everything else counts as true, including `0` and empty text.
- So `if raceActive then` is enough, and `if not raceActive then` replaces `== false`. `== true` adds nothing when the value is always true or false.

### and, or, not

- `a and b`: true only if both are.
- `a or b`: true if at least one is.
- `not a`: flips it. `if humanoid and not raceActive then` means "a character touched, and the race isn't running".
- `and` stops as soon as it knows the answer. In `if humanoid and humanoid.WalkSpeed <= 50`, if `humanoid` is `nil`, the right side never runs, so there's no error. The order matters.

### and / or hand back values

`and` and `or` don't only produce true or false. They hand back one of the two values:

- `a and b` gives `a` if `a` is false, otherwise `b`.
- `a or b` gives `a` if `a` is true, otherwise `b`.

A way to picture `and`: a guard at a door checks a ticket first, and only then an ID. No ticket, and he doesn't even look at the ID: "no ticket" is the answer. Ticket OK, and the answer is whatever the ID check says.

That's why this one line works like an `if`:

```lua
return boolean and "Yes" or "No"
```

My own one, from the Even or Odd kata:

```lua
return (number % 2) == 1 and "Odd" or "Even"
```

The trap: it breaks when the middle value is `false` or `nil`. `true and false or "oops"` gives `"oops"`. In Luau there's a cleaner form without the trap: `if boolean then "Yes" else "No"`, which plain Lua doesn't have.

It also relies on `0` counting as true. In `cond and 0 or n * m`, when the condition is true the result is `0 or n * m`, and that stays `0` only because `0` is not false.

### Reading a line like this

Treat it like arithmetic: replace one small piece at a time with its answer, until one value is left. With `n = 5, m = -5`:

```text
(n <= 0 or m <= 0) and 0 or n * m
(5 <= 0 or -5 <= 0) and 0 or 5 * -5
(false or true) and 0 or 5 * -5
true and 0 or 5 * -5
0 or 5 * -5
0
```

- A comparison is not a command. It's a question whose answer is a value, `true` or `false`.
- Parentheses work like in math: the inside is answered first.
- Talk about the parts as **first** and **second**, not left and right.

### When to use which

| Situation | What to write |
|---|---|
| The decision chooses which code runs, or needs more than one line | A normal `if` |
| Choosing between two simple values in Roblox | `if ... then ... else` as a one-line value |
| A default value | `local speed = customSpeed or 16` |
| Choosing between two values in plain Lua | `if`, or `and`/`or` when it reads easily |

- `and`/`or` produce a **value**, so they fit where a statement can't: `print(raceActive and "Racing" or "Waiting")`.
- There is no speed difference worth thinking about. Choose what's easiest to read.
- If I have to stop and decode a line step by step, it should be an `if`.

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
- The condition is only checked at the start of each round. A round that already began finishes even if the condition became false during its `task.wait`. To stop that, check the condition again inside the loop, after the wait:

```lua
while raceActive do
	task.wait(1)
	if raceActive then
		timePassed += 1
	end
end
```

### Is this still my run?

A true/false can't tell that it changed and changed back while a loop was sleeping. A number that only goes up can. Give every run a number, and let each loop remember its own:

```lua
local function timer()
	local myRace = raceNumber      -- this call's own copy
	while raceActive and myRace == raceNumber do
		task.wait(1)
		if raceActive and myRace == raceNumber then
			timePassed += 1
		end
	end
end
```

- `raceNumber` goes up by one every time a race ends (or starts), and never goes back.
- Every call to the function gets its own local `myRace`, frozen at the number it started with.
- An old loop that wakes up during a newer race sees a different number and leaves.
- The `while` and the `if` check the same thing on purpose: one before sleeping, one after waking.

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
| Color of a ParticleEmitter | ColorSequence | `ColorSequence.new(Color3.fromRGB(0, 0, 255))` |

A ParticleEmitter's `Color` isn't a Color3. It takes a ColorSequence, and `ColorSequence.new(...)` makes one out of a single Color3.

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
- `Destroy` takes all the children with it. If the script sits inside that part, the script is destroyed too, and any run of it that's still waiting in a `task.wait` is cancelled and never continues. The line that destroys the script's own part comes last.
- The parent decides whether code runs at all: a Script inside `Workspace` or `ServerScriptService` runs, the same script inside a storage service or under `Players` does not.

### Looking for a child

| Function | Looks for | Returns |
|---|---|---|
| `FindFirstChild("Humanoid")` | A child with that **name** | The child, or `nil` |
| `FindFirstChildWhichIsA("Humanoid")` | A child of that **class** | The child, or `nil` |
| `FindFirstChildOfClass("Humanoid")` | That exact class | The child, or `nil` |
| `WaitForChild("Head")` | A child with that **name** | The child. If it isn't there yet, it waits until it is |

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
- With parentheses, `Connect(onTouch())`, Lua first runs `onTouch`, right when the script starts and with nothing in its parentheses, and hands `Connect` whatever came out. It's the same order as `print(give())`: what's inside the parentheses is worked out first. That's how the whole language works, not something special about `Touched`.
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
- If the function contains `task.wait`, new calls keep starting while the first one is still waiting, so several copies of it run at the same time. The fix is a debounce, below.

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

The course does it through the Players service:

```lua
local player = Players:GetPlayerFromCharacter(otherPart.Parent)
if player then
	-- player is the Player, the one that holds leaderstats
end
```

- `GetPlayerFromCharacter` gives the Player whose character that is, or `nil`. The Player is what holds things like `leaderstats`. The character is only the body.
- A hat isn't directly inside the character. Its parent is the hat itself, so a hat touch gives `nil`.

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

A `Connect` line runs **once**, when the script starts, so wrapping it in an `if` only decides whether the connection is ever made. It does not check anything on later touches. Conditions that need checking every time go **inside** the function.

### Debounce

Debounce is not a Luau keyword. It's the name of a technique: making one touch count as one. The word comes from electronics, where a physical button bounces and registers several presses.

**Option 1: the part stops firing events** while the work is happening:

```lua
part.CanTouch = false
-- do the thing, including any task.wait
part.CanTouch = true
```

The line that turns it back on has to come **after** the waiting. If it comes before, the part reopens while the first run is still going, and a second copy of the function starts alongside it.

With a player check, all of it goes inside the `if`:

```lua
local function onTouch(otherPart)
	local player = Players:GetPlayerFromCharacter(otherPart.Parent)
	if player and part.CanTouch then
		part.CanTouch = false
		-- do the thing, including any task.wait
		part.CanTouch = true
	end
end
```

- `CanTouch` goes off only after checking that it's a player. Otherwise a hat or a falling part turns it off, and nothing turns it back on.
- `part.CanTouch` is checked in the `if` too, because touches from the same moment can still arrive after it's off.

**Option 2: a true/false that says "busy".** The race script does this with `raceActive`:

```lua
local busy = false

local function onTouch(otherPart)
	if not busy then
		busy = true
		-- do the thing, including any task.wait
		busy = false
	end
end
```

`CanTouch` only works for touches. The true/false works with any event, and it's the version most other people's code uses.

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
- `<eof>` means end of file: Luau reached the end while still waiting for something, usually an `end`. The line in "to close 'function' at line N" is where the unclosed block starts. The "did you forget..." part is only Studio's guess, and can point to the wrong place.
- `attempt to index nil with 'Parent'`: the code tried to take `.Parent` from something that is `nil`. In that line, whatever comes right before `.Parent` is the empty one.
- The message names the object it looked inside, with its full path, for example `MeshPart "Workspace.Alpharenko.RightFoot"`. That alone often tells me what an object is and where it sits.
- The lines from `Stack Begin` to `Stack End` show the path the code took to reach the error.
- **The script stops at the line with the error.** Nothing after it runs.
- Script Analysis does **not** catch this kind of error, because the editor can't know what will exist in the game. It only shows up in Output.

**How to fix it:** check the exact name and location in Explorer.

**No error, but something doesn't happen:** put a `print` before and after the suspicious line. If the second one never shows up in Output, the code stopped in between.

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

### Running plain Lua

- VS Code only edits Lua. Running it needs Lua installed on the computer.
- Without installing anything: [OneCompiler](https://onecompiler.com/lua) runs Lua in the browser.
- On Codewars, anything printed inside the solution shows up in the output when pressing Test.

### Learning from Codewars

- Check the formula against the examples by hand before writing code. The examples are part of the task.
- After solving, read two or three other solutions.
- **Fork** opens someone else's solution as my own copy, so I can add prints and run the tests on it. **Compare with your solution** shows both side by side.
- Every kata has tags, like `FUNDAMENTALS` or `ALGORITHMS`, and the kata search can filter by them.
- An algorithm is a recipe of steps for solving a problem. The classic ones (sorting, searching, finding a path) mostly work on lists, so the `ALGORITHMS` tag waits until after tables.
- LeetCode is built around job interviews, with every problem tagged by the technique it trains. It doesn't support Lua, so I stay on Codewars.

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
| `0` counts as true in Lua | Only `false` and `nil` are false. `0 or 25` gives `0` |
| `else if` with a space is two statements | It opens a new `if` that needs its own `end`. The error is `'end' expected (to close 'if' at line N)` |
| A local function can't be seen from above | A function written earlier that calls it gets `nil`, and fails with `attempt to call a nil value` when it runs |
| A true/false can't show that it changed and changed back | Use a number that only goes up, and let each loop remember its own |
| Edits made while the game is running are lost | Stop the game before changing code |
| `Connect(onTouch())` runs the function right away | `attempt to index nil with 'Parent'` as soon as the game starts. No parentheses inside `Connect` |
| `+` doesn't join text | Text is joined with `..` |
| Destroying the part a script sits in destroys the script too | A run that's still waiting never continues. Destroy the script's own part last |
| A line after an `if` runs even when the check failed | What only the one who passed should do goes inside the `if` |
| Copies of a part each have their own script | Changing one copy's script doesn't change the others |
