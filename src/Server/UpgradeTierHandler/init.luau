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
local PlayerTierData = require(ReplicatedStorage.Data.PlayerTierData)
local playerTiers: { [Player]: PlayerTierData.PlayerTierData } = {}
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
	if not playerTiers[player] then
		playerTiers[player] = table.clone(PlayerTierData)
	end
	if not playerTiers[player]["Interval"] then
		playerTiers[player]["Interval"] = 0
	end
	local playerStats = PlayerStats.getPlayerStats(player)
	local currentTier = playerTiers[player]["Interval"]
	local currency = CurrencyHandler.GetPlayerCurrency(player)
	local cost = decorationsData[currentTier + 1]["Interval"]["Cost"]
	if currency >= cost then
		CurrencyHandler.SetPlayerCurrency(player, currency - cost)
		playerTiers[player]["Interval"] = currentTier + 1
		playerStats[PlayerStats.StatsTypes.Interval]:Change(decorationsData[currentTier + 1].Interval.Upgrade)
		DataStore.savePlayerStats(player, playerTiers[player])
		Zap.updateIntervalText.Fire(player, { tier = currentTier + 1, currentCurrency = currency - cost })
		warn(player.Name .. " purchased an interval upgrade")
	else
		warn(player.Name .. " does not have enough currency to purchase an interval upgrade")
	end
end

handleMoveSpeedUpgrade = function(player: Player)
	if not playerTiers[player] then
		playerTiers[player] = table.clone(PlayerTierData)
	end
	if not playerTiers[player]["MoveSpeed"] then
		playerTiers[player]["MoveSpeed"] = 0
	end
	local playerStats = PlayerStats.getPlayerStats(player)
	local currentTier = playerTiers[player]["MoveSpeed"]
	local currency = CurrencyHandler.GetPlayerCurrency(player)
	local cost = decorationsData[currentTier + 1]["MoveSpeed"]["Cost"]
	if currency >= cost then
		CurrencyHandler.SetPlayerCurrency(player, currency - cost)
		playerTiers[player]["MoveSpeed"] = currentTier + 1
		playerStats[PlayerStats.StatsTypes.MoveSpeed]:Change(decorationsData[currentTier + 1].MoveSpeed.Upgrade)
		DataStore.savePlayerStats(player, playerTiers[player])
		Zap.updateMoveSpeedText.Fire(player, { tier = currentTier + 1, currentCurrency = currency - cost })
		warn(player.Name .. " purchased an movement speed upgrade")
	else
		warn(player.Name .. " does not have enough currency to purchase a movement speed upgrade")
	end
end

handleMultiplierUpgrade = function(player: Player)
	if not playerTiers[player] then
		playerTiers[player] = table.clone(PlayerTierData)
	end
	if not playerTiers[player]["Multiplier"] then
		playerTiers[player]["Multiplier"] = 0
	end
	local currentTier = playerTiers[player]["Multiplier"]
	local currency = CurrencyHandler.GetPlayerCurrency(player)
	local cost = decorationsData[currentTier + 1]["Multiplier"]["Cost"]
	local playerStats = PlayerStats.getPlayerStats(player)
	if currency >= cost then
		CurrencyHandler.SetPlayerCurrency(player, currency - cost)
		playerTiers[player]["Multiplier"] = currentTier + 1
		playerStats[PlayerStats.StatsTypes.Multiplier]:Change(decorationsData[currentTier + 1].Multiplier.Upgrade)
		DataStore.savePlayerStats(player, playerTiers[player])
		Zap.updateMultiplierText.Fire(player, { tier = currentTier + 1, currentCurrency = currency - cost })
		warn(player.Name .. " purchased a multiplier upgrade")
	else
		warn(player.Name .. " does not have enough currency to purchase a multiplier upgrade")
	end
end

handleMaxDecorationsUpgrade = function(player: Player)
	if not playerTiers[player] then
		playerTiers[player] = table.clone(PlayerTierData)
	end
	if not playerTiers[player]["MaxDecorations"] then
		playerTiers[player]["MaxDecorations"] = 0
	end
	local playerStats = PlayerStats.getPlayerStats(player)
	local currentTier = playerTiers[player]["MaxDecorations"]
	local currency: number = CurrencyHandler.GetPlayerCurrency(player)
	local cost: number = decorationsData[currentTier + 1]["MaxDecorations"]["Cost"]
	if currency >= cost then
		CurrencyHandler.SetPlayerCurrency(player, currency - cost)
		-- print(playerTiers[player])
		playerTiers[player]["MaxDecorations"] = currentTier + 1
		playerStats[PlayerStats.StatsTypes.MaxDecorations]:Change(
			decorationsData[currentTier + 1].MaxDecorations.Upgrade
		)
		DataStore.savePlayerStats(player, playerTiers[player])
		Zap.updateMaxDecorationsText.Fire(player, { tier = currentTier + 1, currentCurrency = currency - cost })
		warn(player.Name .. " purchased a max decoration upgrade")
	else
		warn(player.Name .. " does not have enough currency to purchase an max decoration upgrade")
	end
end

handlePickupRangeUpgrade = function(player: Player)
	if not playerTiers[player] then
		playerTiers[player] = table.clone(PlayerTierData)
	end
	if not playerTiers[player]["PickupRange"] then
		playerTiers[player]["PickupRange"] = 0
	end
	local playerStats = PlayerStats.getPlayerStats(player)
	local currentTier = playerTiers[player]["PickupRange"]
	local currency = CurrencyHandler.GetPlayerCurrency(player)
	local cost = decorationsData[currentTier + 1]["PickupRange"]["Cost"]
	if currency >= cost then
		CurrencyHandler.SetPlayerCurrency(player, currency - cost)
		playerTiers[player]["PickupRange"] = currentTier + 1
		playerStats[PlayerStats.StatsTypes.PickupRange]:Change(decorationsData[currentTier + 1].PickupRange.Upgrade)
		DataStore.savePlayerStats(player, playerTiers[player])
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
	playerTiers = playerTiers,
})
