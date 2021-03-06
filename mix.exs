defmodule BudgetApp.Mixfile do
  use Mix.Project

  def project do
    [
      app: :budget_app,
      version: "0.0.1",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test, "coveralls.travis": :test]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {BudgetApp.Application, []},
      extra_applications: [:logger, :runtime_tools, :scrivener_ecto, :timex, :timex_ecto]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.3.0"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.2"},
      {:postgrex, ">= 0.0.0"},
      {:gettext, "~> 0.11"},
      {:cowboy, "~> 1.0"},

      # Ecto pagination
      {:scrivener_ecto, "~> 1.0"},

      # Password hashing
      {:comeonin, "~> 4.0"},
      {:argon2_elixir, "~> 1.2"},

      # Generate random UUIDs or other tokens
      {:secure_random, "~> 0.5"},

      # Time manipulation
      {:timex, "~> 3.0"},
      {:timex_ecto, "~> 3.0"},

      # Convert map keys from strings to atoms
      {:atomic_map, "~> 0.8"},

      # Handle CORS in elixir app
      {:cors_plug, "~> 1.5"},

      # DB factories for test suite
      {:ex_machina, "~> 2.1", only: :test},
      # Code coverage for test suite
      {:excoveralls, "~> 0.8", only: :test},

      # Code linter
      {:credo, "~> 0.9.0-rc3", only: [:dev, :test], runtime: false},

      # Building a release
      {:distillery, "~> 1.5", runtime: false}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "test": ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
