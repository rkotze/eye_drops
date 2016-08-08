defmodule EyeDrops.EyeBall do
  use GenServer
  alias EyeDrops.Tasks

  # External api
  def open(tasks) do
    GenServer.start_link(__MODULE__, tasks, name: __MODULE__)
  end

  def look(server, key) do
    GenServer.call(server, {:lookup, key})
  end

  def run_on_start(server) do
    GenServer.call(server, :run_on_start)
  end

  def track_store(server, store) do
    GenServer.call(server, {:track, store})
  end

  # GenServer implementation
  def init(tasks) do
    :ok = :fs.subscribe
    include_list = Map.get(tasks, :include_tasks, [])
    
    eye_tasks = case include_list do
      list when list == [] -> Tasks.get
      list -> Tasks.get(list)
    end
    {:ok, %{tasks: eye_tasks}}
  end

  def handle_info({_pid, {:fs, :file_event}, {path, _event}}, state) do
    tasks = Tasks.to_run(state.tasks, to_string(path))
    if tasks do
      :ok = Tasks.exec(tasks)
    end

    {:noreply, state}
  end

  def handle_call({:lookup, name}, _from, state) do
    {:reply, Map.fetch(state, name), state}
  end

  def handle_call(:run_on_start, _from, state) do
    tasks = Tasks.run_on_start(state.tasks)
    :ok = Tasks.exec(tasks)
    {:reply, state, state}
  end

  def handle_call({:track, store}, _from, state) do
    new_state = Map.put(state, :track, [store])
    {:reply, new_state, new_state}
  end

end