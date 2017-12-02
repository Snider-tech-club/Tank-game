--[[tank:new
params{
Type 0,1,2,3
0: Normal
1: Sniper
2: Laser
3: Heavy
Keys: set  keys for movement
keys is table
}
]]--
function tank:new (params)
	params = params
	setmetatable(params, self)
    self.__index = self
    self.speed = 150
    self.img = love.graphics.newImage('assets/tank sprite.png')
    return params
end
function tank:update(dt)
	if love.keyboard.isDown(self.keys.down) then
		if self.y > 0 then
			self.y = self.y - (self.speed*dt)
		end
end