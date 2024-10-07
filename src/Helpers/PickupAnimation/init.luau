--!native
--!optimize 2
--!strict
--#region Services
--#endregion

--#region Packages

--#endregion

--#region Features
--#endregion

--#region Data
export type ConfigType = {
	part: Part,
	parentGui: PlayerGui,
	pickupSize: number,
	image: string,
	endSize: UDim2,
	endPos: UDim2,
	easingDirection: Enum.EasingDirection,
	easingStyle: Enum.EasingStyle,
	duration: number,
}
--#endregion

--#region Types
--#endregion

--#region Variables
local camera = workspace.CurrentCamera
--#endregion

--#region Function Declerations
local executeAnimation: (config: ConfigType) -> ()
--#endregion

--#region Functions
executeAnimation = function(config: ConfigType)
	local pos2d, inCam = camera:WorldToScreenPoint(config.part.Position)
	local pos2dScreen = Vector3.new(pos2d.X, pos2d.Y)
	if inCam then
		local imageLabel = Instance.new("ImageLabel")
		imageLabel.Size = UDim2.new(0, config.pickupSize * 1 / pos2d.Z, 0, config.pickupSize * 1 / pos2d.Z)
		imageLabel.Position = UDim2.new(0, pos2dScreen.X, 0, pos2dScreen.Y)
		imageLabel.Image = config.image
		imageLabel.BackgroundTransparency = 1

		imageLabel.Parent = config.parentGui
		imageLabel:TweenSizeAndPosition(
			config.endSize,
			config.endPos,
			config.easingDirection,
			config.easingStyle,
			config.duration,
			true,
			function()
				imageLabel:Destroy()
			end
		)
	end
end
--#endregion

return table.freeze({ executeAnimation = executeAnimation })
