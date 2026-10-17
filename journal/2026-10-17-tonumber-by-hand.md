# tonumber by hand

**October 17, 2026**

Codewars, Convert a String to a Number. A quick search found `tonumber`, and that was it.

The interesting part was a solution marked Clever that didn't use `tonumber` at all. It builds the number itself:

```lua
return {string_to_number = function(n)
  local num, is_negative = 0, n:sub(1, 1) == "-"
  for i = #n, (is_negative and 2 or 1), -1 do
    num = num + (string.byte(n:sub(i, i)) - 48) * math.pow(10, #n - i)
  end
  return is_negative and -num or num
end}
```

Every character is stored as a number. `string.byte("6")` is 54, and the digits start at 48, so minus 48 gives the digit. Then each digit gets multiplied by its place: in "605" the 6 is 6 × 100. The loop goes from the last character back to the first.

I got stuck on `is_negative = n:sub(1, 1) == "-"`. The comparison gives `true` or `false`, and that goes straight into the variable. I also didn't remember what `sub` and `#` were, even though I used both two weeks ago.

I understand it now, but it's really complicated.

## Next

- The timed bridge
- The ball challenge from stage 3
