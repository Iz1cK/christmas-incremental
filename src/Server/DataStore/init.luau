--!native
--!optimize 2
--!strict
--#region Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
--#endregion

--#region Packages
local Lapis = require(ReplicatedStorage.Packages.Lapis)
--#endregion

--#region Features
--#endregion

--#region Data
-- local playerData = require(script.Parent.PlayerStats)
local defaulDataType = require(ReplicatedStorage.Data.PlayerTierData)
--#endregion

--#region Types

--#endregion

--#region Variables

local collection = Lapis.createCollection("PlayerData", {
	defaultData = defaulDataType,
})

local documents = {}

--#endregion

--#region Function Declerations
local savePlayerStats: (player: Player, data: defaulDataType.PlayerTierData) -> ()
local loadPlayerStats: (player: Player) -> Lapis.Document<defaulDataType.PlayerTierData>
local unloadPlayerStats: (player: Player) -> ()
--#endregion

--#region Functions
savePlayerStats = function(player: Player, data: defaulDataType.PlayerTierData)
	local document: Lapis.Document<defaulDataType.PlayerTierData> = documents[player]
	document:write(data)
end

loadPlayerStats = function(player: Player)
	collection
		:load(`Player{player.UserId}`, { player.UserId })
		:andThen(function(document)
			if player.Parent == nil then
				-- The player might have left before the document finished loading.
				-- The document needs to be closed because PlayerRemoving won't fire at this point.
				document:close():catch(warn)
				return
			end

			documents[player] = document
		end)
		:catch(function(message)
			warn(`Player {player.Name}'s data failed to load: {message}`)
			player:Kick("Data failed to load.")
		end)
		:await()
	return documents[player]
end

unloadPlayerStats = function(player: Player)
	if documents[player] then
		documents[player]:close():catch(warn)
		documents[player] = nil
	end
end
--#endregion

return table.freeze({
	savePlayerStats = savePlayerStats,
	loadPlayerStats = loadPlayerStats,
	unloadPlayerStats = unloadPlayerStats,
})
