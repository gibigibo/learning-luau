# My part destroyed the floor

**September 18, 2026, second session**

Got to `Touched` in the course. The line in the docs looked like nonsense to me:

```text
BasePart.Touched(otherPart: BasePart): RBXScriptSignal
```

Broken down it's four things: the class, the event name, what my function gets (the other part), and what `Touched` itself is (a signal). The colon there means "of type".

First try, printing who touched the trap:

```lua
print(objectTouched .. " touched the trap")
```

`attempt to concatenate Instance with string`. Last time it said `nil`, this time `Instance`. `objectTouched` is the actual object, a foot or a hand. I needed `objectTouched.Name`.

Then this line, which I just couldn't get:

```lua
trap.Touched:Connect(onTouch)
```

`Connect` hooks my function to the event. `onTouch` goes in without `()` because I'm handing over the function, not running it. The weird part for me: the line runs once, at the start, and prints nothing. The script ends. And the connection keeps working anyway.

Around here I felt like I was overdoing it, stopping on every little thing I didn't understand. Kept doing it anyway.

Then I came up with my own exercise: touch a part and it breaks. First run, the part destroyed the floor and fell out of the world. The script was in a part that wasn't anchored, so it was sitting on the floor. `Touched` fired the second the game started, the floor was the "other part", and my code destroyed whatever touched it. The floor.

So there are two different things in that function: the part the script is in, and the part that touched it. I was destroying the wrong one. Anchored it up in the air and switched to destroying the part itself:

```lua
local part = script.Parent

local function onTouch(otherPart)
	print("Touched")
	part.Color = Color3.new(1, 0, 0)
	part.Transparency = 0.5
	task.wait(1)
	part:Destroy()
end

part.Touched:Connect(onTouch)
```

Yesss. I had to open my own notebook to remember how to set a color.

Output said `Touched (x9)`, and `(x20)` after I added the wait. A character has a lot of parts, each one fires the event, and with the wait they all pile up. No harm here. Would be a problem if it was giving out points. That fix needs `if`.

Also: I tried putting a script under `Players` so it would sit on the player. Doesn't run there. And I turned off Studio's AI autocomplete. It kept writing the code I'm trying to learn to write.

## Next

- Buttons page
- Conditions, and fix that `(x20)`
