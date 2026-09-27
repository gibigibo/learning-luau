# Three ways to delete a space

**September 27, 2026**

Codewars first: remove the spaces from a string. It looked easy before I even decided to take it. Instead of guessing, I went looking. Found a Stack Overflow thread about removing spaces in Lua, then the docs for `gsub`, to understand what it actually does. Then solved it:

```lua
return string.gsub(str," ","")
```

Two other solutions were interesting. One wrote `str:gsub(" ", "")`. Same thing: the colon puts `str` in as the first thing in the parentheses. Another used `"%s"` instead of `" "`. What you give `gsub` to look for isn't plain text, it's a pattern, and `%s` means any whitespace: spaces, tabs, new lines. Mine only removes spaces.

Also, `gsub` hands back two things, the new text and how many replacements it made. The tests only check the first one, so mine passed anyway.

## Loops

Next page in the course: while loops. A part that changes color every three seconds, forever.

Then I took my old door script, the one that opens the house door when you touch a part, and moved it into the looping part. So the button for the door is now the part that keeps changing colors. Looks nice.

## Also

Asked how bingo games put cards on the screen. It's UI: a ScreenGui with a Frame and buttons inside. I could build the look by hand already, but filling 25 squares with numbers needs loops and tables, so it waits.

## Next

- For loops, the next page in Coding 4
