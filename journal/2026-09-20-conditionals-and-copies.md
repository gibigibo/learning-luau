# A number is a copy, an object is not

**September 20, 2026**

Started conditionals today, and most of the session went into a speed boost part I built while learning them.

## Finding the default speed instead of looking it up

I wanted to know what a player's normal `WalkSpeed` is. Instead of searching for it, I printed it from the running game:

```lua
print("The speed is", Humanoid.WalkSpeed)
```

16. A certain answer from my own game rather than a number from a forum post.

That print also taught me something. I had hit `attempt to concatenate Instance with string` again, the same error as two days ago, because I tried to join the touching part itself instead of its `Name`. The comma version doesn't have that problem: `..` is an operator that builds one string and only accepts text or numbers, while a comma just separates values handed to a function, and `print` takes as many as I give it, of any type. `print("Player:", player)` prints `nil` happily where `..` would crash the script.

## The boost

```lua
local speedBoost = script.Parent

local function onTouch(otherPart)
	local character = otherPart.Parent
	local Humanoid = character:FindFirstChildWhichIsA("Humanoid")
	local normalSpeed = 16

	if Humanoid and Humanoid.WalkSpeed <= 50 then
		Humanoid.WalkSpeed += 10
		speedBoost.CanTouch = false
		speedBoost.Transparency = 1
		task.wait(5)
		Humanoid.WalkSpeed = normalSpeed
		speedBoost.Transparency = 0.65
		speedBoost.CanTouch = true
	end
end

speedBoost.Touched:Connect(onTouch)
```

`FindFirstChildWhichIsA("Humanoid")` is how I check that whoever touched the part is a character: `otherPart` is a foot, `otherPart.Parent` is the whole character, and the search returns the Humanoid or `nil`. Writing `character.Humanoid` directly would throw an error when it isn't there, which is exactly the case I'm trying to catch.

Two decisions of mine in there: the part has `CanCollide` off so you run through it instead of climbing it, and the `<= 50` cap exists because once I put several of these on a map, a player could otherwise stack boosts forever.

`CanTouch = false` is my debounce. I turn the part's ability to fire events off while the boost is running. My first version put the `CanTouch = true` before the five second wait, which meant the part reopened while the boost was still counting down: stand still on it and a second copy of the function starts, raises the speed again, and the two copies fight over the same value. Moving one line fixed it.

## The question I got stuck on

The function raises `Humanoid.WalkSpeed`, so why doesn't `normalSpeed` change with it?

Because a variable takes a **copy** of a value, not a link to it. The number 16 goes into `normalSpeed` and stays there no matter what happens to the property afterwards.

Objects are the exception, and that's why the rest of the script works at all:

```lua
local part = workspace.PracticePart
part.Transparency = 0.5      -- this changes the real part
```

A variable holding an object holds a reference to it, like an address, so changing something through the variable changes the actual thing in the game. `Humanoid` is an object, so `Humanoid.WalkSpeed += 10` affects the character. `normalSpeed` is a number, so it's a frozen copy.

One thing I still need to fix: `local normalSpeed = 16` is just the same hardcoded number with a nicer name. To really remember the original it has to read the property before the boost: `local normalSpeed = Humanoid.WalkSpeed`.

## Dots and colons

I kept getting `.` and `:` wrong, and the explanation I got first made it worse. What finally made sense is the simple version: everything inside an object is reached with a dot, and the only special case is that a function belonging to the object is run with a colon.

```lua
part.Transparency = 0.5     -- a number inside the part
part:Destroy()              -- a function inside the part
```

No parentheses means a dot. Parentheses on a function that belongs to the object mean a colon.

## Next

- Multiple conditions
