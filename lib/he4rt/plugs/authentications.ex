defmodule He4rt.Plugs.Authentications do
  @moduledoc """
  Middleware responsible to authenticate   
  """
  require Logger
  import Plug.Conn
  import He4rt.Views.ErrorView

  alias He4rt.Utils.Environments

  @spec init(keyword()) :: keyword()
  def init(opts) do
    opts
  end

  @doc """
  Validate request if has API Key and if it should be validated
  """
  @spec call(conn :: Plug.Conn.t, keyword()) :: Plug.Conn.t
  def call(%Plug.Conn{} = conn, _opts) do
    case get_config() do
      {:ok, [api_key: api_key, is_enabled?: true]} ->
        conn |> validate_api_key(api_key)

      {:ok, [api_key: _api_key, is_enabled?: false]} ->
        conn

      :error ->
        conn |> send_error({:error, :unauthorized})
    end
  end

  @spec validate_api_key(conn :: Plug.Conn.t, api_key :: String.t) :: Plug.Conn.t
  defp validate_api_key(%Plug.Conn{} = conn, api_key) when is_binary(api_key) do
    conn
    |> get_req_header("api-key")
    |> case do
      [request_api_key] when is_binary(request_api_key) ->
        api_key
        |> Kernel.===(request_api_key)
        |> case do
          true ->
            conn

          false ->
            conn |> send_error({:error, :unauthorized})
        end

      _none ->
        conn |> send_error({:error, :unauthorized})
    end
  end

  @spec get_config() :: {:ok, keyword()} | :error
  def get_config() do
    with {:ok, config} <- Application.fetch_env(:he4rt, __MODULE__) do
      config =
        if Keyword.has_key?(config, :is_enabled?) do
          is_enabled? =
            config
            |> Keyword.get(:is_enabled?)
            |> Environments.get_env()
            |> Kernel.===("TRUE")

          config
          |> Keyword.put(:is_enabled?, is_enabled?)
        else
          config
          |> Keyword.put(:is_enabled?, false)
        end

      config =
        if Keyword.has_key?(config, :api_key) do
          api_key =
            config
            |> Keyword.get(:api_key)
            |> Environments.get_env()

          config
          |> Keyword.put(:api_key, api_key)
        else
          config
          |> Keyword.put(:api_key, Ecto.UUID.generate())
        end
      
      {:ok, config}
    end
  end
end
