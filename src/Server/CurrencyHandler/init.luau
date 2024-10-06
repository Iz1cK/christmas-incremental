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
	-- Return the total amount of spheres
	return guaranteedSpheres + extraSpheres
end

CurrencyHandler = function(player: Player)
	local playerStats = PlayerStats.getPlayerStats(player)
	playerStats[StatsTypes.Currency]:ChangeValue(
		playerStats[StatsTypes.Currency].FinalValue + calculateSpheres(playerStats[StatsTypes.Multiplier].FinalValue)
	)
	local data = { currentCurrency = playerStats[StatsTypes.Currency].FinalValue }
	local stats = PlayerStats.getDataFromStats(playerStats)
	DataStore.savePlayerStats(player, stats)
	Zap.updateCurrency.Fire(player, data)
end

InitPlayer = function(player: Player, currency: number)
	local playerStats = PlayerStats.getPlayerStats(player)
	playerStats[StatsTypes.Currency]:ChangeValue(currency)
end

GetPlayerCurrency = function(player: Player)
	local playerStats = PlayerStats.getPlayerStats(player)
	return playerStats[StatsTypes.Currency].FinalValue
end

SetPlayerCurrency = function(player: Player, currency: number)
	local playerStats = PlayerStats.getPlayerStats(player)
	playerStats[StatsTypes.Currency]:ChangeValue(currency)
end
--#endregion

return table.freeze({
	InitPlayer = InitPlayer,
	CurrencyHandler = CurrencyHandler,
	GetPlayerCurrency = GetPlayerCurrency,
	SetPlayerCurrency = SetPlayerCurrency,
})
