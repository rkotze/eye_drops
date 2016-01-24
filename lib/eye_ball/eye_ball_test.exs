defmodule EyeDrops.EyeBallTest do
	use ExUnit.Case, async: false
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

end