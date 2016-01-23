defmodule EyeDrops.EyeBall do
 	use GenServer
 	alias EyeDrops.Tasks

 	# External api
 	def open(tasks) do
 		GenServer.start_link( __MODULE__, tasks, name: __MODULE__ )
 	end

  def look(server, key) do
    GenServer.call(server, {:lookup, key})
  end

 	# GenServer implementation
 	def init(tasks) do
    :ok = :fs.subscribe
    include_list = Map.get(tasks, :include_tasks, [])
    tasks = Tasks.get(include_list)
    {:ok, %{ tasks: tasks }}
  end

 	def handle_info({_pid, {:fs, :file_event}, {path, _event}}, state) do
    tasks = Tasks.to_run(state.tasks, to_string(path))
    if tasks do
	    :ok = Tasks.exec(tasks)
      finish
	  end
    {:noreply, state}
  end

  def handle_call({:lookup, name}, _from, state) do
    {:reply, Map.fetch(state.tasks, name), state}
  end

  defp finish do
    receive do
      _ -> finish
      after 0 -> :ok
    end
  end 
end