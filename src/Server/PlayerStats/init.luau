--!native
--!optimize 2
--!strict
--#region Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
--#endregion

--#region Packages
--#endregion

--#region Features
local StatsObject = require(ReplicatedStorage.Features.StatsObject)
export type StatsObject = StatsObject.Stat

local StatsTypes = require(ReplicatedStorage.Types.StatsTypes)
export type StatsTypes = StatsTypes.StatsTypes

local PlayerTierData = require(ReplicatedStorage.Data.PlayerTierData)
--#endregion

--#region Data
local decorationsStats = require(ReplicatedStorage.Data.DecorationStats)
--#endregion

--#region Types

type playerData = {
	[StatsTypes]: StatsObject,
}
--#endregion

--#region Variables
local allPlayersData: { [Player]: playerData } = {}
--#endregion

--#region Function Declerations
local initPlayerStats: (player: Player, data: PlayerTierData.PlayerTierData) -> ()
local getPlayerStats: (player: Player) -> playerData
local getPlayerTierDataFromStats: (player: Player) -> PlayerTierData.PlayerTierData
--#endregion

--#region Functions
initPlayerStats = function(player: Player, data: PlayerTierData.PlayerTierData)
	local playerData: playerData = {}
	print("data:", data)
	for key: string, value: number in pairs(data) do
		if key == "Currency" then
			playerData[StatsTypes[key]] = StatsObject.new(key, value)
			continue
		end
		playerData[StatsTypes[key]] = StatsObject.new(key, decorationsStats[value][key].Upgrade)
	end
	print(playerData)
	allPlayersData[player] = playerData
end

local function findUpgradeTier(input)
	-- Extract upgrade type and value from input
	local upgradeType = input.StatsName
	local upgradeValue = input.StatValue
	-- Iterate through all the tiers (keys)
	for tier, upgrades in pairs(decorationsStats) do
		-- Check if the specific upgradeType exists in the current tier
		local upgrade = upgrades[upgradeType]
		if upgrade and upgrade.Upgrade == upgradeValue then
			-- Return the tier if we find a match
			return tier
		end
	end

	-- Return nil if no match was found
	return -1
end

getPlayerStats = function(player: Player): playerData
	return allPlayersData[player]
end

getPlayerTierDataFromStats = function(player: Player): PlayerTierData.PlayerTierData
	local playerData: { [StatsTypes]: StatsObject } = getPlayerStats(player)
	print("playerData:", playerData)
	local playerTierData: PlayerTierData.PlayerTierData = table.clone(PlayerTierData)
	for key, value in pairs(playerData) do
		if key == StatsTypes.Currency then
			playerTierData[key.type] = value.StatValue
			continue
		end
		playerTierData[key.type] = findUpgradeTier(value)
	end
	print("playerTierData:", playerTierData)
	return playerTierData
end
--#endregion

return table.freeze({
	initPlayerStats = initPlayerStats,
	StatsTypes = StatsTypes,
	getPlayerStats = getPlayerStats,
	getPlayerTierDataFromStats = getPlayerTierDataFromStats,
})
