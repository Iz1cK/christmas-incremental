--!native
--!optimize 2
--!strict
--#region Services
-- local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
--#endregion

--#region Packages
local Zap = require(script.Parent.ZapClient)
--#endregion

--#region Features
--#endregion

--#region Data
local decorationStats = require(ReplicatedStorage.Data.DecorationStats)
local playerStats = require(script.Parent.PlayerTiers)
local StatsTypes = require(ReplicatedStorage.Types.StatsTypes)
--#endregion

--#region Types
--#endregion

--#region Variables
local upgradeScreen = workspace:WaitForChild("UpgradeScreen")
local surfaceGui = upgradeScreen:WaitForChild("SurfaceGui")
local statsGui = surfaceGui:WaitForChild("ScrollingFrame")
local intervalUpgradeText = statsGui:WaitForChild("UpgradeInterval")
local moveSpeedUpgradeText = statsGui:WaitForChild("UpgradeMoveSpeed")
local multiplierUpgradeText = statsGui:WaitForChild("UpgradeMultiplier")
local maxDecorationUpgradeText = statsGui:WaitForChild("UpgradeMaxDecoration")
local pickupRangeUpgradeText = statsGui:WaitForChild("UpgradePickupRange")
local buyInterval = statsGui:WaitForChild("BuyInterval") :: TextButton
local buyMoveSpeed = statsGui:WaitForChild("BuyMoveSpeed")
local buyMultiplier = statsGui:WaitForChild("BuyMultiplier") :: TextButton
local buyMaxDecoration = statsGui:WaitForChild("BuyMaxDecoration")
local buyPickupRange = statsGui:WaitForChild("BuyPickupRange")
local playerGUI = Players.localPlayer:WaitForChild("PlayerGui")
local currencyGui = playerGUI:WaitForChild("StatsGui")
--#endregion

--#region Function Declerations
local updateCurrency: (currency: number) -> ()
local update: (data: any) -> ()
--#endregion
intervalUpgradeText.Text =
	`Upgrade Interval\n{decorationStats[0].Interval.Upgrade} -> {decorationStats[1].Interval.Upgrade}\n {decorationStats[1].Interval.Cost} Decorations`
playerStats[StatsTypes.Interval]:ChangeValueByTier(0)

moveSpeedUpgradeText.Text =
	`Upgrade Movespeed\n{decorationStats[0].MoveSpeed.Upgrade} -> {decorationStats[1].MoveSpeed.Upgrade}\n {decorationStats[1].MoveSpeed.Cost} Decorations`
playerStats[StatsTypes.MoveSpeed]:ChangeValueByTier(0)

multiplierUpgradeText.Text =
	`Upgrade Multiplier\n{decorationStats[0].Multiplier.Upgrade} -> {decorationStats[1].Multiplier.Upgrade}\n {decorationStats[1].Multiplier.Cost} Decorations`
playerStats[StatsTypes.Multiplier]:ChangeValueByTier(0)
maxDecorationUpgradeText.Text =
	`Upgrade Max Decoration\n{decorationStats[0].MaxDecorations.Upgrade} -> {decorationStats[1].MaxDecorations.Upgrade}\n {decorationStats[1].MaxDecorations.Cost} Decorations`
playerStats[StatsTypes.MaxDecorations]:ChangeValueByTier(0)

pickupRangeUpgradeText.Text =
	`Upgrade Pickup Range\n{decorationStats[0].PickupRange.Upgrade} -> {decorationStats[1].PickupRange.Upgrade}\n {decorationStats[1].PickupRange.Cost} Decorations`
playerStats[StatsTypes.PickupRange]:ChangeValueByTier(0)

--#region Functions
updateCurrency = function(currency: number)
	local currencyLabel = currencyGui:WaitForChild("Currency")
	currencyLabel.Text = currency
