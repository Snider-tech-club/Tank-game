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
tank = {}
tank.__index = tank
function tank:new (params, HC)
	local keys = params.keys
	normal = {damage = 25, health = 50, speed = 50, bounce = 8, reload = 5, imgPath = 'assets/tank sprite.png', bulletPath = 'assets/bullet.png', }
	self = setmetatable(normal, self)
    self.__index = self
    self.keys = keys
    self.img = love.graphics.newImage(self.imgPath)
    self.bullets = {}
    self.canShoot = true
	self.canShootTimerMax = 1.0
	self.canShootTimer = 1.0
	self.bulletImg = love.graphics.newImage(self.bulletPath)
	self.angleAdjustment = -90
	self.angle = 0
	self.x = params.x
	self.y = params.x
--	self.shape = HC.rectangle(self.x,self.y, 18, 27)
    return self
end
function tank:update(dt)
if love.keyboard.isDown('escape') then
		love.event.push('quit')
	end

	if love.keyboard.isDown(self.keys.left) then
		if self.x > 0 then
			self.angle = math.rad(math.deg(self.angle) - (85 * dt))
		end
	elseif love.keyboard.isDown(self.keys.right) then
		if self.x < (love.graphics.getWidth() - self.img:getWidth()) then
			self.angle = math.rad(math.deg(self.angle) + (85 * dt))
		end
    elseif love.keyboard.isDown(self.keys.down) then
		if self.y > 0 then
			local velocityX = math.cos(self.angle) * (self.speed * dt)
			local velocityY = math.sin(self.angle) * (self.speed * dt)
			self.x = self.x - velocityX
			self.y = self.y - velocityY
		end
    elseif love.keyboard.isDown(self.keys.up) then
		if self.y < (love.graphics.getHeight() - self.img:getHeight()) then
			local velocityX = math.cos(self.angle) * (self.speed * dt)
			local velocityY = math.sin(self.angle) * (self.speed * dt)
			self.x = self.x + velocityX
			self.y = self.y + velocityY
		end
	end
		self.canShootTimer = self.canShootTimer - (1 * dt)
	if self.canShootTimer < 0 then
		self.canShoot = true
		self.canShootTimer = self.canShootTimerMax
	end

	for i, bullet in ipairs(self.bullets) do
		bullet.x = bullet.x + math.cos(bullet.angle) * (bullet.speed * dt)
		bullet.y = bullet.y + math.sin(bullet.angle) * (bullet.speed * dt)
		if bullet.y < 0 then
			table.remove(self.bullets, i)
		end
	end
    if love.keyboard.isDown(self.keys.attack) and self.canShoot  then
    	local velocityX = math.cos(self.angle) * (self.speed * dt)
		local velocityY = math.sin(self.angle) * (self.speed * dt)
        local newBullet = { speed = 150, angle = self.angle, x = self.x -2, y = self.y -2, img = self.bulletImg, speed = self.speed +20 }
		table.insert(self.bullets, newBullet)
		self.canShoot = false
		self.CanShootTimer = self.canShootTimerMax

	end
--	self.shape:moveTo(self.x, self.y)
end
	function tank:draw( dt )
		love.graphics.draw(self.img, self.x, self.y, self.angle + math.rad(90), 1, 1, self.img:getWidth()/2, self.img:getHeight()/2)
	for i, bullet in ipairs(self.bullets) do
		love.graphics.draw(bullet.img, bullet.x, bullet.y)
	end
end