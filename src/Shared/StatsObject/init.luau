--!native
--!optimize 2
--!strict
--#region Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
--#endregion

--#region Packages
local Signal = require(ReplicatedStorage.Packages.Signal)
--#endregion

--#region Features
--#endregion

--#region Data
--#endregion

--#region Types
export type ModifierItem = {
	multiplicative: number,
	additive: number,
}

export type _StatPrototype = {
	__index: _StatPrototype,
	new: (StatsName: string, startingValue: number?, isMultiplicativeAdditive: boolean?) -> Stat,
	Reset: (self: Stat) -> (),
	Add: (self: Stat, value: number) -> (),
	Change: (self: Stat, value: number) -> (),
	Connect: (self: Stat, callback: (statName: string, newValue: number, oldValue: number) -> ()) -> () -> (),
	DisconnectAll: (self: Stat) -> (),

	AddModifier: (self: Stat, modifierName: string, modifierItem: ModifierItem) -> boolean,
	UpdateModifier: (self: Stat, modifierName: string, modifierItem: ModifierItem) -> boolean,
	RemoveModifier: (self: Stat, modifierName: string) -> boolean,
	ResetModifiers: (self: Stat) -> boolean,

	GetModifier: (self: Stat, modifierName: string) -> ModifierItem?,
	GetModifiers: (self: Stat) -> { [string]: ModifierItem },

	UpdateFinalValue: (self: Stat) -> boolean,
}

export type _StatData = {
	StatsName: string,
	StatValue: number,
	DefaultValue: number?,
	FinalValue: number?,
	isMultiplicativeAdditive: boolean,
	modifiersList: { [string]: ModifierItem },
	_connection: Signal.Signal<string, number, number>,
}
export type Stat = typeof(setmetatable({} :: _StatData, {} :: _StatPrototype))
--#endregion

--#region Variables
local Stat: _StatPrototype = {} :: _StatPrototype
Stat.__index = Stat
--#endregion

--#region Function Declerations
--#endregion

--#region Functions
--- Creates a new Stat
--- @param StatsName string
--- @return Stat
function Stat.new(StatsName: string, startingValue: number?, isMultiplicativeAdditive: boolean?): Stat
	local _data: _StatData = {
		StatsName = StatsName,
		StatValue = startingValue or 0,
		FinalValue = startingValue or 0,
		DefaultValue = startingValue or 0,
		modifiersList = {},
		isMultiplicativeAdditive = isMultiplicativeAdditive or false,
		_connection = Signal(),
	}
	local self = setmetatable(_data, Stat)
	return self
end

--- Destroys a Stat
--- @param self Stat
function Stat:Reset()
	self.StatValue = self.DefaultValue :: number
end

--- Adds a value to a Stat
--- @param self Stat
--- @param value number
function Stat:Add(value: number)
	self.StatValue += value
end

--- Changes a Stat to a value
--- @param self Stat
--- @param value number
function Stat:Change(value: number)
	self.StatValue = value
end

--- Connects a callback to a Stat
--- @param self Stat
--- @param callback (statName: string, newValue: number, oldValue: number) -> ()
--- @return () -> ()
function Stat:Connect(callback: (statName: string, newValue: number, oldValue: number) -> ())
	return self._connection:Connect(callback)
end

--- Disconnects all functions from the Stat
--- @param self Stat
function Stat:DisconnectAll()
	self._connection:DisconnectAll()
end

--- Adds a new modifier to the Stat
--- @param self Stat
--- @param modifierName string
--- @param modifierItem ModifierItem
--- @return boolean
function Stat:AddModifier(modifierName: string, modifierItem: ModifierItem): boolean
	if self.modifiersList[modifierName] then
		return false
	end
	self.modifiersList[modifierName] = modifierItem
	self:UpdateFinalValue()
	return true
end

--- Updates a modifier of the Stat
--- @param self Stat
--- @param modifierName string
--- @param modifierItem ModifierItem
--- @return boolean
function Stat:UpdateModifier(modifierName: string, modifierItem: ModifierItem): boolean
	if not self.modifiersList[modifierName] then
		return false
	end
	self.modifiersList[modifierName] = modifierItem
	self:UpdateFinalValue()
	return true
end

--- Removes a modifier from the Stat
--- @param self Stat
--- @param modifierName string
--- @return boolean
function Stat:RemoveModifier(modifierName: string): boolean
	if not self.modifiersList[modifierName] then
		return false
	end
	self.modifiersList[modifierName] = nil
	self:UpdateFinalValue()
	return true
end

--- Resets all modifiers of the Stat
--- @param self Stat
--- @return boolean
function Stat:ResetModifiers(): boolean
	self.modifiersList = {}
	self:UpdateFinalValue()
	return true
end

--- Gets a modifier of the Stat
--- @param self Stat
--- @param modifierName string
--- @return ModifierItem?
function Stat:GetModifier(modifierName: string): ModifierItem?
	return self.modifiersList[modifierName]
end

--- Gets all modifiers of the Stat
--- @param self Stat
--- @return {[string]: ModifierItem}
function Stat:GetModifiers(): { [string]: ModifierItem }
	return self.modifiersList
end

--- Updates the final value of the Stat
--- @param self Stat
--- @return boolean
function Stat:UpdateFinalValue(): boolean
	local oldFinalValue = self.FinalValue :: number

	local finalValue = self.StatValue
	if self.isMultiplicativeAdditive then
		local additive = 0
		local multiplicative = 1
		for _, modifierItem in self.modifiersList do
			additive = additive + modifierItem.additive
			multiplicative = multiplicative + modifierItem.multiplicative
		end
		finalValue = finalValue * multiplicative + additive
	else
		for _, modifierItem in self.modifiersList do
			finalValue = finalValue * (1 + modifierItem.multiplicative) + modifierItem.additive
		end
	end
	self.FinalValue = finalValue
	if oldFinalValue ~= finalValue then
		self._connection:Fire(self.StatsName, finalValue, oldFinalValue)
	end
	return true
end
--#endregion

return table.freeze(Stat)
