--!native
--!optimize 2
--!strict
--#region Services
local ReplicaService = game:GetService("ReplicatedStorage")
--#endregion

--#region Packages
--#endregion

--#region Features
local StatsObject = require(ReplicaService.Features.StatsObject)

export type StatsObject = StatsObject.Stat
--#endregion

--#region Data
local playerData: { [string]: StatsObject } = {
	["Currency"] = StatsObject.new("Currency", 0),
	["Interval"] = StatsObject.new("Interval", 2),
	["MoveSpeed"] = StatsObject.new("MoveSpeed", 16),
	["Multiplier"] = StatsObject.new("Multiplier", 1.0),
	["MaxDecorations"] = StatsObject.new("MaxDecorations", 5),
	["PickupRange"] = StatsObject.new("PickupRange", 10),
}
--#endregion

--#region Types
--#endregion

--#region Variables
--#endregion

--#region Function Declerations
--#endregion

--#region Functions
--#endregion

return table.freeze(playerData)
