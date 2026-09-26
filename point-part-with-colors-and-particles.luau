--[[
	Point part from the Roblox "Give points" tutorial. The part keeps changing color:
	blue gives 10 points, green gives 50, red takes away 100. Touching it also puts
	particles in the part's color on the player's head for a second, and then the part
	is gone.

	Where it goes: a Script inside the PointPart.
	Assumes: a leaderboard script that gives every player leaderstats with a Points value.

	Different from the tutorial: the part is destroyed at the very end, only after the
	particle is gone, and only by the touch that gave the points. The script sits inside
	the part, so destroying the part destroys the script too, and a run that's still
	waiting never finishes. CanTouch works as the debounce, so one touch counts once.
]]

local pointPart = script.Parent

-- Colors
local blue = Color3.fromRGB(0,0,255)
local green = Color3.fromRGB(0,255,0)
local red = Color3.fromRGB(255,0,0)

--Points values
local smallPoints = 10
local largePoints = 50
local losePoints = 100

-- Services needed
local Players = game:GetService("Players")

-- Gives or subtracts points
local function givePoints(player)
	local currentColor =pointPart.Color
	local playerStats = player:WaitForChild("leaderstats")
	local playerPoints = playerStats:WaitForChild("Points")

	if currentColor == blue then
		playerPoints.Value += smallPoints
	elseif currentColor == green then
		playerPoints.Value += largePoints
	else
		playerPoints.Value -= losePoints
	end
	local particle = Instance.new("ParticleEmitter")
	particle.Color = ColorSequence.new(currentColor)
	print ("new Particle")

	local playerCharacter = player.Character
	particle.Parent = playerCharacter:WaitForChild("Head")

	task.wait(1)
	particle:Destroy()
	print ("destroy")
	pointPart.CanTouch = true
end

-- Checks if player touched the part
local function partTouched(otherPart)
	-- Gets the Player if one touched the part
	local player = Players:GetPlayerFromCharacter(otherPart.Parent)
	if player and pointPart.CanTouch then
		pointPart.CanTouch = false
		givePoints(player)
		pointPart:Destroy()
	end

end

pointPart.Touched:Connect(partTouched)

while true do
	pointPart.Color = blue
	task.wait(3)
	pointPart.Color = green
	task.wait(2)
	pointPart.Color = red
	task.wait(1)
end
