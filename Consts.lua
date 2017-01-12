local Consts = {
	maximumVelocity = 20,
	minimumVelocity = 0,
	velocityCutoff = {
		x = 1e-30,
		y = 1e-30
	},
	defaultStep = 1,
	window = {
		width = 800,
		height = 600,
		title = "NEW GAME",
		properties = {
			fullscreen = false,
			resizable = false,
			borderless = false,
			centered = true,
			display = 1,
			x = nil,
			y = nil
		}
	}
}

return Consts