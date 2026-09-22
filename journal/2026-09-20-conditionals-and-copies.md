# The default WalkSpeed is 16

**September 20, 2026**

I wanted to know a player's normal speed. Didn't google it, just printed it:

```lua
print("The speed is", Humanoid.WalkSpeed)
```

16. Did that one on my own, without asking.

About that comma: earlier I hit `attempt to concatenate Instance with string` again, same as two days ago. With commas, `print` takes whatever you give it and prints each thing. `..` only joins text and numbers, and crashes on anything else.

Then I built a speed boost while learning conditions:

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

A couple of decisions in there are mine. `CanCollide` is off, so you run through it and get the boost without bumping into anything. And the `<= 50` cap is there because if I put a few of these on a map, a player shouldn't be able to stack boosts forever.

`CanTouch = false` was my way to stop it firing 61 times (that's what Output showed before). My first version turned it back on before the 5 second wait, so the part reopened while the boost was still running. Moved one line to after the wait. Fixed.

Then I got stuck on something that looked obvious. The function changes `Humanoid.WalkSpeed`, so why doesn't `normalSpeed` change with it? Because `normalSpeed` got a copy of the number. Objects work differently: a variable with an object points at the real thing, so changing it through the variable changes the game. `Humanoid.WalkSpeed += 10` changes the character. `normalSpeed` stays 16.

Still need to fix: `local normalSpeed = 16` is just the number 16 with a name on it. It should read the real speed before the boost.

I also spent way too long on `.` versus `:`. The long explanation made it worse. The version that stuck: everything in an object is reached with a dot, and a function that belongs to the object gets a colon. `part.Transparency`, `part:Destroy()`.

## Next

- Multiple conditions
