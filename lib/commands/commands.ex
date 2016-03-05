defmodule EyeDrops.Commands do
	alias EyeDrops.Task
	alias EyeDrops.Tasks
	@switches [:include_tasks]

	def parse([]), do: {:ok, %{}}
	
	def parse(args) do
		{arg_list, _, _} = OptionParser.parse(args)

		switches = validate_switches!(arg_list)

		include_list = switches[:include_tasks]
		|> String.split(",")
		|> Enum.map(&String.to_atom(&1))

		{:ok, %{:include_tasks => include_list}}
	end

	def watch() do
		task_id = IO.gets ""
		rerun(task_id)
		watch
	end

	def rerun(task_id) do
		case to_atom(task_id) do
			:all ->
				Tasks.get |>
				Tasks.exec
			task_id_atom ->
				Task.to_exec(task_id_atom) |>
				Task.exec
		end
	end

	defp to_atom(task_id) do
		atom_string = String.replace(task_id, ~r/[^a-z_]+/, "")
		atom_string |>
		String.to_atom
	end

	defp validate_switches!(arg_list) do
		Enum.each(arg_list, fn {switch,value} -> 
			if !switch in @switches do
				[argv_switch,_] = OptionParser.to_argv([{switch, value}])
				raise SwitchError, message: "Invalid parameter " <> argv_switch
			end
		end)
		arg_list
	end

end