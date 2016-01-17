defmodule Mix.Tasks.EyeDrops do
	use Mix.Task
	alias EyeDrops.EyeBall

	def run(args) do
		:ok = Application.start :fs, :permanent
		IO.puts "Eye spy with my little eye..."

		{:ok, _} = EyeBall.open()
		
		:timer.sleep :infinity
	end

end
