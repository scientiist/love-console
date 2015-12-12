function love.load()
	require "console"
	bgcolors = {0, 0, 0}
end

function love.update(dt)
	console.update(dt)
end

function love.draw()
	love.graphics.setColor(bgcolors)
	love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
	console.draw()
end