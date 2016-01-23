use Mix.Config

config :eye_drops, 
	tasks: [
		%{
			id: :unit_tests,
			name: "unit tests",
			cmd: "mix test",
			paths: ["lib/*"]
		},
		%{
			id: :acceptance,
			name: "acceptance tests",
			cmd: "mix acceptance",
			paths: ["feature/*"]
		}
	]