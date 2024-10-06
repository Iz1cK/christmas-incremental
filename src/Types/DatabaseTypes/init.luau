local DatabaseTypes = {}

export type DatabaseTypesTable = {
	[string]: number,
}

DatabaseTypes["Currency"] = 0
DatabaseTypes["Interval"] = 0
DatabaseTypes["MoveSpeed"] = 0
DatabaseTypes["Multiplier"] = 0
DatabaseTypes["MaxDecorations"] = 0
DatabaseTypes["PickupRange"] = 0

DatabaseTypes = table.freeze(DatabaseTypes)

return DatabaseTypes
