defmodule He4rt.Modules.Bans do
  @moduledoc """
  The Bans context.

  Handle bans from Database
  """
  import Ecto.Query

  alias He4rt.Repo
  alias He4rt.Schemas.Ban

  @preload []

  @doc """
  Retrieve one ban by ID
  """
  @spec get(ban_id :: pos_integer()) :: {:ok, Ban.t} | {:error, term}
  def get(ban_id) when is_integer(ban_id) do
    from(
      m in Ban,
      where: m.id == ^ban_id,
      preload: ^@preload
    )
    |> Repo.one()
    |> case do
      nil ->
        {:error, :not_found}

      ban ->
        {:ok, ban}
    end
  end

  @doc """
  Retrieve all bans
  """
  @spec retrieve_all() :: {:ok, list(Ban.t)} | {:error, term}
  def retrieve_all() do
    from(
      m in Ban,
      preload: ^@preload,
      order_by: [desc: m.created_at]
    )
    |> Repo.all()
    |> case do
      [] ->
        {:error, :not_found}

      bans ->
        {:ok, bans}
    end
  end

  @doc """
  Create new ban
  """
  @spec create(attrs :: map()) :: {:ok, Ban.t} | {:error, term}
  def create(attrs) when is_map(attrs) do
    %Ban{}
    |> Ban.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, ban} ->
        ban =
          ban
          |> Repo.preload(@preload)

        {:ok, ban}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Update existent ban
  """
  @spec update(attrs :: map()) :: {:ok, Ban.t} | {:error, term}
  def update(%{"ban_id" => ban_id} = attrs) when is_integer(ban_id) and is_map(attrs) do
    with {:ok, ban} <- get(ban_id) do
      ban
      |> Ban.changeset(attrs)
      |> Repo.update()
      |> case do
        {:ok, ban} ->
          ban =
            ban
            |> Repo.preload(@preload)

          {:ok, ban}

        {:error, reason} ->
          {:error, reason}
      end
    end
  end
end
