# nil, from a function that exists

**September 18, 2026**

I wanted one line in Output instead of two, so I tried this:

```lua
print("I love to eat " .. printFood())
```

Got "Pizza and Sushi", and then `attempt to concatenate string with nil`. Nil? The function is right there, I wrote it five lines up.

The function exists. What it gives back doesn't. It prints the text, but doesn't return anything, so what comes back to that line is `nil`. I really thought a `print` inside the function counts as giving the text back. It doesn't. `print` writes to the Output window and that's it. Only `return` hands something back.

```lua
local function getFood()
	return "Pizza and Sushi, but mostly Sushi"
end

print("I love to eat " .. getFood())
```

Took me a few rounds of questions to get this one. What finally did it was running a function that prints next to one that returns, and looking at which line number each `hello` in Output came from.

Then the exercise, `makeGhost(part)`. First part went half transparent, second didn't. Same code. Turns out I had two parts called `ColorPart`, and `workspace.ColorPart` just grabs the first one. Renamed the second one, done.

Last thing. I was told a variable without `local` is global, available to all scripts. So I checked, and printed it from another script: `nil`, plus a warning, `Unknown global 'specificPart'`. So global means the whole file, not the whole game. I also expected a warning for forgetting `local`. Nope. You only get warned when you read a name that was never set, like a typo. And changing a local later doesn't make it global.

## Next

- Use parameters and events
