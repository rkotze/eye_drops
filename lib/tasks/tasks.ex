defmodule EyeDrops.Tasks do
	alias EyeDrops.Tasks.Path
	
	def get do
		Application.get_env(:eye_drops, :tasks) |>
		has_tasks
	end

	def get(task_list) when is_list(task_list) do
		get() |>
		Enum.filter(fn task -> 
			task.id in task_list
		end) |>
		has_tasks
	end

	def to_run(tasks, changed_file) do
		Enum.filter(tasks, fn(task) -> 
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

	defp has_tasks(empty_tasks) when empty_tasks == [], do: raise TasksError, message: "No tasks found"

	defp has_tasks(tasks), do: tasks

end