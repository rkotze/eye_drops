use Mix.Config

config :eye_drops, 
  tasks: [
    %{
      id: :unit_tests,
      run_on_start: true,
      name: "unit tests",
      cmd: "mix test",
      paths: ["E:/projects/eye_drops/lib/*"]
    }
  ]