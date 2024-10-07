--!strict
--#region Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
--#endregion

--#region Packages
-- local Clock = require(ReplicatedStorage.Packages.Clock)
local Zap = require(script.Parent.ZapClient)
--#endregion

--#region Features
local DecorationGeneration = require(script.Parent.DecorationGeneration)
local _UpgradeScreenHandler = require(script.Parent.UpgradeScreenHandler)
local _PickaupZoneHandler = require(script.Parent.PickupZoneHandler)
local playerStats = require(script.Parent.PlayerTiers)
local StatsTypes = require(ReplicatedStorage.Types.StatsTypes)
local localPlayer = Players.LocalPlayer

--#endregion

--#region Types
--#endregion

--#region Variables
local _gameLoop: RBXScriptConnection = nil
--#endregion

--#region Functions
_PickaupZoneHandler.createPickupZone()
_gameLoop = RunService.Heartbeat:Connect(function(dt: number)
	DecorationGeneration.UpdateDecoration(dt)
end)

local disconnectMoveSpeedUpdate = playerStats[StatsTypes.MoveSpeed]:Connect(
	function(_statName: string, newValue: number, _oldValue: number)
		print("MoveSpeed updated to: ", newValue)
		localPlayer.Character.Humanoid.WalkSpeed = newValue
	end
)

local disconnectPickupRangeUpdate = playerStats[StatsTypes.PickupRange]:Connect(
	function(_statName: string, newValue: number, _oldValue: number)
		print("PickupRange updated to: ", newValue)
		_PickaupZoneHandler.updatePickupZone()
	end
)

Players.PlayerRemoving:Connect(function(player: Player)
	if player == localPlayer then
		_gameLoop:Disconnect()
		disconnectMoveSpeedUpdate()
		disconnectPickupRangeUpdate()
	end
end)
Zap.finishPlayerLoading.On(function(data: any)
	_UpgradeScreenHandler.update(data)
	local currencyPickupGUI = Instance.new("ScreenGui")
	currencyPickupGUI.Name = "CurrencyPickupGUI"
	currencyPickupGUI.Parent = localPlayer.PlayerGui
end)
--#endregion
