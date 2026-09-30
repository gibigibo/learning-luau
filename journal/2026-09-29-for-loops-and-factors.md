# Two seconds on 5

**September 29, 2026**

Found a MapleStory Classic guide that explains how accuracy works: one formula for your accuracy from level, DEX and LUK, and another for whether you hit a monster. Went through it and got an idea for a small program: I put in my stats and it tells me where to train. It's in the plan now as a final project, for after tables.

## Codewars

Keep Hydrated: litres of water for hours of cycling, rounded down. `math.floor(time * 0.5)`, passed. One of the other solutions was `time // 2`. `//` divides and rounds down in one step. I tried to look it up and found nothing, because search ignores symbols. Searching "floor division" found it on the Roblox operators page. There's an example there, `-10 // 4 = -3`, not -2. Down means the smaller number, not towards zero.

Check for factor: return true if `factor` is a factor of `base`. I wrote `factor % base == 0` and every test that should be true failed. I wrote it in the order of the sentence, factor first. But "3 is a factor of 12" means 12 divides by 3, so it's `base % factor`.

Tried Sum of Digits / Digital Root, a 6kyu. I understand the math but had no idea how to write it. Left it for later.

## Loops

Before anything else, Studio wouldn't run: "Rendering is paused for debugging". I had clicked next to a line number and put a breakpoint there by accident.

Glow lights page in the course. The for loop ran and printed, but the light looked like it only turned on at the end. Probably because the script starts when the server starts, before I'm actually looking at the game.

Then I put two for loops inside `while true`, one going up and one going down. 5 and 0 each stayed for two seconds, because the first loop ends on 5 and the second one starts on 5. Going up from 0 to 4 and down from 5 to 1 fixes it.

## Next

- Timed bridge, the next page in Coding 4
