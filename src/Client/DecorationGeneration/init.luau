--!native
--!optimize 2
--!strict
--#region Services
local _RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
-- local Players = game:GetService("Players")
--#endregion

--#region Packages
local Zap = require(script.Parent.ZapClient)
--#endregion

--#region Features
local PickupZoneHandler = require(script.Parent.PickupZoneHandler)
local PickupAnimation = require(ReplicatedStorage.Helpers.PickupAnimation)
--#endregion

--#region Data
local PlayerTiers = require(script.Parent.PlayerTiers)
local StatsTypes = require(ReplicatedStorage.Types.StatsTypes)
--#endregion

--#region Types
--#endregion

--#region Variables
local GenArea = workspace:WaitForChild("GenArea")
local decorationCount = 0
local decorationList = {}
local lastUsed = 0
local localPlayer = Players.LocalPlayer
--#endregion

--#region Function Declerations
local GenerateDecoration: (position: Vector3) -> Part
local UpdateDecoration: (dt: number) -> ()
--#endregion

--#region Functions
UpdateDecoration = function(dt: number)
	local genAreaSize = GenArea.Size
	local genAreaPosition = GenArea.Position
	lastUsed += dt
	if lastUsed < PlayerTiers[StatsTypes.Interval].FinalValue then
		return
	end
	lastUsed -= PlayerTiers[StatsTypes.Interval].FinalValue
	if decorationCount < PlayerTiers[StatsTypes.MaxDecorations].FinalValue then
		local randomX = math.random(genAreaPosition.X - genAreaSize.X / 2, genAreaPosition.X + genAreaSize.X / 2)
		local randomZ = math.random(genAreaPosition.Z - genAreaSize.Z / 2, genAreaPosition.Z + genAreaSize.Z / 2)
		local randomY = math.random(genAreaPosition.Y - genAreaSize.Y / 2, genAreaPosition.Y + genAreaSize.Y / 2)

		local randomPosition = Vector3.new(randomX, randomY, randomZ)

		local decoration = GenerateDecoration(randomPosition)
		decoration.Parent = GenArea
		decorationCount += 1
	end
end

GenerateDecoration = function(position: Vector3)
	local decoration = Instance.new("Part")
	decoration.Size = Vector3.new(4, 4, 4)
	decoration.Position = position + Vector3.yAxis * 2
	decoration.Anchored = true
	decoration.CanCollide = false
	decoration.Material = Enum.Material.Grass
	decoration.Shape = Enum.PartType.Ball
	decoration.Color = Color3.fromRGB(0, 255, 0)
	decorationList[decoration] = true
	local pickupZone = PickupZoneHandler.getPickupZone()
	local touchedConnection: RBXScriptConnection? = nil
	touchedConnection = decoration.Touched:Connect(function(hit)
		if hit == pickupZone then
			if touchedConnection then
				touchedConnection:Disconnect()
			end
			local currencyCountGUI = localPlayer.PlayerGui.StatsGui.CurrencyBar

			PickupAnimation.executeAnimation({
				part = decoration,
				parentGui = localPlayer.PlayerGui.CurrencyPickupGUI,
				pickupSize = 1500,
				image = "rbxassetid://125156907889202",
				endSize = UDim2.new(0, 0, 0, 0),
				endPos = currencyCountGUI.Position
					+ UDim2.new(0, currencyCountGUI.Size.X.Offset / 2, 0, currencyCountGUI.Size.Y.Offset / 2),
				easingDirection = Enum.EasingDirection.Out,
				easingStyle = Enum.EasingStyle.Linear,
				duration = 0.75,
			})

			decorationList[decoration] = nil
			decorationCount -= 1
			Zap.pickupDecoration.Fire()
			decoration:Destroy()
		end
	end)
	return decoration
end

--#endregion

return table.freeze({
	UpdateDecoration = UpdateDecoration,
	GenerateDecoration = GenerateDecoration,
})
