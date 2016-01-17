defmodule EyeDrops.Tasks.Path do
	def exists?(path) do
		Enum.count(Path.wildcard(path)) > 0
	end

	def spotted?(change_file, path_pattern) when is_list(path_pattern) do
		Enum.any?(path_pattern, fn(path) -> 
			String.contains?(change_file, Path.wildcard(path))
		end)
	end

	def spotted?(change_file, path_pattern) when is_binary(path_pattern) do
		cond do
		  String.contains?(path_pattern, "*") ->
		  	pattern = Path.wildcard(path_pattern)
		  true ->
		  	pattern = path_pattern
		end

		String.contains?(change_file, pattern)
	end
end