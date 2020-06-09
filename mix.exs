defmodule He4rt.MixProject do
  use Mix.Project

  @url "https://github.com/he4rt/he4rt-api"

  def project, do: [
    app: :he4rt,
    version: "1.0.0",
    elixir: "~> 1.8",
    elixirc_paths: elixirc_paths(Mix.env()),
    start_permanent: Mix.env() == :prod,
    deps: deps(),
    aliases: aliases(),
    name: "He4rt API",
    homepage_url: "https://heartdevs.com",
    source_url: @url,
  ]

  def elixirc_paths(:test), do: ["lib", "test/support"]
  def elixirc_paths(_env), do: ["lib"]

  def application, do: [
    extra_applications: [:logger, :cowboy],
    mod: {He4rt.Application, []}
  ]

  defp deps, do: [
    # Encoders
    {:poison, "~> 4.0", override: true},

    # RESTFul
    {:plug, "~> 1.8"},
    {:cowboy, "~> 2.6"},
    {:plug_cowboy, "~> 2.0"},

    # Database
    {:myxql, "~> 0.3.0"},
    {:ecto, "~> 3.1"},
    {:ecto_sql, "~> 3.1"},
    {:redix, "~> 0.10.4"},

    # Compiler
    {:distillery, "~> 2.1"},

    # Validators
    {:brcpfcnpj, "~> 0.2.0"},

    # Only for tests
    {:faker, "~> 0.13", only: :test},
    {:mix_test_watch, "~> 1.0", only: :test, runtime: false},
  ]

  def aliases, do: [
    setup: ["ecto.drop --quiet", "ecto.create --quiet", "ecto.migrate --quiet", "run priv/repo/seeds.exs"]
  ]
end
