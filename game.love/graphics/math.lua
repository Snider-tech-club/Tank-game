function movement(x, y, angle, speed, dt)
x = math.cos(angle) * (speed * dt)
y = math.sin(angle) * (speed * dt)
print(y)
return {x, y}
end