defmodule Mix.Tasks.EyeDrops.Mixfile do
  use Mix.Project

  def project do
    [app: :eye_drops,
     version: "0.0.1",
     elixir: "~> 1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
    test_paths: ["lib"]]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:fs, git: "https://github.com/synrc/fs.git", tag: "1.9"},
      {:mock, "~> 0.1.1", only: :test}
    ]
  end
end
