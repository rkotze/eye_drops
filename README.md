# EyeDrops

[![Join the chat at https://gitter.im/rkotze/eye_drops](https://badges.gitter.im/rkotze/eye_drops.svg)](https://gitter.im/rkotze/eye_drops?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

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
