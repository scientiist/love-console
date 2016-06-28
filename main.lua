function love.load()
	require "console"

	colorR = 5
	colorG = 128
	colorB = 255
	goingR = true
	goingG = true
	goingB = true
	bgcolors = {colorR, colorG, colorB}
	love.window.setMode(800, 600, {resizable=true, vsync=false, minwidth=350, minheight=200})
	love.window.setTitle("||| _j0sh's console |||")
end

function love.update(dt)
	
	if goingR == true then
		colorR = colorR + 0.1 + dt
	elseif goingR == false then
		colorR = colorR - 0.2 + dt
	end

	if colorR >= 255 then
		goingR = false
	elseif colorR <= 0 then
		goingR = true
	end

	if goingG == true then
		colorG = colorG + 0.2 + dt
	elseif goingR == false then
		colorG = colorG - 0.1 + dt
	end

	if colorG >= 255 then
		goingG = false
	elseif colorG <= 0 then
		goingG = true
	end

	if goingB == true then
		colorB = colorB + 0.1 + dt
	elseif goingB == false then
		colorB = colorB - 0.3 + dt
	end

	if colorB >= 255 then
		goingB = false
	elseif colorB <= 0 then
		goingB = true
	end


	bgcolors = {colorR, colorG, colorB}
	console.update(dt)
end

function love.draw()
	love.graphics.setColor(bgcolors)
	love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
	console.draw()
end