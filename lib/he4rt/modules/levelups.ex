defmodule He4rt.Modules.LevelUps do
  @moduledoc """
  The Level Ups context.

  Handle level ups from Database
  """
  import Ecto.Query

  alias He4rt.Repo
  alias He4rt.Schemas.LevelUp

  @preload []

  @doc """
  Retrieve one level up by ID
  """
  @spec get(level_up_id :: pos_integer()) :: {:ok, LevelUp.t} | {:error, term}
  def get(level_up_id) when is_integer(level_up_id) do
    from(
      m in LevelUp,
      where: m.id == ^level_up_id,
      preload: ^@preload
    )
    |> Repo.one()
    |> case do
      nil ->
        {:error, :not_found}

      level_up ->
        {:ok, level_up}
    end
  end

  @doc """
  Check if can level up
  """
  def can_level_up?(current_level_up, current_exp) do
    from(
      m in LevelUp,
      where: m.id >= ^current_level_up
    )
    |> Repo.one()
    |> case do
      nil ->
        {:ok, %{id: current_level_up}}

      _level_up ->
        from(
          m in LevelUp,
          where: m.required_exp <= ^current_exp
        )
        |> Repo.one()
        |> case do
          nil ->
            {:error, :not_found}

          level_up ->
            {:ok, level_up}
        end
    end
  end

  @doc """
  Retrieve one level up by name
  """
  @spec get_from_name(name :: String.t) :: {:ok, LevelUp.t} | {:error, term}
  def get_from_name(name) when is_binary(name) do
    from(
      m in LevelUp,
      where: m.name == ^name,
      preload: ^@preload
    )
    |> Repo.one()
    |> case do
      nil ->
        {:error, :not_found}

      level_up ->
        {:ok, level_up}
    end
  end

  @doc """
  Retrieve all level ups
  """
  @spec retrieve_all() :: {:ok, list(LevelUp.t)} | {:error, term}
  def retrieve_all() do
    from(
      m in LevelUp,
      preload: ^@preload,
      order_by: [desc: m.created_at]
    )
    |> Repo.all()
    |> case do
      [] ->
        {:error, :not_found}

      level_ups ->
        {:ok, level_ups}
    end
  end

  @doc """
  Create new level up
  """
  @spec create(attrs :: map()) :: {:ok, LevelUp.t} | {:error, term}
  def create(attrs) when is_map(attrs) do
    %LevelUp{}
    |> LevelUp.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Update existent level up
  """
  @spec update(attrs :: map()) :: {:ok, LevelUp.t} | {:error, term}
  def update(%{"level_up_id" => level_up_id} = attrs) when is_integer(level_up_id) and is_map(attrs) do
    with {:ok, level_up} <- get(level_up_id) do
      level_up
      |> LevelUp.changeset(attrs)
      |> Repo.update()
    end
  end
end
