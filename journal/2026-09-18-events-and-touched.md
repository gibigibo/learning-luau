# Events: the line that runs once and keeps working

**September 18, 2026, second session**

## Reading the docs instead of guessing

I got to `Touched` in the course, and the line in the documentation meant nothing to me at first:

```text
BasePart.Touched(otherPart: BasePart): RBXScriptSignal
```

It turns out it's four separate things: the class the event belongs to, the event name, what the event hands to my function, and what `part.Touched` itself is. The colon means "of type". Once I could read that line, I could read every other event page too.

## `attempt to concatenate Instance with string`

My first version printed the part that touched the trap:

```lua
print(objectTouched .. " touched the trap")
```

Last time I had this kind of error the problem was `nil`. This time the word was `Instance`, which means the opposite: there is a value, it's just not text. `objectTouched` is the actual object, a piece of the character. What I wanted was its `Name`, which is a property and is text.

I'm starting to read the error properly: the word after `concatenate` tells me what was really there.

## The line I didn't understand

```lua
trap.Touched:Connect(onTouch)
```

`trap.Touched` is a signal object. It doesn't do anything by itself, it just fires. `:Connect` is a function belonging to that signal, and it registers my function as a listener. `onTouch` goes in without parentheses, because I'm handing over the function itself, not its result.

What made it click: this line runs once, when the game starts, and prints nothing. The script then finishes. The connection stays alive on its own, and the function may run five minutes later, twenty times, or never.

## My own exercise: a part that breaks when touched

I wanted to build this myself: touch a part, the part breaks.

The first run destroyed the floor and the part fell through the world. The script was sitting in the part, and the part wasn't anchored, so it was resting on the floor. `Touched` fired the instant the game started, with the floor as the toucher, and my code destroyed whatever touched it.

That's when the two objects inside the function became clear: `part` is me, `otherPart` is whoever touched me. I had been destroying the wrong one.

After anchoring the part in the air, it worked:

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

I had to open my own notebook to remember the `Color3` syntax, which is exactly what the notebook is for.

## The number in Output that I want to come back to

Output said `Touched (x9)`, and after I added `task.wait(1)` it said `Touched (x20)`. A character is made of many parts, and each one fires the event separately. With a wait inside the function, new calls keep starting while the first one is still waiting, so about twenty copies of my function were running at the same time, each at a different stage.

Here it did no harm, because destroying an already destroyed part does nothing. If the function had been handing out points or damage, one touch would have paid out twenty times. The fix is called a debounce and it needs `if`, which is next.

## Two smaller things

I tried putting a script under `Players` so it would sit on the player. It doesn't run there: a regular script only runs inside `Workspace` or `ServerScriptService`. And players only exist in Players while the game is running, so there's nothing to attach to in advance.

I also turned off Studio's AI code completion. It kept writing the lines I'm trying to learn to write.

## Next

- Finish the buttons page in the course
- Conditions, and then the debounce for that `(x20)`
