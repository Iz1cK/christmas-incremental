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
local playerStats = require(script.Parent.PlayerStats)
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
local buyInterval = statsGui:WaitForChild("BuyInterval") :: TextButton
local buyMoveSpeed = statsGui:WaitForChild("BuyMoveSpeed")
local buyMultiplier = statsGui:WaitForChild("BuyMultiplier") :: TextButton
local buyMaxDecoration = statsGui:WaitForChild("BuyMaxDecoration")
local playerGUI = Players.localPlayer:WaitForChild("PlayerGui")
local currencyGui = playerGUI:WaitForChild("StatsGui")
--#endregion

--#region Function Declerations
local updateCurrency: (currency: number) -> ()
local update: (data: any) -> ()
--#endregion
intervalUpgradeText.Text =
	`Upgrade Interval\n{decorationStats[0].Interval.Upgrade} -> {decorationStats[1].Interval.Upgrade}\n {decorationStats[1].Interval.Cost} Decorations`
playerStats.Interval:Change(decorationStats[0].Interval.Upgrade)

moveSpeedUpgradeText.Text =
	`Upgrade Movespeed\n{decorationStats[0].MoveSpeed.Upgrade} -> {decorationStats[1].MoveSpeed.Upgrade}\n {decorationStats[1].MoveSpeed.Cost} Decorations`
playerStats.MoveSpeed:Change(decorationStats[0].MoveSpeed.Upgrade)

multiplierUpgradeText.Text =
	`Upgrade Multiplier\n{decorationStats[0].Multiplier.Upgrade} -> {decorationStats[1].Multiplier.Upgrade}\n {decorationStats[1].Multiplier.Cost} Decorations`
playerStats.Multiplier:Change(decorationStats[0].Multiplier.Upgrade)

maxDecorationUpgradeText.Text =
	`Upgrade Max Decoration\n{decorationStats[0].MaxDecorations.Upgrade} -> {decorationStats[1].MaxDecorations.Upgrade}\n {decorationStats[1].MaxDecorations.Cost} Decorations`
playerStats.MaxDecorations:Change(decorationStats[0].MaxDecorations.Upgrade)

--#region Functions
updateCurrency = function(currency: number)
	local currencyLabel = currencyGui:WaitForChild("Currency")
	currencyLabel.Text = "Currency: " .. currency
end
local function updateIntervalText(data)
	intervalUpgradeText.Text =
		`Upgrade Interval\n{decorationStats[data.tier].Interval.Upgrade} -> {decorationStats[data.tier + 1].Interval.Upgrade}\n {decorationStats[data.tier + 1].Interval.Cost} Decorations`
	playerStats.Interval:Change(decorationStats[data.tier].Interval.Upgrade)
end

local function updateMoveSpeedText(data)
	moveSpeedUpgradeText.Text =
		`Upgrade Movespeed\n{decorationStats[data.tier].MoveSpeed.Upgrade} -> {decorationStats[data.tier + 1].MoveSpeed.Upgrade}\n {decorationStats[data.tier + 1].MoveSpeed.Cost} Decorations`
	playerStats.MoveSpeed:Change(decorationStats[data.tier].MoveSpeed.Upgrade)
end

local function updateMultiplierText(data)
	multiplierUpgradeText.Text =
		`Upgrade Multiplier\n{decorationStats[data.tier].Multiplier.Upgrade} -> {decorationStats[data.tier + 1].Multiplier.Upgrade}\n {decorationStats[data.tier + 1].Multiplier.Cost} Decorations`
	playerStats.Multiplier:Change(decorationStats[data.tier].Multiplier.Upgrade)
end

local function updateMaxDecorationsText(data)
	maxDecorationUpgradeText.Text =
		`Upgrade MaxDecorations\n{decorationStats[data.tier].MaxDecorations.Upgrade} -> {decorationStats[data.tier + 1].MaxDecorations.Upgrade}\n {decorationStats[data.tier + 1].MaxDecorations.Cost} Decorations`
	playerStats.MaxDecorations:Change(decorationStats[data.tier].MaxDecorations.Upgrade)
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

Zap.updateIntervalText.On(function(data)
	updateCurrency(data.currentCurrency)
	updateIntervalText(data)
end)

Zap.updateMoveSpeedText.On(function(data)
	updateCurrency(data.currentCurrency)
	updateMoveSpeedText(data)
end)

Zap.updateMultiplierText.On(function(data)
	updateCurrency(data.currentCurrency)
	updateMultiplierText(data)
end)

Zap.updateMaxDecorationsText.On(function(data)
	updateCurrency(data.currentCurrency)
	updateMaxDecorationsText(data)
end)

update = function(data: any)
	updateCurrency(data["Currency"])
	updateIntervalText({ tier = data.Interval })
	updateMoveSpeedText({ tier = data.MoveSpeed })
	updateMultiplierText({ tier = data.Multiplier })
	updateMaxDecorationsText({ tier = data.MaxDecorations })
end

Zap.updateCurrency.On(function(data)
	updateCurrency(data.currentCurrency)
end)
--#endregion

return table.freeze({ update = update })
