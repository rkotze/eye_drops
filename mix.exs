defmodule Mix.Tasks.EyeDrops.Mixfile do
  use Mix.Project

  def project do
    [app: :eye_drops,
     version: "0.1.0",
     elixir: "~> 1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     description: description,
     package: package,
     test_paths: ["lib"],
     aliases: aliases]
  end

  def application do
    [applications: [:logger, :fs]]
  end

  defp aliases do
    []
  end

  defp deps do
    [
      {:fs, "~> 0.9.1"}
    ]
  end

   defp description do
    """
    A configurable watch mix tasks
    Watch file changes in a project and run the corresponding command when a change happens.
    """
  end

  defp package do
    [
     files: ["lib", "mix.exs", "README*", "LICENSE*"],
     maintainers: ["Richard Kotze"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/rkotze/eye_drops",
              "Docs" => "https://github.com/rkotze/eye_drops"}]
  end
end
