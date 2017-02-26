defmodule Mix.Tasks.EyeDrops.Mixfile do
  use Mix.Project

  def project do
    [app: :eye_drops,
     version: "1.2.1",
     elixir: "~> 1.3",
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
    [ci: ci_mix,
    acceptance: [&accept/1]]
  end

  def accept(_) do
    Mix.shell.info "****** FAKE ACCEPTANCE RAN ******"
  end

  defp deps do
    [
      {:fs, "~> 0.9.1"},
      {:mock, "~> 0.2.1", only: :test},
      {:credo, "~> 0.6.1", only: [:dev, :test]}
    ]
  end

  defp description do
    """
    A configurable mix task to watch file changes
    Watch file changes in a project and run the corresponding command when a change happens.
    """
  end

  defp package do
    [
     files: ["lib/**/*ex", "mix.exs", "README*", "LICENSE*"],
     maintainers: ["Richard Kotze"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/rkotze/eye_drops",
              "Docs" => "https://github.com/rkotze/eye_drops/blob/master/README.md"}]
  end

  defp ci_mix() do
    [
      "credo -a",
      "test"
    ]
  end

end
