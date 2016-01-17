defmodule EyeDrops.TasksTest do
	use ExUnit.Case

	test "Execute task if file has changed" do
		tasks = EyeDrops.Tasks.to_run("some/path/lib/eye_drops.ex")
		assert Enum.at(tasks,0).id == :unit_tests
	end
end