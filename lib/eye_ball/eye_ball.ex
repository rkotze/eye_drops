defmodule EyeDrops.EyeBall do
 	use GenServer
 	alias EyeDrops.Tasks.Path
 	alias EyeDrops.Task

 	# External api
 	def open() do
 		GenServer.start_link( __MODULE__, "", name: __MODULE__ )
 	end

 	defp exec(task) do
 		Mix.Shell.cmd(task.cmd, [], fn(x) -> IO.puts x end)
 	end

 	# GenServer implementation
 	def init(_args) do
    :ok = :fs.subscribe
    {:ok, %{ }}
  end

 	def handle_info({_pid, {:fs, :file_event}, {path, _event}}, state) do
    to_string(path)
    IO.inspect(state)
    {:noreply, state}
  end
end