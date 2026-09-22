# Coal is now a child of Ocean

**September 19, 2026**

Finished the buttons page. That one was really fun, and for once it felt like practice instead of new stuff. A button that makes a bridge appear, and a bonus door:

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

`Door Trigger (x7)` in Output. Again. Harmless this time.

`CanCollide` is solid or walk-through. With it off, `Touched` still fires, which is how invisible trigger zones work.

Then the next page lost me. `Instance.new("ParticleEmitter")`, what is that? I couldn't even find ParticleEmitter in the insert menu at first. `Instance.new` makes a new object from code. But after that line nothing shows up. It exists, it just isn't anywhere yet.

And this line:

```lua
sparkle.Parent = recyclable
```

It felt like a backwards variable. Everything I'd assigned before was a number, a color, true or false. Here the value is another object. And `recyclable` is a parameter, so I couldn't see what it actually was. At one point I said "it's not a variable". It is.

What helped was writing the whole thing with no variables at all:

```lua
workspace.Coal:Destroy()
Instance.new("ParticleEmitter").Parent = workspace.Ocean
```

Then I got asked what this does:

```lua
workspace.Coal.Parent = workspace.Ocean
```

Coal becomes a child of Ocean. It moves inside it, like dragging it in Explorer. OK. So `Parent` is something you can set, not only read.

Parameters vs arguments, for the record: parameters are the names in the definition, arguments are what you actually pass in. Only the order connects them.

Pretty tired by the end of this one.

## Next

- Conditions
