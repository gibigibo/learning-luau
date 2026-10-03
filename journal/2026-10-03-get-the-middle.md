# How many times 6 fits in 20

**October 3, 2026**

Codewars, Get the Middle Character: return the middle letter of a string, or the middle two if the length is even.

Two syntax errors on the way. The first said line 2, near `local`, but the line was fine. The mistake was in the line before it. Then `print stringLength`, without parentheses.

Solved it with `string.len`, `math.ceil` and `%`:

```lua
local function get_middle(s)
  local stringLength = string.len(s)
  local stringMiddle = math.ceil(stringLength / 2)
  if stringLength%2 == 0 then
      return (string.sub(s,stringMiddle,stringMiddle +1))
  else
      return (string.sub(s,stringMiddle,stringMiddle))
  end
end
```

Other people used `#s` instead of `string.len(s)`. Same thing, shorter.

One solution did it all in one line with `and`/`or` and `s:sub(#s // 2 + 1, #s // 2 + 1)`. I got lost in that part, and then in why `7 // 2` is 3. I used `//` a few days ago without really getting it. It's how many whole times 2 fits in 7: 2, 4, 6, three times, and 1 is left over, which is `7 % 2`. 20 // 6 is also 3.

Started the timed bridge page. I'll finish it tomorrow.

## Next

- Finish the timed bridge
