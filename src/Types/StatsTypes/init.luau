local StatsTypes = {}

type Currency = { type: "Currency", value: number }
type Interval = { type: "Interval", value: number }
type MoveSpeed = { type: "MoveSpeed", value: number }
type Multiplier = { type: "Multiplier", value: number }
type MaxDecorations = { type: "MaxDecorations", value: number }
type PickupRange = { type: "PickupRange", value: number }

export type StatsTypes = Currency | Interval | MoveSpeed | Multiplier | MaxDecorations | PickupRange

export type StatsTypesTable = {
	[string]: StatsTypes,
}

StatsTypes["Currency"] = { type = "Currency", value = 0 } :: Currency
StatsTypes["Interval"] = { type = "Interval", value = 0 } :: Interval
StatsTypes["MoveSpeed"] = { type = "MoveSpeed", value = 0 } :: MoveSpeed
StatsTypes["Multiplier"] = { type = "Multiplier", value = 0 } :: Multiplier
StatsTypes["MaxDecorations"] = { type = "MaxDecorations", value = 0 } :: MaxDecorations
StatsTypes["PickupRange"] = { type = "PickupRange", value = 0 } :: PickupRange

StatsTypes = table.freeze(StatsTypes)

return StatsTypes
