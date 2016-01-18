# EyeDrops

A configurable watch mix task.

Watch a list of directories for any file changes and run a task when a change happens.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add eye_drops to your list of dependencies in `mix.exs`:

        def deps do
          [{:eye_drops, "~> 0.0.1"}]
        end

  2. Ensure eye_drops is started before your application:

        def application do
          [applications: [:eye_drops]]
        end
