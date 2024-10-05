--!native
--!optimize 2
--!strict
--#region Services
--#endregion

--#region Packages
local Zap = require(script.Parent.ZapServer)
--#endregion

--#region Features
local DataStore = require(script.Parent.DataStore)
--#endregion

--#region Data
local playerCurrencies: { [Player]: number } = {}
local PlayerStats = require(script.Parent.PlayerStats)
--#endregion

--#region Types
local StatsTypes = PlayerStats.StatsTypes
--#endregion

--#region Variables
--#endregion

--#region Function Declerations
local CurrencyHandler: (player: Player) -> ()

local InitPlayer: (player: Player, currency: number) -> ()

local GetPlayerCurrency: (player: Player) -> number

local SetPlayerCurrency: (player: Player, currency: number) -> ()

local calculateSpheres: (multiplier: number) -> number
--#endregion

--#region Functions

calculateSpheres = function(multiplier)
	-- Guaranteed spheres are based on the integer part of the multiplier
	local guaranteedSpheres = multiplier // 1

	-- Extra chance is determined by the decimal part
	local extraChance = (multiplier % guaranteedSpheres)

	-- Calculate how many extra spheres to give based on the extra chance
	local extraSpheres = math.random(0, 1) < extraChance and 1 or 0

	return guaranteedSpheres + extraSpheres
end

CurrencyHandler = function(player: Player)
	local currency = playerCurrencies[player]
	local playerStats = PlayerStats.getPlayerStats(player)
	if currency then
		playerCurrencies[player] += calculateSpheres(playerStats[StatsTypes.Multiplier].StatValue)
	else
		playerCurrencies[player] = 1
	end
	local data = { currentCurrency = playerCurrencies[player] }
	playerStats[StatsTypes.Currency]:Change(playerCurrencies[player])
	DataStore.savePlayerStats(player, PlayerStats.getPlayerTierDataFromStats(player))
	Zap.updateCurrency.Fire(player, data)
end

InitPlayer = function(player: Player, currency: number)
	playerCurrencies[player] = currency or 0
end

GetPlayerCurrency = function(player: Player)
	return playerCurrencies[player]
end

SetPlayerCurrency = function(player: Player, currency: number)
	playerCurrencies[player] = currency
end
--#endregion

return table.freeze({
	InitPlayer = InitPlayer,
	CurrencyHandler = CurrencyHandler,
	GetPlayerCurrency = GetPlayerCurrency,
	SetPlayerCurrency = SetPlayerCurrency,
})
