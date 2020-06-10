defmodule He4rt.Modules.Categories do
  @moduledoc """
  The Categories context.

  Handle categories from Database
  """
  import Ecto.Query

  alias He4rt.Repo
  alias He4rt.Schemas.Category

  @preload []

  @doc """
  Retrieve one category by ID
  """
  @spec get(category_id :: pos_integer()) :: {:ok, Category.t} | {:error, term}
  def get(category_id) when is_integer(category_id) do
    from(
      m in Category,
      where: m.id == ^category_id,
      preload: ^@preload
    )
    |> Repo.one()
    |> case do
      nil ->
        {:error, :not_found}

      category ->
        {:ok, category}
    end
  end

  @doc """
  Retrieve one category by name
  """
  @spec get_from_name(name :: String.t) :: {:ok, Category.t} | {:error, term}
  def get_from_name(name) when is_binary(name) do
    from(
      m in Category,
      where: m.name == ^name,
      preload: ^@preload
    )
    |> Repo.one()
    |> case do
      nil ->
        {:error, :not_found}

      category ->
        {:ok, category}
    end
  end

  @doc """
  Retrieve all categories
  """
  @spec retrieve_all() :: {:ok, list(Category.t)} | {:error, term}
  def retrieve_all() do
    from(
      m in Category,
      preload: ^@preload,
      order_by: [desc: m.created_at]
    )
    |> Repo.all()
    |> case do
      [] ->
        {:error, :not_found}

      categories ->
        {:ok, categories}
    end
  end

  @doc """
  Create new category
  """
  @spec create(attrs :: map()) :: {:ok, Category.t} | {:error, term}
  def create(attrs) when is_map(attrs) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, category} ->
        category =
          category
          |> Repo.preload(@preload)

        {:ok, category}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Update existent category
  """
  @spec update(attrs :: map()) :: {:ok, Category.t} | {:error, term}
  def update(%{"category_id" => category_id} = attrs) when is_integer(category_id) and is_map(attrs) do
    with {:ok, category} <- get(category_id) do
      category
      |> Category.changeset(attrs)
      |> Repo.update()
      |> case do
        {:ok, category} ->
          category =
            category
            |> Repo.preload(@preload)

          {:ok, category}

        {:error, reason} ->
          {:error, reason}
      end
    end
  end

  @doc """
  Remove existent category
  """
  @spec remove(category_id :: pos_integer()) :: {:ok, Category.t} | {:error, term}
  def remove(category_id) when is_integer(category_id) do
    with {:ok, category} <- get(category_id) do
      category
      |> Repo.delete()
    end
  end
end
