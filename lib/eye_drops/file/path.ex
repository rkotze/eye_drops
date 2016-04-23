defmodule EyeDrops.File.Path do
  def exists?(path) do
    Enum.count(Path.wildcard(path)) > 0
  end

  def spotted?(changed_file, path_pattern) when is_list(path_pattern) do
    Enum.any?(path_pattern, fn(path) -> 
      String.contains?(changed_file, Path.wildcard(path))
    end)
  end

  def spotted?(changed_file, path_pattern) when is_binary(path_pattern) do
    pattern = case String.contains?(path_pattern, "*") do
      true ->
        Path.wildcard(path_pattern)
      _ ->
        path_pattern
    end

    String.contains?(changed_file, pattern)
  end
  
end