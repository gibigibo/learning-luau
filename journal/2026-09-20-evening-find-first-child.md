# A typo that answered my question

**September 20, 2026, evening**

Short session. I started a race timer on the finish line and, before writing any logic, I wanted to see what `character` actually holds:

```lua
local function partTouched(otherPart)
	local character = otherPart.Perent
	print(character)
end
```

That gave me an error instead of a print:

```text
Perent is not a valid member of MeshPart "Workspace.Alpharenko.RightFoot"
```

I had written `Perent`. But the error answered my original question anyway: it printed the full path of the object it searched, `Workspace.Alpharenko.RightFoot`. So the foot's parent really is Alpharenko, my character. The error message names the object it was looking inside, which turns out to be a useful way to see where something sits.

## What the search function actually does

`FindFirstChildWhichIsA("Humanoid")` stopped being a magic incantation once I read the name as three separate words:

| Part of the name | What it means |
|---|---|
| `Find` | It searches, so it may fail. It returns `nil` instead of erroring |
| `FirstChild` | It stops at the first match, and only looks at direct children |
| `WhichIsA` | The test is the class, not the name |

A character contains Head, RightFoot, HumanoidRootPart, Shirt and so on, and one of those children is a Humanoid. The function walks that list, asks each one whether it is a Humanoid, and hands back the first one it finds.

The reason it fits an `if` is that the answer is always either an object or `nil`. When the floor touches the part, `character` is Workspace, there is no Humanoid inside it, and the condition simply doesn't run.

## Next

- Finish multiple conditions
