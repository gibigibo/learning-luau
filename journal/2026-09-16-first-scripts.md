# Day 1: My first scripts, and why I stopped copy-pasting

**Date:** September 16, 2026
**Topics:** Roblox Studio basics, variables, properties, Color3 and Vector3, reading errors

## What I worked on

I installed Roblox Studio and went through the building parts of Roblox's Core curriculum. Then I wrote my first scripts: printing to Output, creating variables, and changing a part's color, size, transparency and anchoring from code.

## Challenges and how I solved them

**I ran my first script and saw nothing.**
The Output window was closed, and I didn't know a script only runs while the game is running. Opening Output and pressing Play fixed it.

**The tutorial's scripting part was copy-paste.**
The Core curriculum gave me a full script to paste in before I had written a single line myself. I paused it, and switched to learning the fundamentals by writing my own code. I'll come back to it once I can write that script on my own.

**`local myName: string = 45` didn't give me an error.**
I expected the game to stop me. It turns out types are checked only in the editor: I got a yellow underline, but at runtime the value is used as is and 45 is printed.

**My script "didn't work", but it did.**
After stopping the game, Properties showed the old values. Stopping resets everything the script changed. To see the result, I have to look at Properties while the game is running.

## Mistakes I made

- I joined strings with `..` and got `isMaki`, because `..` doesn't add a space.
- I wrote `practicePart` instead of `PracticePart` on purpose, to see the error: `practicePart is not a valid member of Workspace "Workspace"`. Names are case-sensitive, and the script stops at that line.

## Insights

- Output is the first place to look. It shows my prints, and every runtime error with the script name and line number.
- The dot means "inside". Reading `workspace.PracticePart.Color` like an address made properties make sense.
- Every property accepts one type of value. `Color` needs a `Color3`, `Size` needs a `Vector3`, `Anchored` needs `true` or `false`.
- Following copy-paste tutorials didn't teach me to write code. Writing even a few lines myself did.

## Code from today

```lua
-- Changing a part's properties
local part = workspace.PracticePart

part.Color = Color3.fromRGB(255, 11, 15)
part.Size = Vector3.new(35, 35, 35)
part.Transparency = 0.5
part.Anchored = true
```

## Next

- Finish parents and children, and `script.Parent`
- Stage 2: conditions and functions
