# The cube took the script with it

**September 26, 2026**

Codewars first: repeat a string `n` times. I wrote it with a `while` loop and a counter, on my own. At first I tried joining the text with `+`, which in Lua is only for math. Searched for exactly that, checked it in OneCompiler, went back and finished.

The top solution was one line:

```lua
return string:rep(r)
```

`string` there is just the name of the parameter. `:rep` is a function that text has, the same way `part:Destroy()` belongs to a part. I didn't know text had functions of its own. Tried a few in OneCompiler, guessing each result before running it. `rep` and `reverse` I got right. For `upper` I guessed "H". It's "HELLO", every letter.

## Give points

Then the course page. An error the moment I pressed Play:

```text
attempt to index nil with 'Parent'
```

I'd written `Connect(partTouched())`. With the parentheses the function runs right away, with nothing in them, so `otherPart` is nil. Same thing I found on the 17th with `printFood`. I asked if that's a `Touched` thing. It isn't, it's the whole language. This time I asked for the answer, I wanted to get through the page.

Next, the particles wouldn't go away. `Touched` fires for every body part, so every step made new ones. I knew it needed a debounce and still couldn't write one, even though it's in my own notebook.

Then one blue particle stayed on my head for good. I recorded a video of it. Turned out my point cubes didn't all have the same script, so I put the same one in all of them. After that two got stuck at once, a red and a green, and my points were at -190.

The problem was `pointPart:Destroy()`. The script sits inside the cube, so destroying the cube destroys the script too, and any run of it that's still waiting gets cancelled. One touch was waiting a second in `givePoints` before removing its particle, another touch destroyed the cube in the meantime, and the first one never woke up.

What fixed it: destroy the cube only after `givePoints` is done, check `CanTouch` inside the `if`, and two prints, "new Particle" and "destroy", to see which lines actually run.

At one point Claude told me to delete the Destroy line altogether, then checked the course and took it back. The cube is supposed to disappear after one touch, so it can't keep handing out points.

Last detail: the Destroy goes inside the `if`, not after it. A line after the `if` runs for every touch, including the ones the check turned away. A hat touching the cube would destroy it without anyone getting points.

## Next

- Coding 4 in the course: loops
