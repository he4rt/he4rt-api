use Mix.Config

# Logger
config :logger, level: :info

# Configures application
config :he4rt, He4rt.Endpoint,
  port: 4000

# Configure your database
config :he4rt, He4rt.Repo,
  timeout: 99_999_999,
  pool: Ecto.Adapters.SQL.Sandbox

# Configure test watch
config :mix_test_watch,
  clear: true
