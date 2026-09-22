# A typo that answered my question

**September 20, 2026, evening**

Short one, I was wiped. Started a race timer on the finish line, and first wanted to see what `character` actually is:

```lua
local character = otherPart.Perent
print(character)
```

Typo. `Perent`. But look at the error:

```text
Perent is not a valid member of MeshPart "Workspace.Alpharenko.RightFoot"
```

It shows the full path of the thing it was looking in. So the foot's parent is Alpharenko, which is me. Question answered by accident.

Then `FindFirstChildWhichIsA("Humanoid")`, which I'd been using without really getting it. Easier when you split the name. Find: it looks, and can come back with nothing (`nil`). FirstChild: stops at the first match, and only checks direct children. WhichIsA: checks the type, not the name.

A character has a bunch of children, Head, RightFoot, Shirt and so on, and one Humanoid. If the floor touches the part instead, there's no Humanoid, you get `nil`, and the `if` doesn't run.

## Next

- Finish multiple conditions
