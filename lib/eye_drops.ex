defmodule Mix.Tasks.EyeDrops do
	use Mix.Task
	alias EyeDrops.EyeBall

	def run(args) do
		:ok = Application.start :fs, :permanent
		IO.puts "Eye drops applied"

		{:ok, _} = EyeBall.open(args)
		
		:timer.sleep :infinity
	end

end
