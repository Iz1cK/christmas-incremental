--!native
--!optimize 2
--!strict
--#region Services
--#endregion

--#region Packages
local Zap = require(script.Parent.ZapServer)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
--#endregion

--#region Features
local CurrencyHandler = require(script.Parent.CurrencyHandler)
local decorationsData = require(ReplicatedStorage.Data.DecorationStats)
local PlayerStats = require(script.Parent.PlayerStats)
local DataStore = require(script.Parent.DataStore)
--#endregion

--#region Data
--#endregion

--#region Types
--#endregion

--#region Variables
--#endregion

--#region Function Declerations
local handleIntervalUpgrade: (player: Player) -> ()
local handleMoveSpeedUpgrade: (player: Player) -> ()
local handleMultiplierUpgrade: (player: Player) -> ()
local handleMaxDecorationsUpgrade: (player: Player) -> ()
local handlePickupRangeUpgrade: (player: Player) -> ()
--#endregion

--#region Functions
handleIntervalUpgrade = function(player: Player)
	local playerStats = PlayerStats.getPlayerStats(player)
	local currency = CurrencyHandler.GetPlayerCurrency(player)
	local currentTier = playerStats[PlayerStats.StatsTypes.Interval].StatTier :: number
	local cost = decorationsData[currentTier + 1]["Interval"]["Cost"]
	if currency >= cost then
		CurrencyHandler.SetPlayerCurrency(player, currency - cost)
		playerStats[PlayerStats.StatsTypes.Interval]:ChangeValueByTier(currentTier + 1)
		local stats = PlayerStats.getDataFromStats(playerStats)
		DataStore.savePlayerStats(player, stats)
		Zap.updateIntervalText.Fire(player, { tier = currentTier + 1, currentCurrency = currency - cost })
		warn(player.Name .. " purchased an interval upgrade")
	else
		warn(player.Name .. " does not have enough currency to purchase an interval upgrade")
	end
end

handleMoveSpeedUpgrade = function(player: Player)
	local playerStats = PlayerStats.getPlayerStats(player)
	local currentTier = playerStats[PlayerStats.StatsTypes.MoveSpeed].StatTier :: number
	local currency = CurrencyHandler.GetPlayerCurrency(player)
	local cost = decorationsData[currentTier + 1]["MoveSpeed"]["Cost"]
	if currency >= cost then
		CurrencyHandler.SetPlayerCurrency(player, currency - cost)
		playerStats[PlayerStats.StatsTypes.MoveSpeed]:ChangeValueByTier(currentTier + 1)
		local stats = PlayerStats.getDataFromStats(playerStats)
		DataStore.savePlayerStats(player, stats)
		Zap.updateMoveSpeedText.Fire(player, { tier = currentTier + 1, currentCurrency = currency - cost })
		warn(player.Name .. " purchased an movement speed upgrade")
	else
		warn(player.Name .. " does not have enough currency to purchase a movement speed upgrade")
	end
end

handleMultiplierUpgrade = function(player: Player)
	local playerStats = PlayerStats.getPlayerStats(player)
	local currentTier = playerStats[PlayerStats.StatsTypes.Multiplier].StatTier :: number
	local currency = CurrencyHandler.GetPlayerCurrency(player)
	local cost = decorationsData[currentTier + 1]["Multiplier"]["Cost"]
	if currency >= cost then
		CurrencyHandler.SetPlayerCurrency(player, currency - cost)
		playerStats[PlayerStats.StatsTypes.Multiplier]:ChangeValueByTier(currentTier + 1)
		local stats = PlayerStats.getDataFromStats(playerStats)
		DataStore.savePlayerStats(player, stats)
		Zap.updateMultiplierText.Fire(player, { tier = currentTier + 1, currentCurrency = currency - cost })
		warn(player.Name .. " purchased a multiplier upgrade")
	else
		warn(player.Name .. " does not have enough currency to purchase a multiplier upgrade")
	end
end

handleMaxDecorationsUpgrade = function(player: Player)
	local playerStats = PlayerStats.getPlayerStats(player)
	local currentTier = playerStats[PlayerStats.StatsTypes.MaxDecorations].StatTier :: number
	local currency: number = CurrencyHandler.GetPlayerCurrency(player)
	local cost: number = decorationsData[currentTier + 1]["MaxDecorations"]["Cost"]
	if currency >= cost then
		CurrencyHandler.SetPlayerCurrency(player, currency - cost)
		playerStats[PlayerStats.StatsTypes.MaxDecorations]:ChangeValueByTier(currentTier + 1)
		local stats = PlayerStats.getDataFromStats(playerStats)
		DataStore.savePlayerStats(player, stats)
		Zap.updateMaxDecorationsText.Fire(player, { tier = currentTier + 1, currentCurrency = currency - cost })
		warn(player.Name .. " purchased a max decoration upgrade")
	else
		warn(player.Name .. " does not have enough currency to purchase an max decoration upgrade")
	end
end

handlePickupRangeUpgrade = function(player: Player)
	local playerStats = PlayerStats.getPlayerStats(player)
	local currentTier = playerStats[PlayerStats.StatsTypes.PickupRange].StatTier :: number
	local currency = CurrencyHandler.GetPlayerCurrency(player)
	local cost = decorationsData[currentTier + 1]["PickupRange"]["Cost"]
	if currency >= cost then
		CurrencyHandler.SetPlayerCurrency(player, currency - cost)
		playerStats[PlayerStats.StatsTypes.PickupRange]:ChangeValueByTier(currentTier + 1)
		local stats = PlayerStats.getDataFromStats(playerStats)
		DataStore.savePlayerStats(player, stats)
		Zap.updatePickupRangeText.Fire(player, { tier = currentTier + 1, currentCurrency = currency - cost })
		warn(player.Name .. " purchased a pickup range upgrade")
	else
		warn(player.Name .. " does not have enough currency to purchase a pickup range upgrade")
	end
end
--#endregion

return table.freeze({
	handleIntervalUpgrade = handleIntervalUpgrade,
	handleMoveSpeedUpgrade = handleMoveSpeedUpgrade,
	handleMultiplierUpgrade = handleMultiplierUpgrade,
	handleMaxDecorationsUpgrade = handleMaxDecorationsUpgrade,
	handlePickupRangeUpgrade = handlePickupRangeUpgrade,
})
