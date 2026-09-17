# Functions, and the parentheses I didn't understand

**September 17, 2026**

I started functions today with a tiny one:

```lua
-- Prints my favorite food
local function printFood()
	print("Pizza and Sushi, but mostly Sushi")
end
printFood()
```

It worked, but I didn't understand why I needed `()` after the name, even when there's nothing inside them. Then I looked back at my color-changing script and noticed parentheses there too, in `Color3.fromRGB(255, 11, 15)` and `Vector3.new(35, 35, 35)`. Were those functions too? They were. And so is `print`. I had been calling functions since my first script without knowing it.

## The experiment that surprised me

To see what the parentheses actually do, I tried two things.

First I removed them, so the last line was just `printFood`. Studio gave me a syntax error right away.

Then I wrote `print(printFood)`. I expected an error, something like "this function doesn't exist". Instead, Output printed:

```text
function: 0x1e39c5bab4c9511f
```

I didn't understand why. It turns out `local function printFood()` creates a variable named `printFood`, and the value inside that variable is the function. Without parentheses, `print` just printed what's inside the variable. A function can't be shown as text, so Luau printed its type and an ID. "Pizza and Sushi" never showed up, because the function never ran.

## Where I got confused

- I saw another way to write the same function, `local printFood = function() ... end`, and it threw me off. I thought `end` belonged to `local`. It doesn't: `end` closes `function`, and `local` only creates the variable.
- At first I read `function: 0x...` as "there's a variable, and this is where it is". That's not what happened. `print` always prints what's inside a variable, and for a function, that's the closest it can get.

## Next

- Write `makeGhost`: a function that gets a part and makes it half transparent, then call it on two different parts
- Continue the course from [Use parameters and events](https://create.roblox.com/docs/tutorials/fundamentals/coding-2/use-parameters-and-events)
