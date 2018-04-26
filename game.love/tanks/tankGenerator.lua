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
require('graphics/math')
tank = {}
tank.__index = tank
function tank:new (params, HC)
	local keys = params.keys
	normal = {damage = 25, health = 50, speed = 50, bounce = 8, reload = 5, imgPath = 'assets/tank sprite.png', bulletPath = 'assets/bullet.png', dead = false}
	self = setmetatable(normal, self)
    self.__index = self
    self.keys = keys
    self.img = love.graphics.newImage(self.imgPath)
    self.bullets = {}
    self.canShoot = true
	self.canShootTimerMax = .6
	self.canShootTimer = .6
	self.bulletImg = love.graphics.newImage(self.bulletPath)
	self.angleAdjustment = -90
	self.angle = 0
	self.shape = HC.rectangle(params.x-18,params.y -27, 18, 27)
    return self
end
function tank:update(dt,HC)
if love.keyboard.isDown('escape') then
		love.event.push('quit')
	end
	self.x, self.y = self.shape:center()
	    if love.keyboard.isDown(self.keys.down) then
		if self.y > 0 then
			local velocityChanges = movement(self.x, self.y, self.shape:rotation(), self.speed, dt)
			self.shape:move(-1* velocityChanges[1],-1* velocityChanges[2])
		end
    elseif love.keyboard.isDown(self.keys.up) then
		if self.y < (love.graphics.getHeight() - self.img:getHeight()) then
			local velocityChanges = movement(self.x, self.y, self.shape:rotation(), self.speed, dt)
			self.shape:move(velocityChanges[1], velocityChanges[2])
		end
	elseif love.keyboard.isDown(self.keys.left) then
		if self.x > 0 then
			self.shape:rotate(-1 *math.rad(85 * dt))
		end
	elseif love.keyboard.isDown(self.keys.right) then
		if self.x < (love.graphics.getWidth() - self.img:getWidth()) then
			self.shape:rotate(math.rad(85 * dt))
		end
	end
		self.canShootTimer = self.canShootTimer - (1 * dt)
	if self.canShootTimer < 0 then
		self.canShoot = true
		self.canShootTimer = self.canShootTimerMax
	end

	for i, bullet in ipairs(self.bullets) do
			local velocityChanges = movement(bullet.x, bullet.y, bullet.shape:rotation(), bullet.speed, dt)
			bullet.shape:move(velocityChanges[1], velocityChanges[2])
		if bullet.y < 0 then
			table.remove(self.bullets, i)
		end
	end
    if love.keyboard.isDown(self.keys.attack) and self.canShoot  then

        local newBullet = { speed = 150, angle = self.shape:rotation(), x = self.x  , y = self.y, img = self.bulletImg, speed = self.speed +20, damage = self.damage }
        newBullet.shape = HC.circle(newBullet.x, newBullet.y, 5)
        newBullet.shape:setRotation(newBullet.angle)
		table.insert(self.bullets, newBullet)
		self.canShoot = false
		self.CanShootTimer = self.canShootTimerMax

	end
end
function tank:draw( dt )
		self.x, self.y = self.shape:center()
		love.graphics.draw(self.img, self.x, self.y, self.shape:rotation() + math.rad(90), 1, 1, self.img:getWidth()/2, self.img:getHeight()/2)
	for i, bullet in ipairs(self.bullets) do
		bullet.x, bullet.y = bullet.shape:center()
		love.graphics.draw(bullet.img, bullet.x, bullet.y)
	end
end
function tank:takeDamage(amount)
	print(self)
	self.health = self.health - amount
	if self.health <= 0 then
		self:destory()
	end
end
function tank:destory()
	print("destoried")
	self.dead = true
end