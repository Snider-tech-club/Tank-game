tanks = {}
require("tanks/tankGenerator")
HC = require 'HC'
function love.load(arg)
	params = {}
	params.keys = {up = "w", down = "s", left = "a", right = "d", attack = "space"}
	params.type = 0
	params.x = 300
	params.y = 300
	table.insert(tanks, tank:new(params,HC))
end

function love.update(dt)
	for i, a_tank in ipairs(tanks) do
		a_tank:update(dt)
	end
end



function love.draw(dt)
	for i, tank in ipairs(tanks) do
		tank:draw(dt)
	end
end

