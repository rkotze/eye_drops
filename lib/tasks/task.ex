defmodule EyeDrops.Task do
	defstruct id: "",
	name: "",
	cmd: "",
	path: "",
	run_on_start: false

	def to_exec(task_id) when is_atom(task_id) do
		task = get(task_id)
		case task do
		  nil ->
		  	{:error, "Task.cmd not found"} 
		  _ ->
		  	{:ok, task}
		end
	end

	def to_exec(_task_id), do: {:error, "task id atom required"}

	def exec({:ok, task}) do
		IO.puts "Running #{task.name}..."
		Mix.Shell.IO.cmd(task.cmd)
		IO.puts "Finished #{task.name}..."	
	end

	def exec({:error, message}), do: IO.puts message

	defp get(task_id) do
		EyeDrops.Tasks.get() |>
		Enum.find(fn(task) -> 
			task.id == task_id
		end)
	end

end