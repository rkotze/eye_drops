defmodule EyeDrops.EyeBall do
 	use GenServer
 	alias EyeDrops.Tasks

 	# External api
 	def open() do
 		GenServer.start_link( __MODULE__, "", name: __MODULE__ )
 	end

 	# GenServer implementation
 	def init(_args) do
    :ok = :fs.subscribe
    {:ok, %{ }}
  end

 	def handle_info({_pid, {:fs, :file_event}, {path, _event}}, state) do
    task = Tasks.to_run(to_string(path)) |>
    Enum.at(0)
    if task do
	    IO.puts "Running #{task.name}..."
	    Tasks.exec(task.cmd)
	  end
    # IO.inspect(state)
    {:noreply, state}
  end
end