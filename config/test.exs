use Mix.Config

# Logger
config :logger, level: :info

# Configures application
config :he4rt, He4rt.Endpoint,
  port: 4000

# Configure test watch
config :mix_test_watch,
  clear: true
