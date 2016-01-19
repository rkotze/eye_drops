defmodule EyeDrops.Tasks do
	alias EyeDrops.Tasks.Path
	
	def get do
		Application.get_env(:eye_drops, :tasks)
	end

	def to_run(changed_file) do
		get() |>
		Enum.filter(fn(task) -> 
			Path.spotted?(changed_file, task.paths)
		end)
	end

	def exec([task|tasks]) do
		IO.puts "Running #{task.name}..."
		Mix.Shell.IO.cmd(task.cmd)
		IO.puts "Finished #{task.name}..."
		exec(tasks)
	end

	def exec([]) do
		:ok
	end

end