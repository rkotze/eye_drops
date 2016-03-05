defmodule Mix.Tasks.EyeDrops do
	use Mix.Task
	alias EyeDrops.EyeBall
	alias EyeDrops.Commands

	def run(args) do
		:ok = Application.start :fs, :permanent
		IO.puts "Eye drops applied"

		{:ok, switches} = Commands.parse(args)
		{:ok, _} = EyeBall.open(switches)

		Commands.watch
	end

end
