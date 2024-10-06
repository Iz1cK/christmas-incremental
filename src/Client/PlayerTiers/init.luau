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

local StatsTypes = require(ReplicaService.Types.StatsTypes)

export type StatsObject = StatsObject.Stat
--#endregion

--#region Data
local playerData: { [StatsTypes.StatsTypes]: StatsObject } = {
	[StatsTypes.Currency] = StatsObject.new("Currency", 0),
	[StatsTypes.Interval] = StatsObject.new("Interval", 0),
	[StatsTypes.MoveSpeed] = StatsObject.new("MoveSpeed", 0),
	[StatsTypes.Multiplier] = StatsObject.new("Multiplier", 0),
	[StatsTypes.MaxDecorations] = StatsObject.new("MaxDecorations", 0),
	[StatsTypes.PickupRange] = StatsObject.new("PickupRange", 0),
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
