# Vowel Count

**October 11, 2026**

Working on a kata and learning patterns along the way. A few things surprised me.

An example had `local result, count = string.gsub(...)`. Two names after `local`. gsub gives back two things, and this keeps both.

`"%a*"` on `" let's tiest it out"` printed an empty line. The string starts with a space, `*` means zero or more, so zero letters right at the start already counts. `%a+` gave `let`, and stopped at the apostrophe. match only gives the first run.

Then Vowel Count (7kyu): count the vowels in a string. I started with `gmatch` and `"e"` to count just the e's, and the count stayed 0 even though the loop ran twice. I had written `local i = i + 1` inside the loop, so every round made a new `i` and the one outside never changed.

Then I needed all five vowels, not only e. The answer was `"[aeiou]"`, square brackets, which I'd seen but didn't really understand. The whole pattern table still confuses me. This one was really hard.

## Next

- Finish the timed bridge
- The ball challenge from stage 3
