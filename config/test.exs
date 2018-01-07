use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :budget_app, BudgetAppWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :budget_app, BudgetApp.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("USER"),
  password: "",
  database: "budget_app_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
