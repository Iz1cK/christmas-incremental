opt server_output = "./Server/ZapServer.luau"
opt client_output = "./Client/ZapClient.luau"
opt yield_type = "future"
opt async_lib = "require(game:GetService('ReplicatedStorage').Packages.Future)"

event pickupDecoration = {
	from: Client,
	type: Reliable,
	call: ManyAsync,
}

event updateCurrency = {
	from: Server,
	type: Reliable,
	call: ManyAsync,
	data: struct {
		currentCurrency: i32,
	}
}

event purchaseMoveSpeedUpgrade = {
	from: Client,
	type: Reliable,
	call: ManyAsync,
}

event purchaseIntervalUpgrade = {
	from: Client,
	type: Reliable,
	call: ManyAsync,
}

event purchaseMultiplierUpgrade = {
	from: Client,
	type: Reliable,
	call: ManyAsync,
}

event purchaseMaxDecorationsUpgrade = {
	from: Client,
	type: Reliable,
	call: ManyAsync,
}

event purchasePickupRangeUpgrade = {
	from: Client,
	type: Reliable,
	call: ManyAsync,
}

event updateMoveSpeedText = {
	from: Server,
	type: Reliable,
	call: ManyAsync,
	data: struct {
		tier: i8,
		currentCurrency: i32,
	}
}

event updateIntervalText = {
	from: Server,
	type: Reliable,
	call: ManyAsync,
	data: struct {
		tier: i8,
		currentCurrency: i32,
	}
}

event updateMultiplierText = {
	from: Server,
	type: Reliable,
	call: ManyAsync,
	data: struct {
		tier: i8,
		currentCurrency: i32,
	}
}

event updateMaxDecorationsText = {
	from: Server,
	type: Reliable,
	call: ManyAsync,
	data: struct {
		tier: i8,
		currentCurrency: i32,
	}
}

event updatePickupRangeText = {
	from: Server,
	type: Reliable,
	call: ManyAsync,
	data: struct {
		tier: i8,
		currentCurrency: i32,
	}
}

event finishPlayerLoading = {
	from: Server,
	type: Reliable,
	call: ManyAsync,
	data: unknown
}