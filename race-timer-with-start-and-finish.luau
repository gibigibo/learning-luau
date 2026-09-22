--[[
	Race timer. Touch the starting line to start the clock, touch the finish line to
	stop it and get a medal based on the time.

	Where it goes: a Script inside the FinishLine part.
	Assumes: workspace.Race.StartingLine exists, and both lines are anchored parts.

	Known issues I'm still working on:
	1. Finish a race and step on the start line again within one second: the old timer
	   loop is still inside its task.wait, wakes up, and keeps counting alongside the
	   new one, so the number goes up twice per second.
	2. With more than one player, anyone can start or finish anyone else's race.
	3. The "if not raceActive" around the second Connect does nothing. That line runs
	   once when the script starts. Leftover from a first attempt at issue 1.
]]

-- start count when toching the start line and stop when finish the end
local finishLine = script.Parent
local startLine = workspace.Race.StartingLine
local timePassed = 0
local raceActive = false

local function timer ()
	while raceActive do
		task.wait(1)
		if raceActive then
			timePassed += 1
			print(timePassed)
		end
	end
	timePassed = 0
end

local function finish ()
	raceActive = false
	print("you finished in " ..timePassed .. " seconds")
	if timePassed <= 3  then
		print("You got a Gold medal!")
	elseif timePassed > 3 and timePassed <=4 then 
		print("You got a Silver medal!")
	elseif timePassed > 4 and timePassed <=6 then
		print("You got a Bronze medal!")
	else	
		print("What took you so long?!")
	end
end

local function partTouched(otherPart, whichLine)
	local character = otherPart.Parent
	local humanoid = character:FindFirstChildWhichIsA("Humanoid")
	--Triger FinishLine
	if humanoid and raceActive and whichLine == finishLine then
		finish()
	-- Triger StartingLine
	elseif humanoid and not raceActive and whichLine == startLine then
		raceActive = true
		timer()
	end
end

finishLine.Touched:Connect(function (otherPart) 
	partTouched(otherPart, finishLine)
end)
if not raceActive then
	startLine.Touched:Connect(function (otherPart) 
		partTouched (otherPart, startLine)
	end)
end
