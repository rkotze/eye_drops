defmodule EyeDrops.EyeBallTest do
  use ExUnit.Case, async: false
  import Mock
  alias EyeDrops.Commands

  test "Eye ball looks at include tasks" do
    {:ok, arg_tasks} = Commands.parse(["--include-tasks", "unit_tests"])
    {:ok, reg_eye} = EyeDrops.EyeBall.open(arg_tasks)
    assert {:ok, tasks} = EyeDrops.EyeBall.look(reg_eye, :tasks)
    assert Enum.at(tasks, 0).id == :unit_tests
    assert Enum.count(tasks) == 1
  end

  test "Eye ball look at tasks all tasks" do
    {:ok, all_seeing} = EyeDrops.EyeBall.open(%{})
    assert {:ok, tasks} = EyeDrops.EyeBall.look(all_seeing, :tasks)
    assert Enum.count(tasks) == 2
  end

  test "Eye ball run tasks on start of eye drops" do
    with_mock EyeDrops.Tasks, [:passthrough], [
      exec: fn (_tasks) -> :ok end] 
      do
        {:ok, all_tasks} = EyeDrops.EyeBall.open(%{})
        EyeDrops.EyeBall.run_on_start(all_tasks)

        assert called EyeDrops.Tasks.exec(:_)
      end
  end

end