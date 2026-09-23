# Every race gets a number

**September 23, 2026**

Started with a Codewars kata, a traffic light: green goes to yellow, yellow to red, red back to green. Solved it with `if` and `elseif`. Then I saw someone solve it in two lines with a table. I started reading the explanation and stopped after the first line, because I haven't learned tables yet and I didn't want it spoiled. Parked it. When I get to tables I'm solving it again, their way, on my own.

Then the bug from yesterday. Finish a race, step on the start line again within a second, and two timers count at the same time.

This time I asked not to be given the answer, just questions. It took a while.

My first idea: the old loop needs to know if something changed while it was sleeping, and stop if it did. Right direction. But how? I suggested a variable that turns true when someone touches the finish line. Then I walked through it and saw it fails the same way `raceActive` fails: the new race resets it before the old loop wakes up. A true/false can't remember that it changed and changed back.

Next I wanted to stop the old loop from outside and start a fresh one. Can't do that with what I know.

What worked was a number that never goes back. Every finished race adds one:

```lua
local function timer()
	local nowTime = touchedTimes
	while raceActive and nowTime == touchedTimes do
		task.wait(1)
		if raceActive and nowTime == touchedTimes then
			timePassed += 1
			print(timePassed)
		end
	end
	timePassed = 0
end
```

Each call to `timer()` gets its own `nowTime`, frozen at the race number it started with. The old loop remembers 0, the new one remembers 1, and only the loop whose number matches keeps counting. I'd been given a hint about exactly that ("each call gets its own copy") and said I didn't remember it. Used it anyway.

It took three rounds. First version still let the old loop run forever, just without counting. Then I moved the check into the `while`, and the old loop counted one extra number before leaving, because the `if` inside only checked `raceActive`. Put the race number there too.

Now there are two almost identical lines, the `while` and the `if`. It looks weird, but they check at two different moments, before sleeping and after waking. There's apparently a way to write it once with `break`. Later.

## A bug that wasn't a bug

Studio suddenly showed `Expected 'end' (to close 'function' at line 8), got <eof>`. I checked every `end`, all fine. Turned out the game was still running and I'd been editing the copy that runs in test mode, in a second tab with the same name. None of it was saved. Red square on, Client and Server tabs open: that means hands off the code.

## Next

- Next page in the course: giving points with if and elseif
- Update the race timer file in the repo, issue 1 is fixed
