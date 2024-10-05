--!strict
--#region Services
-- local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
--#endregion

--#region Packages
-- local Clock = require(ReplicatedStorage.Packages.Clock)
local Zap = require(script.Parent.ZapClient)
--#endregion

--#region Features
local DecorationGeneration = require(script.Parent.DecorationGeneration)
local _UpgradeScreenHandler = require(script.Parent.UpgradeScreenHandler)
local _PickaupZoneHandler = require(script.Parent.PickupZoneHandler)
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
Zap.finishPlayerLoading.On(function(data: any)
	_UpgradeScreenHandler.update(data)
end)
--#endregion
