defmodule He4rt.Application do
  @moduledoc false
  require Logger
  use Application

  import Supervisor.Spec

  alias He4rt.Utils.Environments

  def start(_type, _args), do: Supervisor.start_link(children(), opts())

  defp children(), do: [
    supervisor(He4rt.Repo, []),
    worker(He4rt.Services.Redis, []),
    {Plug.Cowboy, scheme: :http, plug: He4rt.Endpoint, options: get_config()},
  ]

  defp opts(), do: [
    strategy: :one_for_one,
    name: He4rt.Supervisor
  ]

  defp get_config() do
    Logger.info("[#{__MODULE__}] Starting He4rt application")

    with {:ok, config} <- Application.fetch_env(:he4rt, He4rt.Endpoint) do
      port = Environments.get_env(config[:port])
      Logger.info("[#{__MODULE__}] Starting server using port #{port}")
      config
    end
  end
end
