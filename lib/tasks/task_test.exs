defmodule EyeDrops.TaskTest do
	use ExUnit.Case
	import Mock
	alias EyeDrops.Task

	test "Find command to run" do
		{status, task} = Task.to_exec(:unit_tests)
		assert status == :ok
		assert task.cmd == "mix test"
	end

	test "Failed to find command to run" do
		assert Task.to_exec(:unit_test) == {:error, "Task.cmd not found"}
	end

	test "Execute task if file has changed" do
		with_mock Mix.Shell, [:passthrough], [cmd: fn(_cmd, _ops, _cb) -> true end] do
			Task.run_on_match("some/path/lib/eye_drops.ex")
			assert called Mix.Shell.cmd("mix test", [], fn(x) -> IO.puts x end)
		end
	end
end