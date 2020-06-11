defmodule He4rt.Modules.Users do
  @moduledoc """
  The Users context.

  Handle users from Database
  """
  import Ecto.Query

  alias He4rt.Repo
  alias He4rt.Schemas.User

  @preload []

  @doc """
  Retrieve one user by ID
  """
  @spec get(user_id :: pos_integer()) :: {:ok, User.t} | {:error, term}
  def get(user_id) when is_integer(user_id) do
    from(
      m in User,
      where: m.id == ^user_id,
      preload: ^@preload
    )
    |> Repo.one()
    |> case do
      nil ->
        {:error, :not_found}

      user ->
        {:ok, user}
    end
  end

  @doc """
  Retrieve one user by Discord ID
  """
  @spec get_from_discord_id(discord_id :: String.t) :: {:ok, User.t} | {:error, term}
  def get_from_discord_id(discord_id) when is_binary(discord_id) do
    from(
      m in User,
      where: m.discord_id == ^discord_id,
      preload: ^@preload
    )
    |> Repo.one()
    |> case do
      nil ->
        {:error, :not_found}

      user ->
        {:ok, user}
    end
  end

  @doc """
  Retrieve all users
  """
  @spec retrieve_all() :: {:ok, list(User.t)} | {:error, term}
  def retrieve_all() do
    from(
      m in User,
      preload: ^@preload,
      order_by: [desc: m.created_at]
    )
    |> Repo.all()
    |> case do
      [] ->
        {:error, :not_found}

      users ->
        {:ok, users}
    end
  end

  @doc """
  Create new user
  """
  @spec create(attrs :: map()) :: {:ok, User.t} | {:error, term}
  def create(attrs) when is_map(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, user} ->
        user =
          user
          |> Repo.preload(@preload)

        {:ok, user}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Update existent user
  """
  @spec update(attrs :: map()) :: {:ok, User.t} | {:error, term}
  def update(%{"discord_id" => discord_id} = attrs) when is_binary(discord_id) and is_map(attrs) do
    with {:ok, user} <- get_from_discord_id(discord_id) do
      user
      |> User.changeset(attrs)
      |> Repo.update()
      |> case do
        {:ok, user} ->
          user =
            user
            |> Repo.preload(@preload)

          {:ok, user}

        {:error, reason} ->
          {:error, reason}
      end
    end
  end

  @doc """
  Remove existent user
  """
  @spec remove(discord_id :: String.t) :: {:ok, User.t} | {:error, term}
  def remove(discord_id) when is_integer(discord_id) do
    with {:ok, user} <- get_from_discord_id(discord_id) do
      user
      |> Repo.delete()
    end
  end
end
