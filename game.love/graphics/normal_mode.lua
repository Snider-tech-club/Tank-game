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
		a_tank:update(dt,HC)
		for shape, delta in pairs(HC.collisions(a_tank.shape)) do
			for b, colliding_tank in ipairs(tanks) do
		    	if  i ~= b then
		    		print(colliding_tank.bullets[1])
		    		for i, bullet in ipairs(colliding_tanks.bullets) do
		    			local collides, dx, dy = bullet.shape:collidesWith(a_tank.shape)
					if collides then
		    				print("Tank Destoryed")
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

