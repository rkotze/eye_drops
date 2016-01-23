defmodule EyeDrops.EyeBallTest do
	use ExUnit.Case, async: true
	alias EyeDrops.Commands

	setup do
		{:ok, arg_tasks} = Commands.parse(["--include-tasks", "unit_tests"])
		{:ok, reg_eye} = EyeDrops.EyeBall.open(arg_tasks)
		{:ok, reg_eye: reg_eye}
	end

	test "Eye ball open", %{reg_eye: reg_eye} do
		assert {:ok, tasks} = EyeDrops.EyeBall.look(reg_eye, :tasks)
		assert Enum.at(tasks, 0).id == :unit_tests
	end

end