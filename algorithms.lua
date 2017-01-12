local Algorithms = {}
Algorithms.Collision = {}


function Algorithms.Collision.is_colliding_rectangles(reactA, reactB)
	
	local function getMinMax(react)
		return 	{x = {min = math.min(react.upper.x, react.lower.x), max = math.max(react.upper.x, react.lower.x)},
				 y = {min = math.min(react.upper.y, react.lower.y), max = math.max(react.upper.y, react.lower.y)}} 
	end

	local reactA_minmax = getMinMax(reactA)
	local reactB_minmax = getMinMax(reactB)


	local is_within_x_range = (
		reactB_minmax.x.min <= reactA_minmax.x.min and reactA_minmax.x.min <= reactB_minmax.x.max or 
		reactB_minmax.x.min <= reactA_minmax.x.max and reactA_minmax.x.max <= reactB_minmax.x.max
	)

	local is_within_y_range = (
		reactB_minmax.y.min <= reactA_minmax.y.min and reactA_minmax.y.min <= reactB_minmax.y.max or 
		reactB_minmax.y.min <= reactA_minmax.y.max and reactA_minmax.y.max <= reactB_minmax.y.max
	) 

	return is_within_x_range and is_within_y_range
end

return Algorithms
