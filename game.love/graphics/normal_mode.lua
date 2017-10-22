player = { x = 200, y = 200, speed = 150, img = nil }
canShoot = true
canShootTimerMax = 0.2
canShootTimer = canShootTimerMax
bulletImg = nil

bullets = {}
function love.draw(dt)

end

function love.load(arg)
player.img = love.graphics.newImage('assets/tank sprite.png')
bulletImg = love.graphics.newImage('assets/bullet.png')
end

function love.update(dt)
if love.keyboard.isDown('escape') then
		love.event.push('quit')
	end

	if love.keyboard.isDown('left','a') then
		if player.x > 0 then
		player.x = player.x - (player.speed*dt)
	end
	elseif love.keyboard.isDown('right','d') then
		if player.x < (love.graphics.getWidth() - player.img:getWidth()) then
		player.x = player.x + (player.speed*dt)
	end
    elseif love.keyboard.isDown('down','w') then
		if player.y > 0 then
		player.y = player.y - (player.speed*dt)
	end
    elseif love.keyboard.isDown('up','s') then
		if player.y < (love.graphics.getHeight() - player.img:getHeight()) then
		player.y = player.y + (player.speed*dt)
	end
    elseif love.keyboard.isDown('space') and canShoot then
        newBullet = { x = player.x + (player.img:getWidth()/2), y = player.y, img = bulletImg }
	table.insert(bullets, newBullet)
	canShoot = true
	CanShootTimer = canShootTimerMax
	end
	canShootTimer = canShootTimer - (1 * dt)
if canShootTimer < 0 then
	canShoot = true
end
for i, bullet in ipairs(bullets) do
	bullet.y = bullet.y - (250 * dt)

	if bullet.y < 0 then
		table.remove(bullets, i)
	end
end
end



function love.draw(dt)
	love.graphics.draw(player.img, player.x, player.y)

for i, bullet in ipairs(bullets) do
	love.graphics.draw(bullet.img, bullet.x, bullet.y)
end
end