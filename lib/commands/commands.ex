defmodule EyeDrops.Commands do
	@switches [:include_tasks]

	def parse([]), do: {:ok, %{}}
	
  def parse(args) do
    {arg_list, _, _} = OptionParser.parse(args)

    switches = validate_switches!(arg_list)

    include_list = switches[:include_tasks]
    |> String.split(",")
    |> Enum.map(&String.to_atom(&1))

    {:ok, %{:include_tasks => include_list}}
  end

  defp validate_switches!(arg_list) do
  	Enum.each(arg_list, fn {switch,value} -> 
  		if !switch in @switches do
  			[argv_switch,_] = OptionParser.to_argv([{switch, value}])
  			raise SwitchError, message: "Invalid parameter " <> argv_switch
  		end
  	end)
  	arg_list
  end

end