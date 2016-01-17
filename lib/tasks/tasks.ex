defmodule EyeDrops.Tasks do
	alias EyeDrops.Tasks.Path
	
	def get do
		Application.get_env(:eye_drops, :tasks)
	end

	def to_run(changed_file) do
		task = get() |>
		Enum.filter(fn(task) -> 
			Path.spotted?(changed_file, task.paths)
		end)
	end

	def exec(task_cmd) do
		Mix.Shell.cmd(task_cmd, [], fn(x) -> IO.write(x) end)
	end
end