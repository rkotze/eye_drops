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
    tasks = Tasks.to_run(to_string(path))
    if tasks do
	    :ok = Tasks.exec(tasks)
      finish
	  end
    {:noreply, state}
  end

  defp finish do
    receive do
      _ -> finish
      after 0 -> :ok
    end
  end 
end