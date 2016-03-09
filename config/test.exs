use Mix.Config

config :eye_drops, 
	tasks: [
		%{
			id: :unit_tests,
			run_on_start: true,
			name: "unit tests",
			cmd: "mix test",
			paths: ["lib/*"]
		},
		%{
			id: :acceptance,
			run_on_start: true,
			name: "acceptance tests",
			cmd: "mix acceptance",
			paths: ["feature/*"]
		}
	]