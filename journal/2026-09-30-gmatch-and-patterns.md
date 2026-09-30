# O'Brien

**September 30, 2026**

Started from an example I found: `string.gmatch(text, "%a+")` in a for loop prints every word of a sentence. `%a` is a letter, `+` is one or more in a row.

I tried `print(string.gmatch(text, "%a+"))` to see the first word and got `function: 0x...`. gmatch doesn't give a word, it gives a function, and every call to that function gives the next word. The for loop calls it for me each round.

Then Codewars, Name Shuffler: "William O'Brien" should come back as "O'Brien William". With `%a+`, the apostrophe cuts O'Brien into two words. I tried `"%a%p+"`, thinking it meant letters and punctuation. It means one letter followed by punctuation, so the only match was `O'`, the second call got nil, and joining it crashed. The "or" needs square brackets: `[%a%p]+` is a run of characters that are each a letter or punctuation. The space is neither, so it splits the two names.

I also expected calling `nextword()` twice to give the same word twice. It keeps its place and moves on to the next one.

Ranked up to 7 kyu in Lua.

## Next

- Timed bridge, the next page in Coding 4
