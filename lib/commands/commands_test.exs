defmodule EyeDrops.CommandsTest do
  use ExUnit.Case
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

end