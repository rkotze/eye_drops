defmodule EyeDrops.Tasks do
  alias EyeDrops.File.Path
  alias EyeDrops.Task
  
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
    filtered_tasks = Enum.filter(tasks, fn(task) -> 
      Path.spotted?(changed_file, task.paths)
    end)
    cond do
      filtered_tasks == [] -> nil
      true -> tasks
    end
  end

  def exec([task|tasks]) do
    Task.exec({:ok, task})
    exec(tasks) 
  end

  def exec([]) do
    :ok
  end

  def run_on_start(tasks) do
    Enum.filter(tasks, fn(task) ->
      Map.has_key?(task, :run_on_start) && task.run_on_start == true
    end)
  end

  defp has_tasks(nil), do: raise TasksError, message: "No tasks found in #{Mix.env} config"

  defp has_tasks([]), do: raise TasksError, message: "No tasks found"

  defp has_tasks(tasks), do: tasks

end