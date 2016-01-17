defmodule EyeDrops.Tasks do
	def get do
		Application.get_env(:eye_drops, :tasks)
	end
end