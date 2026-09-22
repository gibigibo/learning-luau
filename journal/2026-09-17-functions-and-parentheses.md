# Wait, print is a function?

**September 17, 2026**

Functions today. My first one:

```lua
-- Prints my favorite food
local function printFood()
	print("Pizza and Sushi, but mostly Sushi")
end
printFood()
```

Worked. But why do I need `()` at the end if there's nothing inside? And then I noticed parentheses in yesterday's code too, `Color3.fromRGB(...)` and `Vector3.new(...)`. Functions? Yes. And `print` is a function too. I'd been calling functions since day one without knowing it.

I tried two things. First I removed the parentheses, so the last line was just `printFood`. Syntax error right away. Fine.

Then `print(printFood)`. I expected something like "this function doesn't exist". I got this:

```text
function: 0x1e39c5bab4c9511f
```

No idea what that was. I read it as "there's a variable, and this is where it is". Not quite. `local function printFood()` makes a variable called `printFood`, and what's inside it is the function. Without `()` nothing runs, and `print` just shows what's in the variable. A function can't be shown as text, so you get its type and an ID. "Pizza and Sushi" never showed up, because the function never ran.

Then I saw another way to write the same function, `local printFood = function() ... end`, and that confused me even more. I thought `end` belonged to `local`. It belongs to `function`. `local` just makes the variable.

## Next

- `makeGhost`: a function that gets a part and makes it half transparent
- Continue the course: Use parameters and events
