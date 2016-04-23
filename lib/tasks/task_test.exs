defmodule EyeDrops.TaskTest do
  use ExUnit.Case, async: false
  alias EyeDrops.Task
  import Mock

  test "Find command to run" do
    {status, task} = Task.to_exec(:unit_tests)
    assert status == :ok
    assert task.cmd == "mix test"
  end

  test "Failed to find command to run" do
    assert Task.to_exec(:unit_test) == {:error, "Task.cmd not found"}
  end

  test "Execute task command" do
    with_mock Mix.Shell.IO, [cmd: fn (_cmd) -> "command" end] do
      Task.exec({:ok, %{name: "test", cmd: "my_command"}})

      assert called Mix.Shell.IO.cmd("my_command")
    end
  end

  test "Try execute task command which does not exist" do
    with_mock IO, [puts: fn (_message) -> "run message" end] do
      Task.exec({:error, "error message"})

      assert called IO.puts("error message")
    end
  end

end