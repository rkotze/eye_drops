defmodule EyeDrops.TaskTest do
	use ExUnit.Case
	alias EyeDrops.Task

	test "Find command to run" do
		{status, task} = Task.to_exec(:unit_tests)
		assert status == :ok
		assert task.cmd == "mix test"
	end

	test "Failed to find command to run" do
		assert Task.to_exec(:unit_test) == {:error, "Task.cmd not found"}
	end

end