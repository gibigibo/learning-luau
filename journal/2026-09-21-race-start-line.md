# The race that ended on the starting line

**September 21, 2026**

A bit all over the place today.

Codewars first. I didn't get why every solution ends with `return`. The first explanations were too complicated for me. This one worked:

```lua
local function add(a, b)
	return a + b
end

local result = add(2, 3)   -- 5
```

On Codewars the test calls your function and checks what comes back. If you only print the answer, the test gets `nil`.

I solved a kata with a normal `if`, and then saw that everyone else wrote:

```lua
return boolean and "Yes" or "No"
```

In Lua, `and` and `or` give back one of the two values, not just true or false. With `true` you end up at "Yes", with `false` at "No". Only `false` and `nil` count as false, even `0` counts as true. Later I used the same idea on my own code: `if humanoid and raceActive == true` is just `if humanoid and raceActive`.

Loops came up in the course. I did some PHP about ten years ago, so the idea wasn't new. The Roblox part was: every loop needs `task.wait()` or Studio freezes, and nothing under the loop runs until it's done.

Then I ran ahead of the tutorial. It had a finish line, I added a start line.

The `while` loop at the bottom ran once when the game started, saw the race wasn't on, and never checked again. OK, it goes into a function.

Worse: both lines used the same function, and touching the start line a second time ended the race. The function only gets who touched, not what was touched, so start and finish look the same to it.

My idea was to pass the line in:

```lua
startLine.Touched:Connect(partTouched, startLine)
```

Doesn't work, `Connect` only takes the function. But you can wrap it:

```lua
startLine.Touched:Connect(function(otherPart)
	partTouched(otherPart, startLine)
end)
```

and check `line == startLine` inside. I couldn't focus anymore to actually write it, so that's tomorrow's problem.

## Next

- Fix start and finish (wrapper or two functions), and add `not raceActive` to the start
- Move the loop into a function
- Finish multiple conditions
