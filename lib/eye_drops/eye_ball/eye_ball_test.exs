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

  test "Eye ball store time, file changes and task to run" do
    track = {
      :calendar.local_time,
      "here/lib/eye_drops",
      [%{
        id: :unit_tests,
        run_on_start: true,
        name: "unit tests",
        cmd: "mix test",
        paths: ["lib/*"]
      }]
    }

    {:ok, all_seeing} = EyeDrops.EyeBall.open(%{})
    EyeDrops.EyeBall.track_store(all_seeing, track);
    assert {:ok, changes} = EyeDrops.EyeBall.look(all_seeing, :track)
    assert Enum.at(changes,0) == track
  end

end