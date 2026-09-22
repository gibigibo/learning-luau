# The timer that wouldn't quit

**September 22, 2026, afternoon**

Back to the race script.

First I had to understand the wrapper. `Connect` only takes a function, so to pass the line as well you wrap the call in a small function with no name. What helped was seeing it first with a name and then without, and saying it back in my own words: the thing in the parentheses is what `Touched` hands over, and inside the wrapper I call my real function with that plus the line. Extra information, smuggled in.

I also asked whether `Touched` builds the function and runs it on the spot. It doesn't. I write the function, `Connect` registers it once when the script starts, and `Touched` runs it later, every time something touches the part.

With two wrappers, `partTouched(otherPart, whichLine)` and `whichLine == finishLine` in the `if`, the race finally started and finished in the right places.

Then Output showed the counter jumping two or three numbers in the same second. Several timers running at once, one per body part that touched the start line. I asked for the answer too early and got it, which I regretted, so we agreed: from now on I get a question first, and the answer only if I ask. Fixed it myself with `not raceActive` in the start branch.

Two smaller things. The timer counted one extra number after the race ended, because the loop was already inside its `task.wait(1)` when the race stopped. The fix popped into my head later: check `raceActive` again inside the loop, after the wait. Works. And medals with `elseif`, gold, silver, bronze and an `else` for everyone else.

## Still open

Asked for a review of the code and got a bug I hadn't seen. Finish a race, then step on the start line again in less than a second: the old timer is still sitting in its `task.wait`, wakes up, sees `raceActive` is true again because the new race turned it on, and keeps counting. Two timers, one race.

My first attempt was this:

```lua
if not raceActive then
	startLine.Touched:Connect(function(otherPart)
		partTouched(otherPart, startLine)
	end)
end
```

Doesn't work. That `if` is checked once, when the script starts, and then the connection just exists forever.

The question I'm leaving myself: the old loop only knows how to ask "is there an active race?". What does it need to know instead, so it can tell that *its own* race is over?

## Next

- Fix the double timer
- Multiple conditions is done. Next page in the course
