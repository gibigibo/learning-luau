# 5 + 5 = 25

**September 22, 2026**

Codewars this morning. Beginner kata: `n` classmates, each needs a copy of paperwork with `m` pages. How many blank pages do you need? If `n` or `m` is negative, return 0.

I wrote `n + m`. It failed. The example right there in the description says `n=5, m=5: 25`. I just didn't look at it. Every classmate gets all the pages, so it's `n * m`. Checking the examples first from now on.

(Side quest: VS Code can't run Lua on its own. Ended up using OneCompiler in the browser.)

## This line

After I passed, I looked at other people's solutions and found this:

```lua
return (n <= 0 or m <= 0) and 0 or n * m
```

No `if` anywhere. Just a `return` with a condition inside it. I had no idea where the decision was happening.

We went through it like a math exercise, replacing one small piece at a time until only one value was left. With `n=5, m=-5`:

```text
(5 <= 0 or -5 <= 0) and 0 or 5 * -5
(false or true) and 0 or 5 * -5
true and 0 or 5 * -5
0 or 5 * -5
0
```

What I was missing: in Lua, `and` and `or` don't only give back true or false. They give back one of the two things next to them. `a and b`: if `a` is false you get `a`, otherwise `b`. `a or b`: if `a` is true you get `a`, otherwise `b`.

Somewhere in the middle I got stuck on "the left side" and "the right side". My left, or the screen's left? For someone who reads Hebrew all day, that's a real question. We switched to "first" and "second" and it got a lot easier.

Then I tried `n=5, m=5` myself and got 0. Wrong. The rules were fine, I just wrote `true` for `5 <= 0` because I copied it from the example before. The kata says 25, so I went back and found it.

Honestly, this is complicated. It only works because in Lua `0` counts as true (only `false` and `nil` are false). I asked if people really write like this, and if it's faster. People do write it in Lua, and no, it isn't faster in any way that matters. I'm sticking with `if` unless the short version is obvious to read.

Cool thing I didn't know about: Fork. On Codewars you can open someone else's solution as your own copy, add prints, and run the tests. That's how I'm going to take apart the solutions I don't get.

## Next

Back to the race script. The start line still ends the race.
