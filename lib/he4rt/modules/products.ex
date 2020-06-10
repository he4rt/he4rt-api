defmodule He4rt.Modules.Products do
  @moduledoc """
  The Products context.

  Handle products from Database
  """
  import Ecto.Query

  alias He4rt.Repo
  alias He4rt.Schemas.Product

  @preload [:category]

  @doc """
  Retrieve one product by ID
  """
  @spec get(product_id :: pos_integer()) :: {:ok, Product.t} | {:error, term}
  def get(product_id) when is_integer(product_id) do
    from(
      m in Product,
      where: m.id == ^product_id,
      preload: ^@preload
    )
    |> Repo.one()
    |> case do
      nil ->
        {:error, :not_found}

      product ->
        {:ok, product}
    end
  end

  @doc """
  Retrieve one product by name
  """
  @spec get_from_name(name :: String.t) :: {:ok, Product.t} | {:error, term}
  def get_from_name(name) when is_binary(name) do
    from(
      m in Product,
      where: m.name == ^name,
      preload: ^@preload
    )
    |> Repo.one()
    |> case do
      nil ->
        {:error, :not_found}

      product ->
        {:ok, product}
    end
  end

  @doc """
  Retrieve all products
  """
  @spec retrieve_all() :: {:ok, list(Product.t)} | {:error, term}
  def retrieve_all() do
    from(
      m in Product,
      preload: ^@preload,
      order_by: [desc: m.created_at]
    )
    |> Repo.all()
    |> case do
      [] ->
        {:error, :not_found}

      products ->
        {:ok, products}
    end
  end

  @doc """
  Create new product
  """
  @spec create(attrs :: map()) :: {:ok, Product.t} | {:error, term}
  def create(attrs) when is_map(attrs) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, product} ->
        product =
          product
          |> Repo.preload(@preload)

        {:ok, product}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Update existent product
  """
  @spec update(attrs :: map()) :: {:ok, Product.t} | {:error, term}
  def update(%{"product_id" => product_id} = attrs) when is_integer(product_id) and is_map(attrs) do
    with {:ok, product} <- get(product_id) do
      product
      |> Product.changeset(attrs)
      |> Repo.update()
      |> case do
        {:ok, product} ->
          product =
            product
            |> Repo.preload(@preload)

          {:ok, product}

        {:error, reason} ->
          {:error, reason}
      end
    end
  end

  @doc """
  Remove existent product
  """
  @spec remove(product_id :: pos_integer()) :: {:ok, Product.t} | {:error, term}
  def remove(product_id) when is_integer(product_id) do
    with {:ok, product} <- get(product_id) do
      product
      |> Repo.delete()
    end
  end
end
