function movement(x, y, angle, speed, dt)
x = math.cos(angle) * (speed * dt)
y = math.sin(angle) * (speed * dt)
return {x, y}
end