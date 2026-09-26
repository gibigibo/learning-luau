# I wrote the line I couldn't read

**September 25, 2026**

A few days ago this line took me most of a session to understand:

```lua
return (n <= 0 or m <= 0) and 0 or n * m
```

Today on Codewars, Even or Odd, I wrote one myself:

```lua
function kata.even_or_odd(number)
  return (number%2)==1 and 'Odd' or 'Even'
end
```

All tests passed, including the negative odd numbers. That part only works because in Lua the remainder of dividing by 2 is never negative: `-3 % 2` is `1`. If it came out as `-1`, every negative test would have failed.

Then I asked about `and`, because I'd just used it and still couldn't explain it. The explanation that worked for me was a guard at a door, checking a ticket and then an ID. No ticket, he doesn't even look at the ID, and "no ticket" is the answer. Ticket OK, and the answer is whatever the ID check says. Same with `a and b`: you get `a` if `a` is false, otherwise `b`.

## Other stuff I asked about

Debounce. It sounded like the name of a command. It isn't, there's no such word in Luau. It's a name for a trick: making one touch count as one. It comes from electronics, where a physical button bounces and registers several presses. Turns out I'd already done it twice without knowing the name: `CanTouch = false` in the speed boost, and `not raceActive` in the race.

Algorithms. I asked what they are and got "a recipe of steps". Then I asked if someone could tell me my stuff isn't real algorithms. They could, and they'd be right. My medal `if` chain is just logic. The race number trick is a real technique, but not a textbook algorithm. The classic ones (sorting, searching, finding a path) mostly work on lists, so they come after tables.

LeetCode came up too. It's built around job interviews, with every problem tagged by the technique it trains. It doesn't do Lua, so I'm staying on Codewars, which has tags too. `ALGORITHMS` is one of them, for later.

## Small cleanup

The `if not raceActive` from the 22nd was still wrapped around the start line connection in the race script. It never did anything, so I deleted it. One known issue left: more than one player.

## Next

- Giving points with if and elseif, the next course page
