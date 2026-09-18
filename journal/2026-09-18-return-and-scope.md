# Why a function that exists gave me nil

**September 18, 2026**

I spent today playing with how to call a function, and almost nothing went the way I expected.

## `"I love to eat " .. printFood()`

I wanted one line in Output instead of two, so I tried to join my function into a print:

```lua
print("I love to eat " .. printFood())
```

Output showed "Pizza and Sushi, but mostly Sushi", and then an error: `attempt to concatenate string with nil`.

My first thought was that the function didn't exist. It did. I had defined it right above. What didn't exist was the value it gives back.

My function prints, and printing is not the same as giving something back. `print` writes text into the Output window, which is a screen I look at, not something the code can use. Since the function has no `return`, what comes back is `nil`, and `..` can't join text with nothing. I had assumed that a function with `print` inside it returns that text. It doesn't. `return` is the only way a function hands a value back.

```lua
local function getFood()
	return "Pizza and Sushi, but mostly Sushi"
end

print("I love to eat " .. getFood())
```

## Two parts with the same name

Then the exercise: a `makeGhost(part)` function that makes any part I pass it half transparent. It worked on the first part and did nothing on the second one, even though the two calls looked identical.

This had nothing to do with functions. I had two parts named `ColorPart` in Workspace. Roblox allows that, and `workspace.ColorPart` returns the first one it finds. Renaming the second part fixed it.

## Where I doubted what I was told, and was right to

I was told that a variable without `local` becomes global and is available to all scripts. I tested it: I printed `specificPart` from a different script and got `nil`, plus the warning `Unknown global 'specificPart'`. So globals are not shared between scripts. Each script runs in its own environment, and global means "the whole file", not "the whole game".

I also expected Studio to warn me when `local` is missing. It doesn't. Any name I assign to simply becomes a variable, so there is nothing to warn about. The warning shows up only when I read a name that was never assigned, like a typo.

And one thing I wasn't sure about: changing the value of a `local` variable later does not turn it into a global. `local` is decided once, when the variable is created.

## Next

- Continue the course: Use parameters and events
