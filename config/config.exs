use Mix.Config

# Configures Elixir's Logger
config :logger, :console,
  format: "time=$date $time $metadata[$level] $message\n",
  metadata: [:request_id]

# General application configuration
config :he4rt,
  ecto_repos: [He4rt.Repo],
  generators: [integer: true]

# Configures Redis
config :he4rt, He4rt.Services.Redis,
  url: {:system, "REDIS_URL"}

import_config "#{Mix.env()}.exs"
