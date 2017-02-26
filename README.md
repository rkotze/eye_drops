# EyeDrops

[![Build Status](https://travis-ci.org/rkotze/eye_drops.svg?branch=master)](https://travis-ci.org/rkotze/eye_drops) 
[![Gitter](https://badges.gitter.im/rkotze/eye_drops.svg)](https://gitter.im/rkotze/eye_drops?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)
[![Hex pm](https://img.shields.io/hexpm/v/eye_drops.svg?style=flat)](https://hex.pm/packages/eye_drops)

### A configurable Elixir mix watch task

`mix eye_drops` Start watching all configured tasks ... [more options](#optional-switches)

### Description

Watch file changes in a project and run the corresponding command when a matching file change happens.

The reason for this is when code changes are made you typically want to run unit and acceptance tests. So while you make changes you can configure this mix tasks to auto run and help get feed back quicker.

* [Installation](#installation)
* [Basic setup](#basic-setup)
* [Optional switches](#optional-switches)
* [While running](#commands-while-running-eye_drops)
* [Contribute](#contribute)
* [Using vagrant](#using-vagrant)

## Installation

Add `eye_drops` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:eye_drops, "~> 1.3"}]
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
      run_on_start: true,
      cmd: "mix test",
      paths: ["web/*", "test/*"]
    },
    %{
      id: :acceptance,
      name: "Acceptance tests",
      cmd: "mix acceptance",
      paths: ["web/*", "features/*"]
    }
  ]
```

You can setup multiple tasks and it will run one after the other.

### Task config properties

- `id` unique atom to identify tasks
- `name` provide a name for task
- `run_on_start` default is false. When EyeDrops starts, tasks with this set to true will run as well  
- `cmd` the actual command to run
- `path` is a list. Can be exact, glob pattern or just a folder name

### Commands while running eye_drops

When EyeDrops has started you can run all or a specific task without needing to stop or change a file

- `all` this will run all your tasks
- `task_id` run a specific task from your EyeDrops config

## Optional switches

- `mix eye_drops --include-tasks "unit_tests,acceptance"` provide the id of tasks to watch instead of all

## Using vagrant

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

## Contribute

1. [Create issue](http://github.com/rkotze/eye_drops/issues)
2. [Fork it!](http://github.com/rkotze/eye_drops/fork)
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
