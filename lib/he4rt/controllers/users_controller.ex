defmodule He4rt.Controllers.UsersController do
  @moduledoc """
  Handle users 
  """
  use Plug.Builder
  import He4rt.Views.{JsonView, ErrorView}

  alias He4rt.Modules.{Users, LevelUps}

  @doc """
  Retrieve all users 
  """
  @spec index(Plug.Conn.t, map()) :: Plug.Conn.t
  def index(%Plug.Conn{} = conn, _params) do
    case Users.retrieve_all() do
      {:ok, users} ->
        conn |> send_resp(200, users |> handle_response())

      {:error, reason} ->
        conn |> send_error({:error, reason})
    end
  end

  @doc """
  Retrieve one user by ID 
  """
  @spec show(Plug.Conn.t, map()) :: Plug.Conn.t
  def show(%Plug.Conn{} = conn, %{"discord_id" => discord_id}) do
    case Users.get_from_discord_id(discord_id) do
      {:ok, user} ->
        conn |> send_resp(200, user |> handle_response())

      {:error, reason} ->
        conn |> send_error({:error, reason})
    end
  end

  @doc """
  Create new user 
  """
  @spec create(Plug.Conn.t, map()) :: Plug.Conn.t
  def create(%Plug.Conn{} = conn, params) do
    case Users.create(params) do
      {:ok, user} ->
        conn |> send_resp(201, user |> handle_response())

      {:error, reason} ->
        conn |> send_error({:error, reason})
    end
  end

  @doc """
  Update one user by ID 
  """
  @spec update(Plug.Conn.t, map()) :: Plug.Conn.t
  def update(%Plug.Conn{} = conn, %{"discord_id" => _discord_id} = params) do
    case Users.update(params) do
      {:ok, user} ->
        conn |> send_resp(200, user |> handle_response())

      {:error, reason} ->
        conn |> send_error({:error, reason})
    end
  end

  @doc """
  Remove one user by ID 
  """
  @spec remove(Plug.Conn.t, map()) :: Plug.Conn.t
  def remove(%Plug.Conn{} = conn, %{"discord_id" => discord_id}) do
    case Users.remove(discord_id) do
      {:ok, _user} ->
        conn |> send_resp(204, "")

      {:error, reason} ->
        conn |> send_error({:error, reason})
    end
  end

  @doc """
  Increase user level
  """
  @spec levelup(Plug.Conn.t, map()) :: Plug.Conn.t
  def levelup(%Plug.Conn{} = conn, %{"discord_id" => discord_id} = params) do
    case Users.get_from_discord_id(discord_id) do
      {:ok, user} ->
        multiplier =
          case params["donator"] do
            nil -> 1
            _smth -> 2
          end

        xp =
          1..5
          |> Enum.random()
          |> Kernel.*(multiplier)
          |> Kernel.+(user.current_exp)
        
        case LevelUps.can_level_up?(user.level, xp) do
          {:ok, level_up} ->
            case Users.update(%{"discord_id" => discord_id, "level" => level_up.id, "current_exp" => xp}) do
              {:ok, user} ->
                conn |> send_resp(201, user |> handle_response())

              {:error, reason} ->
                conn |> send_error({:error, reason})
            end

          {:error, reason} ->
            conn |> send_error({:error, reason})
        end

      {:error, reason} ->
        conn |> send_error({:error, reason})
    end
  end

  @doc """
  Generate daily coins
  """
  @spec daily(Plug.Conn.t, map()) :: Plug.Conn.t
  def daily(%Plug.Conn{} = conn, %{"discord_id" => discord_id}) do
    case Users.get_from_discord_id(discord_id) do
      {:ok, user} ->
        conn |> send_resp(200, user |> handle_response())

      {:error, reason} ->
        conn |> send_error({:error, reason})
    end
  end
end
