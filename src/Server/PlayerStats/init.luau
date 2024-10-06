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

local DatabaseTypes = require(ReplicatedStorage.Types.DatabaseTypes)
--#endregion

--#region Data
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
local initPlayerStats: (player: Player, data: DatabaseTypes.DatabaseTypesTable) -> ()
local getPlayerStats: (player: Player) -> playerData
local getStats: (player: Player) -> StatsTypes.StatsTypesTable
local updateStats: (player: Player, data: playerData) -> ()
local getStatsFromData: (data: DatabaseTypes.DatabaseTypesTable) -> playerData
local getDataFromStats: (data: playerData) -> DatabaseTypes.DatabaseTypesTable
--#endregion

--#region Functions
initPlayerStats = function(player: Player, data: DatabaseTypes.DatabaseTypesTable)
	local playerData: playerData = {}
	for key: string, value: number in pairs(data) do
		playerData[StatsTypes[key]] = StatsObject.new(key, value)
	end
	allPlayersData[player] = playerData
end

getPlayerStats = function(player: Player): playerData
	return allPlayersData[player]
end

getStats = function(player: Player): StatsTypes.StatsTypesTable
	local playerData = allPlayersData[player]
	local stats: StatsTypes.StatsTypesTable = {}
	for key: StatsTypes, value: StatsObject in pairs(playerData) do
		stats[key.type] = StatsTypes[value.StatsName]
	end
	return stats
end

updateStats = function(player: Player, data: playerData)
	allPlayersData[player] = data
end

getStatsFromData = function(data: DatabaseTypes.DatabaseTypesTable): playerData
	local playerData: playerData = {}
	for key: string, value: number in pairs(data) do
		playerData[StatsTypes[key]] = StatsObject.new(key, value)
	end
	return playerData
end

getDataFromStats = function(data: playerData): DatabaseTypes.DatabaseTypesTable
	local stats: DatabaseTypes.DatabaseTypesTable = {}
	for key: StatsTypes, value: StatsObject in pairs(data) do
		if key.type == "Currency" then
			stats[key.type] = value.FinalValue
		else
			stats[key.type] = value.StatTier
		end
	end
	return stats
end

return table.freeze({
	initPlayerStats = initPlayerStats,
	StatsTypes = StatsTypes,
	getPlayerStats = getPlayerStats,
	getStats = getStats,
	updateStats = updateStats,
	getStatsFromData = getStatsFromData,
	getDataFromStats = getDataFromStats,
})
