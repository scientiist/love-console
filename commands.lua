commands = {
	{
		command = "clear",
		execute = function(args)
			console.displays = {}
		end,
	},

	{
		command = "stop",
		execute = function(args)
			os.exit()
		end,
	},
	{
		command = "help",
		execute = function(args)
			console.displays = {
				"_j0sh's console is intended to be used for testing and debugging during game development.",
				"This module is completely free to use in any way or form, but credit is appreciated.",
				"You can add custom commands in the \"commands.lua\" file."
			}
		end,
	},
	-- here is an example command.
	-- make sure your formatting is correct
	{
		command = "yourcommandhere",
		execute = function(args)
			--You may put any valid Lua in here.
			--By the way, you can work with arguments via the args[<int>] variable.

			-- For the first argument a user types: if args[1] == "abc" then ...
			print(args[1])
		end,
	},
	{
		command = "echo",
		execute = function(args)

			local str = ""
			for i = 1, #args do
				str = str..args[i]
			end

			table.insert(console.displays, str)
		end,
	},
}