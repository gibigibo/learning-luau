# The line that felt like a backwards variable

**September 19, 2026**

I finished the buttons page today, and it was the first time the course felt like practice rather than new material. A button that makes a bridge solid, and a bonus one that opens a door:

```lua
local button = script.Parent
local bridge = workspace.Bridge

local function pressButton()
	print("The Button been Pressed")
	bridge.Transparency = 0
	bridge.CanCollide = true
end

button.Touched:Connect(pressButton)
```

Output said `Door Trigger (x7)`, so again one touch ran the function seven times. Harmless here, because setting transparency seven times looks the same as once, but I know by now that it won't stay harmless.

I also learned what `CanCollide` does: it decides whether a part is solid or whether I walk straight through it. Turning it off does not stop `Touched` from firing, which is how invisible trigger zones work. The property that stops the event is `CanTouch`.

## Parameters and arguments

Two words for the two sides of the same thing:

```lua
local function sortGarbage(trash, recyclable)   -- parameters
sortGarbage(coal, ocean)                        -- arguments
```

The parameters are the empty names in the definition. The arguments are the values I actually hand over. What connects them is the order and nothing else: the first argument goes into the first parameter. If I called `sortGarbage(ocean, coal)`, the ocean would be destroyed and the coal would get the sparkles, and the code would run happily.

## Instance.new, and objects that exist nowhere

Until today I only changed objects that already existed in the world. `Instance.new("ParticleEmitter")` creates a new one from code, the same thing as inserting it by hand in Studio.

What threw me is that after that line, nothing appears. The object exists, but it isn't anywhere in the game yet.

## `sparkle.Parent = recyclable`

This line felt like a backwards variable to me, and it took a while to see why.

Every assignment I had written before put a simple value into a property: a number, a color, true or false.

```lua
part.Transparency = 0.5
part.Anchored = true
```

Here the value going into the property is **another object**. `Parent` answers "who am I inside of", so of course its value is a thing, not a number. Setting it is what puts the new emitter into the world.

The second half of my confusion was that `recyclable` is a parameter, so I couldn't see what it really was. Spelled out with no variables at all, the whole function is this:

```lua
workspace.Coal:Destroy()
Instance.new("ParticleEmitter").Parent = workspace.Ocean
```

I had been reading `recyclable` as a word rather than as a box holding the Ocean part.

Then I got asked what this line does:

```lua
workspace.Coal.Parent = workspace.Ocean
```

Coal becomes a child of Ocean and moves inside it in Explorer, exactly as if I had dragged it there. That was the moment it clicked: `Parent` isn't only something I read from, it's something I set, and setting it moves the object.

Two things that follow from it: `Parent = nil` takes an object out of the world but keeps it in memory, unlike `Destroy` which is final. And the parent is what decides whether a script runs at all, which explains why my script under `Players` did nothing.

## Next

- Conditionals, starting from the coding-3 landing page
