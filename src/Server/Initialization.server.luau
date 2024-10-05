--!strict
--#region Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
--#endregion

--#region Packages
local CurrencyHandler = require(script.Parent.CurrencyHandler)
local Zap = require(script.Parent.ZapServer)
--#endregion

--#region Features
local UpgradeTierHandler = require(script.Parent.UpgradeTierHandler)
local PlayerStats = require(script.Parent.PlayerStats)
local DataStore = require(script.Parent.DataStore)
local PlayerTierData = require(ReplicatedStorage.Data.PlayerTierData)
--#endregion

--#region Data
--#endregion
--#region Types
--#endregion
--#region Variables
--#endregion
--#region Function Declerations
--#endregion
--#region Functions
Players.PlayerAdded:Connect(function(player: Player)
	--loading screen here
	local document = DataStore.loadPlayerStats(player)
	local data = document:read()
	if data == nil then
		data = table.clone(PlayerTierData)
	end
	PlayerStats.initPlayerStats(player, data)
	--end loading screen here
	CurrencyHandler.InitPlayer(player, data.Currency)
	Zap.finishPlayerLoading.Fire(player, data)
end)

Players.PlayerRemoving:Connect(function(player: Player)
	DataStore.unloadPlayerStats(player)
end)

Zap.pickupDecoration.On(function(player: Player)
	CurrencyHandler.CurrencyHandler(player)
end)

Zap.purchaseIntervalUpgrade.On(function(player: Player)
	UpgradeTierHandler.handleIntervalUpgrade(player)
end)

Zap.purchaseMoveSpeedUpgrade.On(function(player: Player)
	UpgradeTierHandler.handleMoveSpeedUpgrade(player)
end)

Zap.purchaseMultiplierUpgrade.On(function(player: Player)
	UpgradeTierHandler.handleMultiplierUpgrade(player)
end)

Zap.purchaseMaxDecorationsUpgrade.On(function(player: Player)
	UpgradeTierHandler.handleMaxDecorationsUpgrade(player)
end)

--#endregion
