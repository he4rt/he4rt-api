use Mix.Config

# Configures Elixir's Logger
config :logger, :console,
  format: "time=$date $time $metadata[$level] $message\n",
  metadata: [:request_id]

# General application configuration
config :he4rt,
  ecto_repos: [He4rt.Repo],
  generators: [integer: true]

# Configures Authentications Plug
config :he4rt, He4rt.Plugs.Authentications,
  is_enabled?: {:system, "KEY_ENABLED"},
  api_key: {:system, "API_KEY"}

import_config "#{Mix.env()}.exs"
