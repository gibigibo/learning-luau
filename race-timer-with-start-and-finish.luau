--[[
	Race timer. Touch the starting line to start the clock, touch the finish line to
	stop it and get a medal based on the time.

	Where it goes: a Script inside the FinishLine part.
	Assumes: workspace.Race.StartingLine exists, and both lines are anchored parts.

	Fixed: finishing and stepping on the start line again within a second used to leave
	the old timer running next to the new one. Every finished race now adds one to
	touchedTimes, and each timer loop only counts while its own number (nowTime) is
	still the current one.

	Known issue I'm still working on:
	With more than one player, anyone can start or finish anyone else's race.
]]

-- start count when toching the start line and stop when finish the end
local finishLine = script.Parent
local startLine = workspace.Race.StartingLine
local timePassed = 0
local raceActive = false
local touchedTimes = 0 

local function timer ()
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
		touchedTimes += 1
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
startLine.Touched:Connect(function (otherPart) 
		partTouched (otherPart, startLine)
end)
