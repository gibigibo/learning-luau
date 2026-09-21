# The race that ended on the starting line

**September 21, 2026**

A scattered day: some Codewars, a first look at loops, and a race script that I pushed further than the tutorial did.

## return, again, but this time it stuck

On Codewars I didn't really understand why every solution ends with `return`. The explanations I got at first were too complicated, and what finally worked was the smallest possible example:

```lua
local function add(a, b)
	return a + b
end

local result = add(2, 3)   -- 5
```

On Codewars, the test is the one calling my function. It checks what the function hands back, not what it prints. A function that prints the right answer and returns nothing gives the test `nil`, and fails.

## A solution I didn't understand

I solved a kata with a plain `if`:

```lua
function solution.bool_to_word(boolean)
	if boolean == true then
		return "Yes"
	else
		return "No"
	end
end
```

Then I saw that most people wrote one line instead:

```lua
return boolean and "Yes" or "No"
```

In Lua, `and` and `or` don't just produce `true` or `false`, they hand back one of the values themselves. `a and b` gives `a` if `a` is false, otherwise `b`. `a or b` gives `a` if `a` is true, otherwise `b`. Follow it through with `true` and you get "Yes", with `false` you get "No". And only `false` and `nil` count as false in Lua. Everything else, including `0`, counts as true.

The same idea cleaned up my own code later. `if humanoid and raceActive == true then` is just `if humanoid and raceActive then`, because `if` already checks whether something counts as true.

## The race

The tutorial built a finish line. I decided to add a starting line that begins the race when touched.

My first surprise was the `while` loop. I had put it at the bottom of the script, and I expected it to keep checking until the race started. It doesn't. It runs once, when the script starts, sees that the race isn't active, skips, and never comes back. My plan is to move it into a function and start it when the race starts.

My second problem was worse: I connected both lines to the same function, and touching the starting line a second time **ended** the race. The function only receives who touched, never which part was touched, so from its point of view the start line and the finish line are the same event.

I wanted to fix it by handing the line as an extra argument:

```lua
startLine.Touched:Connect(partTouched, startLine)
```

That doesn't work. `Connect` takes only the function, and the event decides what the function receives. But the idea can work if a small wrapper function adds the extra argument itself:

```lua
startLine.Touched:Connect(function(otherPart)
	partTouched(otherPart, startLine)
end)
```

And inside the function, `line == startLine` compares the objects themselves, which works because a variable holding an object holds a reference to it.

I ran out of focus before writing it, so it waits for tomorrow.

## Next

- Fix the start and finish lines, either with the wrapper or with two separate functions, and add `not raceActive` to the start
- Move the `while` loop into a function that starts with the race
- Finish multiple conditions
