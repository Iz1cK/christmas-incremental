export type PlayerTierData = {
	Currency: number,
	Interval: number,
	MoveSpeed: number,
	Multiplier: number,
	MaxDecorations: number,
	PickupRange: number,
}
local data: PlayerTierData = {
	Currency = 0,
	Interval = 0,
	MoveSpeed = 0,
	Multiplier = 0,
	MaxDecorations = 0,
	PickupRange = 0,
}
return table.freeze(data)
