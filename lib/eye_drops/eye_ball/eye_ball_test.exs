defmodule EyeDrops.EyeBallTest do
  use ExUnit.Case, async: false
  import Mock
  alias EyeDrops.Commands

  test "Eye ball looks at include tasks" do
    {:ok, arg_tasks} = Commands.parse(["--include-tasks", "unit_tests"])
    {:ok, pid} = EyeDrops.EyeBall.open(arg_tasks)
    assert {:ok, tasks} = EyeDrops.EyeBall.look(pid, :tasks)
    assert Enum.at(tasks, 0).id == :unit_tests
    assert Enum.count(tasks) == 1
  end

  test "Eye ball look at tasks all tasks" do
    {:ok, pid} = EyeDrops.EyeBall.open(%{})
    assert {:ok, tasks} = EyeDrops.EyeBall.look(pid, :tasks)
    assert Enum.count(tasks) == 2
  end

  test_with_mock "Eye ball handle_info is run with no tasks", EyeDrops.Tasks, [:passthrough], [
    exec: fn ([]) -> :ok end]
  do
    {:ok, pid} = EyeDrops.EyeBall.open(%{})
    message = {pid, {:fs, :file_event}, {"path/does/not/exist.ex", "event"}}
    send(pid, message)
    :timer.sleep(50) # hack to wait for send message
    assert called EyeDrops.Tasks.exec([])
  end

  test_with_mock "Eye ball run tasks on start of eye drops", EyeDrops.Tasks, [:passthrough], [
    exec: fn (_tasks) -> :ok end] 
  do
    {:ok, all_tasks} = EyeDrops.EyeBall.open(%{})
    EyeDrops.EyeBall.run_on_start(all_tasks)

    assert called EyeDrops.Tasks.exec(:_)
  end
end