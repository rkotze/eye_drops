# EyeDrops

[![Build Status](https://travis-ci.org/rkotze/eye_drops.svg?branch=master)](https://travis-ci.org/rkotze/eye_drops) 
[![Gitter](https://badges.gitter.im/rkotze/eye_drops.svg)](https://gitter.im/rkotze/eye_drops?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

### A configurable watch mix task

Watch file changes in a project and run the corresponding command when a change happens.

`mix eye_drops` Start watching all configured tasks

## Installation

Add `eye_drops` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:eye_drops, "~> 1.0.0"}]
end
```

## Basic setup

In your config folder, add the following `eye_drops` config into one of your config files.

The example below will run the `mix test` command

```elixir
config :eye_drops, 
  tasks: [
    %{
      id: :unit_tests,
      name: "Unit tests",
      cmd: "mix test",
      paths: ["web/*", "test/*"]
    }
  ]
```

You can setup multiple tasks and it will run one after the other.

## task properties

- `id` unique atom to identify tasks
- `name` provide a name for task
- `cmd` the actual command to run
- `path` is a list. Can be exact, glob pattern or just a folder name

## Optional switches

- `mix eye_drops --include_tasks "unit_tests,acceptance"` provide the id of tasks to watch instead of all

### If using vagrant

This is if you are editing your files outside of the vagrant machine e.g. windows but running commands in vagrant.

The idea is when the task runs it first ssh into your vagrant machine and then executes the command.

`vagrant ssh-config > .ssh-config` - save the ssh-config on your host machine

```elixir
config :eye_drops, 
  tasks: [
    %{
      id: :unit_tests,
      name: "Unit tests",
      cmd: "ssh -F .ssh-config default mix test",
      paths: ["web/*", "test/*"]
    }
  ]
```

Run `mix eye_drops` from outside of vagrant in host terminal where the mix.exs file is located