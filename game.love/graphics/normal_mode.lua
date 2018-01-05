player = { x = 200, y = 200, speed = 150, angle = math.rad(0), img = nil }
canShoot = true
canShootTimerMax = 0.8
canShootTimer = canShootTimerMax
bulletImg = nil
angleAdjustment = -90

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

	if love.keyboard.isDown('a') then
		if player.x > 0 then
			player.angle = math.rad(math.deg(player.angle) - (50 * dt))
		end
	elseif love.keyboard.isDown('d') then
		if player.x < (love.graphics.getWidth() - player.img:getWidth()) then
			player.angle = math.rad(math.deg(player.angle) + (50 * dt))
		end
    elseif love.keyboard.isDown('down','w') then
		if player.y > 0 then
			local velocityX = math.cos(player.angle) * (player.speed * dt);
			local velocityY = math.sin(player.angle) * (player.speed * dt)
			player.rotation = angle;
			player.x = player.x + velocityX;
			player.y = player.y + velocityY;
		end
    elseif love.keyboard.isDown('up','s') then
		if player.y < (love.graphics.getHeight() - player.img:getHeight()) then
			local velocityX = math.cos(player.angle) * (player.speed * dt);
			local velocityY = math.sin(player.angle) * (player.speed * dt)
			player.rotation = angle;
			player.x = player.x + velocityX;
			player.y = player.y + velocityY;
	end
    elseif love.keyboard.isDown('space') and canShoot then
        newBullet = { x = player.x, y = player.y, img = bulletImg }
		table.insert(bullets, newBullet)
		canShoot = false
		canShootTimer = canShootTimerMax
	end
	canShootTimer = canShootTimer - (1 * dt)
	if canShootTimer <= 0 then
		canShoot = true
		canShootTimer = 0
	end
for i, bullet in ipairs(bullets) do
	bullet.y = bullet.y - (250 * dt)

	if bullet.y < 0 then
		table.remove(bullets, i)
	end
end
end



function love.draw(dt)
	love.graphics.draw(player.img, player.x, player.y, player.angle + math.rad(90), 1, 1, player.img:getWidth()/2, player.img:getHeight()/2)
	love.graphics.print(math.deg(player.angle), 0, 0)
for i, bullet in ipairs(bullets) do
	love.graphics.draw(bullet.img, bullet.x, bullet.y)
end
end
