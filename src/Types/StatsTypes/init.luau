local Type = {}

type Currency = { type: "Currency", value: number }
type Interval = { type: "Interval", value: number }
type MoveSpeed = { type: "MoveSpeed", value: number }
type Multiplier = { type: "Multiplier", value: number }
type MaxDecorations = { type: "MaxDecorations", value: number }
type PickupRange = { type: "PickupRange", value: number }

export type StatsTypes = Currency | Interval | MoveSpeed | Multiplier | MaxDecorations | PickupRange

Type["Currency"] = { type = "Currency", value = 0 } :: Currency
Type["Interval"] = { type = "Interval", value = 2 } :: Interval
Type["MoveSpeed"] = { type = "MoveSpeed", value = 16 } :: MoveSpeed
Type["Multiplier"] = { type = "Multiplier", value = 1.0 } :: Multiplier
Type["MaxDecorations"] = { type = "MaxDecorations", value = 5 } :: MaxDecorations
Type["PickupRange"] = { type = "PickupRange", value = 10 } :: PickupRange

Type = table.freeze(Type)

return Type
