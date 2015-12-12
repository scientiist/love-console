--[[
	LOVE2D In-game console programmed by _j0sh
	Just add "console.update(dt)" to your love.update and "console.draw" to your love.draw
	Press TAB to open console.
]]

-- get UTF8
local utf8 = require("utf8")

require "commands"

-- Set up console
console = {}

console.pos = 200
console.moving = false
console.speed = 600
console.direction = "in"
console.hasFocus = false
console.lastCommandFailed = false
console.displays = {
	"Hello World!",
}
console.currentText = ""

-- Love2d Text input
function love.textinput(t)
	if console.hasFocus == true then
		console.currentText = console.currentText .. t -- add the last textinput to the current text
	end
end

function love.keypressed(key)
	if key == "return" and console.hasFocus == true then
		console.sendCommand(console.currentText) -- if returned then send it
	end

	if key == "backspace" and console.hasFocus == true then
		local byteoffset = utf8.offset(console.currentText, -1)
 
        if byteoffset then
            -- remove the last UTF-8 character.
            -- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
            console.currentText = string.sub(console.currentText, 1, byteoffset - 1)
        end
	end
end

-- sends a message to the console
function console.sendMessage(message)
	table.insert(console.displays, message)
end

-- sends a command to the console

-- this differes from sendMessage because it handles the message
-- before pushing it on to the console
function console.sendCommand(message)
	
	console.currentText = ""
	if message == "" then
		-- nothing happens here cause nothing typed

	else
		console.sendMessage("> "..message)

		local fail = true

		-- only built in command, to allow for executing code on the fly
		if message:sub(1, 4) == "exec" then
			if pcall(function() loadstring(message:sub(5))() end) then
				console.sendMessage("Code executed successfully!")
			else
				console.sendMessage("ERROR: "..message:sub(5).." not valid lua!");
			end

			fail = false
		else

			-- loads custom commands, only problem is, can't use args :(
			for i, v in ipairs(commands) do

				if message == v.command then
					if pcall(function() loadstring(v.execute)() end) then

					else
						console.sendMessage("ERROR: command "..v.command.." is not valid lua!")
					end
					fail = false
				end
			end
		end

		if fail == true then console.sendMessage("ERROR: command not found") end

	end
end

-- a bit of tweening to move the console smoothly
function console.move()
	if console.moving == false then
		console.moving = true
		if console.pos == 0 then
			console.direction = "out"
		elseif console.pos == 200 then
			console.direction = "in"
		end
	end
end


function console.update(dt)

	if #console.displays > 9 then
		table.remove(console.displays, 1)
	end


	if love.keyboard.isDown("tab") then
		console.move()
	end

	if console.moving == true then
		if console.direction == "in" then
			console.pos = console.pos - console.speed * dt
		else
			console.pos = console.pos + console.speed * dt
		end

		if console.pos <= 0 then
			console.pos = 0
			console.moving = false
			console.hasFocus = true
		elseif console.pos >= 200 then
			console.pos = 200
			console.moving = false
			console.hasFocus = false
		end
	end

end

function console.draw()

	-- console box
	love.graphics.setColor(80, 80, 80, 100)
	love.graphics.rectangle("fill", 0, 0-console.pos, love.graphics.getWidth(), 200)

	-- title and debug info
	love.graphics.setColor(255, 255, 255)
	love.graphics.print("_j0sh's console", 5, 5-console.pos)
	love.graphics.print("framerate: " .. love.timer.getFPS(), love.graphics.getWidth()-240, 5-console.pos)
	love.graphics.print("memory(kb): " .. math.ceil(collectgarbage("count")), love.graphics.getWidth()-130, 5-console.pos)

	-- box of messages or already completed commands
	love.graphics.setColor(0,50,255)
	love.graphics.line(0,25-console.pos, love.graphics.getWidth(), 25-console.pos)
	love.graphics.line(0, 180-console.pos, love.graphics.getWidth(), 180-console.pos)

	-- draw the actual text thingies
	for index, message in ipairs(console.displays) do
		love.graphics.setColor(255, 255, 255)
		love.graphics.print(message, 5, ((index*15)+15)-console.pos)
	end

	-- draw the current text
	love.graphics.setColor(255, 255, 255)
	love.graphics.print(console.currentText, 5, 185-console.pos)
end