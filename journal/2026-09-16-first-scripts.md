# I stopped copy-pasting

**September 16, 2026**

Installed Roblox Studio today and went through the building part of Roblox's Core curriculum. Fun, until it got to scripting. The tutorial just hands you a whole script to paste in. I hadn't written a single line of code yet, so I stopped there. I'll go back to it when I can write that script myself.

So, basics.

First problem: I wrote `print("Hello world!")` and nothing happened. At least nothing I could see. The Output window was closed, and I didn't know a script only runs after you press Play. Opened Output, pressed Play, there it was.

Then variables. I wrote one with the wrong type on purpose:

```lua
local myName : string = 45
```

I was sure I'd get an error. It printed 45. The type is only checked in the editor (there was a yellow line under the 45 that I hadn't even noticed), and when the game runs it doesn't care.

Then I changed a part from code:

```lua
local part = workspace.PracticePart

part.Color = Color3.fromRGB(255, 11, 15)
part.Size = Vector3.new(35, 35, 35)
part.Transparency = 0.5
part.Anchored = true
```

It worked, but I didn't really get the dots. What helped: a dot means "inside". `workspace.PracticePart.Color` is like an address. I also thought `Color3` was a property. It isn't, it's a type of value. `Color` wants a `Color3`. `Size` wants a `Vector3`, and that one I guessed myself.

Then I checked Properties and the part looked exactly like before. I thought the script didn't work. It did. I was looking after I stopped the game, and stopping resets everything.

Two small ones: `..` doesn't add a space, so my cat sentence came out as `isMaki`. And I wrote `practicePart` with a small p on purpose, to see what happens:

```text
practicePart is not a valid member of Workspace "Workspace"
```

Names are case-sensitive, and the script just stops on that line.

## Next

- Parents and children, `script.Parent`
- Conditions and functions