end
local function updateIntervalText(tier: number)
	intervalUpgradeText.Text =
		`Upgrade Interval\n{decorationStats[tier].Interval.Upgrade} -> {decorationStats[tier + 1].Interval.Upgrade}\n {decorationStats[tier + 1].Interval.Cost} Decorations`
	playerStats[StatsTypes.Interval]:ChangeValueByTier(tier)
end

local function updateMoveSpeedText(tier: number)
	moveSpeedUpgradeText.Text =
		`Upgrade Movespeed\n{decorationStats[tier].MoveSpeed.Upgrade} -> {decorationStats[tier + 1].MoveSpeed.Upgrade}\n {decorationStats[tier + 1].MoveSpeed.Cost} Decorations`
	playerStats[StatsTypes.MoveSpeed]:ChangeValueByTier(tier)
end

local function updateMultiplierText(tier: number)
	multiplierUpgradeText.Text =
		`Upgrade Multiplier\n{decorationStats[tier].Multiplier.Upgrade} -> {decorationStats[tier + 1].Multiplier.Upgrade}\n {decorationStats[tier + 1].Multiplier.Cost} Decorations`
	playerStats[StatsTypes.Multiplier]:ChangeValueByTier(tier)
end

local function updateMaxDecorationsText(tier: number)
	maxDecorationUpgradeText.Text =
		`Upgrade MaxDecorations\n{decorationStats[tier].MaxDecorations.Upgrade} -> {decorationStats[tier + 1].MaxDecorations.Upgrade}\n {decorationStats[tier + 1].MaxDecorations.Cost} Decorations`
	playerStats[StatsTypes.MaxDecorations]:ChangeValueByTier(tier)
end

local function updatePickupRangeText(tier: number)
	pickupRangeUpgradeText.Text =
		`Upgrade Pickup Range\n{decorationStats[tier].PickupRange.Upgrade} -> {decorationStats[tier + 1].PickupRange.Upgrade}\n {decorationStats[tier + 1].PickupRange.Cost} Decorations`
	playerStats[StatsTypes.PickupRange]:ChangeValueByTier(tier)
end

buyInterval.MouseButton1Click:Connect(function()
	Zap.purchaseIntervalUpgrade.Fire()
end)

buyMoveSpeed.MouseButton1Click:Connect(function()
	Zap.purchaseMoveSpeedUpgrade.Fire()
end)

buyMultiplier.MouseButton1Click:Connect(function()
	Zap.purchaseMultiplierUpgrade.Fire()
end)

buyMaxDecoration.MouseButton1Click:Connect(function()
	Zap.purchaseMaxDecorationsUpgrade.Fire()
end)

buyPickupRange.MouseButton1Click:Connect(function()
	Zap.purchasePickupRangeUpgrade.Fire()
end)

Zap.updateIntervalText.On(function(data)
	updateCurrency(data.currentCurrency)
	updateIntervalText(data.tier)
end)

Zap.updateMoveSpeedText.On(function(data)
	updateCurrency(data.currentCurrency)
	updateMoveSpeedText(data.tier)
end)

Zap.updateMultiplierText.On(function(data)
	updateCurrency(data.currentCurrency)
	updateMultiplierText(data.tier)
end)

Zap.updateMaxDecorationsText.On(function(data)
	updateCurrency(data.currentCurrency)
	updateMaxDecorationsText(data.tier)
end)

Zap.updatePickupRangeText.On(function(data)
	updateCurrency(data.currentCurrency)
	updatePickupRangeText(data.tier)
end)

update = function(data: any)
	print(data)
	updateCurrency(data["Currency"])
	updateIntervalText(data["Interval"])
	updateMoveSpeedText(data["MoveSpeed"])
	updateMultiplierText(data["Multiplier"])
	updateMaxDecorationsText(data["MaxDecorations"])
	updatePickupRangeText(data["PickupRange"])
end

Zap.updateCurrency.On(function(data)
	updateCurrency(data.currentCurrency)
end)
--#endregion

return table.freeze({ update = update })
