--!native
--!optimize 2
--!strict
--#region Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
--#endregion

--#region Features
local StatsTypes = require(ReplicatedStorage.Types.StatsTypes)
local playerStats = require(script.Parent.Parent.PlayerTiers)
--#endregion

--#region Variables
local connections = {}
--#endregion

--#region Function Declarations
local connectStats: (callback: (statType: StatsTypes.StatsTypes, newValue: number, oldValue: number) -> ()) -> ()
local disconnectAllStats: () -> ()
--#endregion

--#region Functions
connectStats = function(callback)
	for statType, _ in pairs(StatsTypes) do
		local connection = playerStats[statType]:Connect(function(_statName: string, newValue: number, oldValue: number)
			callback(statType, newValue, oldValue)
		end)

		-- Store the connection in the connections table
		table.insert(connections, connection)
	end
end

-- Function to disconnect all stat connections
disconnectAllStats = function()
	for _, connection in pairs(connections) do
		if connection then
			connection()
		end
	end

	-- Clear the connections table
	connections = {}
end

--#endregion

return table.freeze({ connectStats = connectStats, disconnectAllStats = disconnectAllStats })
