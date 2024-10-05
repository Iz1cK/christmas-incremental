--!native
--!optimize 2
--!strict
--#region Services
local Players = game:GetService("Players")
--#endregion

--#region Packages
--#endregion

--#region Features
--#endregion

--#region Data
local playerStats = require(script.Parent.PlayerStats)
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local primaryPart = character.PrimaryPart or character:WaitForChild("HumanoidRootPart")
--#endregion

--#region Types
--#endregion

--#region Variables
local pickupRange = playerStats.PickupRange.StatValue or 10
local squarePart: Part = nil
local weld: WeldConstraint = nil
--#endregion

--#region Function Declerations
local createPickupZone: () -> ()
local destroyPickupZone: () -> ()
local updatePickupZone: () -> ()
local getPickupZone: () -> Part
--#endregion

--#region Functions
createPickupZone = function()
	-- Create a part (square)
	squarePart = Instance.new("Part")
	squarePart.Size = Vector3.new(pickupRange, 1, pickupRange) -- Size of the square
	squarePart.Anchored = false
	squarePart.CanCollide = false
	squarePart.Parent = workspace
	squarePart.Name = "PickupZone"

	-- Calculate position at player's feet
	local hipHeight = humanoid.HipHeight -- Height from feet to HumanoidRootPart
	local characterHeight = (primaryPart.Size.Y / 2) + hipHeight

	-- Position the part at the player's feet
	squarePart.CFrame = primaryPart.CFrame * CFrame.new(0, -characterHeight, 0)

	-- Attach the part to the player using a WeldConstraint
	weld = Instance.new("WeldConstraint")
	weld.Part0 = character.PrimaryPart -- Attach to the HumanoidRootPart
	weld.Part1 = squarePart
	weld.Parent = squarePart

	-- Optional: Customize the part appearance
	squarePart.BrickColor = BrickColor.new("Bright red") -- Example color
	squarePart.Material = Enum.Material.Neon -- Example material
end
destroyPickupZone = function()
	if squarePart then
		squarePart:Destroy()
	end
	if weld then
		weld:Destroy()
	end
end

updatePickupZone = function()
	if squarePart then
		pickupRange = playerStats.PickupRange.StatValue
		-- Update the size of the square
		squarePart.Size = Vector3.new(pickupRange, 1, pickupRange)
	end
end

getPickupZone = function()
	return squarePart
end
--#endregion

return table.freeze({
	createPickupZone = createPickupZone,
	destroyPickupZone = destroyPickupZone,
	updatePickupZone = updatePickupZone,
	getPickupZone = getPickupZone,
})
