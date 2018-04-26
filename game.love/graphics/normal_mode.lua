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
	params = {}
	params.keys = {up = "up", down = "down", left = "left", right = "right", attack = "x"}
	params.type = 0
	params.x = 400
	params.y = 400
	table.insert(tanks, tank:new(params,HC))
end

function love.update(dt)
	for i, a_tank in ipairs(tanks) do
		if a_tank.dead then
			table.remove(tanks,i)
		else
			a_tank:update(dt,HC)
			for shape, delta in pairs(HC.collisions(a_tank.shape)) do
				for b, colliding_tanks in ipairs(tanks) do
		    		if  i ~= b then
		    			for i, bulletx in ipairs(colliding_tanks.bullets) do
		    				if bulletx.shape:collidesWith(a_tank.shape) then
		    					a_tank:takeDamage(bulletx.damage)
		    				end
        				end
        			end
    			end
    		end
		end
	end
end


function love.draw(dt)
	for i, tank in ipairs(tanks) do
		tank:draw(dt)
	end
end

