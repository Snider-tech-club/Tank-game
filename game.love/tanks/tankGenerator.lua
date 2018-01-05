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
	local types = {{damage: 25, health: 50, speed: 25, bounce: 8, reload: 5, imgPath: 'assets/tank sprite.png', bulletPath: 'assets/bullet.png'}
	setmetatable(types[params.type +1], self)
    self.__index = self
    self.keys = params.keys
    self.img = love.graphics.newImage(self.imgPath)
    return params
end
function tank:update(dt)
	if love.keyboard.isDown(self.keys.down) then
		if self.y > 0 then
			self.y = self.y - (self.speed*dt)
		end
end