defmodule He4rt.Services.Redis do
  @moduledoc """
  GenServer responsible to connect to Redis server using Redix dependency
  """
  require Logger

  alias He4rt.Utils.Environments

  @name :redis
  @possible_commands ~w(set get expire del ping)a

  @typedoc """
  Redix custom types
  """
  @type command :: :set | :get | :expire | :del | :ping
  @type instruction :: {String.t} | {String.t, String.t} | {String.t, String.t, String.t}

  @doc """
  Starts the GenServer
  """
  @spec start_link() :: any
  def start_link(), do: get_options() |> Redix.start_link(name: @name)

  @doc """
  Starts the GenServer with options
  """
  @spec start_link(options :: list(atom)) :: any
  def start_link(options), do: options |> Redix.start_link()

  @doc """
  Check connection
  """
  @spec is_connected?() :: :ok | {:error, term}
  def is_connected?() do
    parameters = mount_request(:ping)

    case execute(parameters) do
      {:ok, "PONG"} ->
        :ok

      {:error, reason} ->
        Logger.error("[#{__MODULE__}] Something goes wrong when trying to ping Redis. Reason: #{inspect reason}")
        {:error, reason}
    end
  end

  @doc """
  Add new key-value pair inside Redis
  """
  @spec add(key :: atom | String.t, value :: any) :: :ok | {:error, term}
  def add(key, value) do
    parameters = mount_request(:set, key, value)

    case execute(parameters) do
      {:ok, "OK"} ->
        :ok

      {:error, reason} ->
        Logger.error("[#{__MODULE__}] Something goes wrong when trying to add new data to Redis. Reason: #{inspect reason}")
        {:error, reason}
    end
  end

  @doc """
  Remove existent key from Redis
  """
  @spec delete(key :: atom | String.t) :: :ok | {:error, term}
  def delete(key) do
    parameters = mount_request(:del, key)

    case execute(parameters) do
      {:ok, _key} ->
        :ok

      {:error, reason} ->
        Logger.error("[#{__MODULE__}] Something goes wrong when trying to remove data from Redis. Reason: #{inspect reason}")
        {:error, reason}
    end
  end

  @doc """
  Retrieve existent key from Redis
  """
  @spec get(key :: atom | String.t) :: {:ok, any} | {:error, term}
  def get(key) do
    parameters = mount_request(:get, key)

    case execute(parameters) do
      {:ok, nil} ->
        {:error, :not_found}

      {:ok, response} ->
        try do
          {:ok, response |> :erlang.binary_to_term()}
        rescue
          _ ->
            {:ok, response}
        end

      {:error, reason} ->
        Logger.error("[#{__MODULE__}] Something goes wrong when trying to retrieve data from Redis. Reason: #{inspect reason}")
        {:error, reason}
    end
  end

  @doc """
  Add timeout to expire key-value pair inside Redis
  """
  @spec expire(key :: atom | String.t, timeout :: pos_integer()) :: :ok | {:error, term}
  def expire(key, timeout) do
    parameters = mount_request(:expire, key, timeout)

    case execute(parameters) do
      {:ok, _} ->
        :ok

      {:error, reason} ->
        Logger.error("[#{__MODULE__}] Something goes wrong when trying to add expiration time to Redis. Reason: #{inspect reason}")
        {:error, reason}
    end
  end

  @spec execute(instruction) :: any
  defp execute(parameters) do
    parameters =
      parameters
      |> Tuple.to_list()

    Logger.debug("[#{__MODULE__}] Executing command: #{inspect parameters}")

    case Redix.command(@name, parameters) do
      {:ok, response} ->
        {:ok, response}

      {:error, %Redix.Error{message: reason}} ->
        {:error, reason}
    end
  end

  @spec get_options() :: list(atom) | String.t
  defp get_options() do
    Logger.info("[#{__MODULE__}] Starting Redis Service")

    with {:ok, config} <- Application.fetch_env(:he4rt, He4rt.Services.Redis) do
      Logger.info("[#{__MODULE__}] Starting Redix using configuration: #{inspect config}")

      case config do
        [host: host, port: port] ->
          [host: host |> Environments.get_env(), port: port |> Environments.get_env()]

        [host: host, port: port, database: database] ->
          [
            host: host |> Environments.get_env(),
            port: port |> Environments.get_env(),
            database: database |> Environments.get_env()
          ]

        [url: url] ->
          url |> Environments.get_env()
      end
    end
  end

  @spec get_command(command) :: String.t
  defp get_command(command) when command in @possible_commands, do: command |> to_string() |> String.upcase()
  defp get_command(_command), do: nil

  @spec mount_request(command, key :: atom | String.t, value :: any) :: instruction when command: atom
  defp mount_request(command, key, value) when command in @possible_commands and is_binary(value), do: {command |> get_command(), key |> to_string(), value}
  defp mount_request(command, key, value) when command in @possible_commands and is_integer(value), do: {command |> get_command(), key |> to_string(), value}
  defp mount_request(command, key, value) when command in @possible_commands, do: {command |> get_command(), key |> to_string(), value |> :erlang.term_to_binary()}

  @spec mount_request(command, key :: atom | String.t) :: instruction when command: atom
  defp mount_request(command, key) when command in @possible_commands, do: {command |> get_command(), key |> to_string()}

  @spec mount_request(command) :: instruction when command: atom
  defp mount_request(command) when command in @possible_commands, do: {command |> get_command()}
end
