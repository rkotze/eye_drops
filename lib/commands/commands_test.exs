defmodule EyeDrops.CommandsTest do
  use ExUnit.Case
  import Mock
  alias EyeDrops.Commands

  test "Get specified task to watch" do
  	result = Commands.parse(["--include-tasks", "unit_tests"])
    assert result == {:ok, %{include_tasks: [:unit_tests] }}
  end

  test "Get specified comma separated list of tasks to watch" do
    result = Commands.parse(["--include-tasks", "unit_tests,acceptance,integration"])
    assert result == {:ok, %{include_tasks: [:unit_tests, :acceptance, :integration]}}
  end

  test "Use of invalid switch" do
    assert_raise SwitchError, "Invalid parameter --not-valid", fn -> 
      Commands.parse(["--not-valid", "unit_tests"])
    end
  end

  test "No switches passed" do
    result = Commands.parse([])
    assert result == {:ok, %{}}
  end

  test "rerun all tasks" do
    with_mock EyeDrops.Tasks, [
      get: fn -> ["tasks", "list"] end,
      exec: fn (_tasks) -> "run tasks" end] 
      do
        Commands.rerun("all")

        assert called EyeDrops.Tasks.get
        assert called EyeDrops.Tasks.exec(["tasks", "list"])
    end
  end

  test "rerun specific task by task_id :unit_tests" do
    with_mock EyeDrops.Task, [
      to_exec: fn (_task_id_atom) -> {:ok, "task"} end,
      exec: fn (_tasks) -> "run task" end] 
      do
        Commands.rerun("unit_tests")

        assert called EyeDrops.Task.to_exec(:unit_tests)
        assert called EyeDrops.Task.exec({:ok, "task"})
    end
  end

end