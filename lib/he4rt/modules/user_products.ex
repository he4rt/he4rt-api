defmodule He4rt.Modules.UserProducts do
  @moduledoc """
  The User Products context.

  Handle user products from Database
  """
  import Ecto.Query

  alias He4rt.Repo
  alias He4rt.Schemas.UserProduct

  @preload [:user_id, :product_id]

  @doc """
  Retrieve one user product by ID
  """
  @spec get(user_product_id :: pos_integer()) :: {:ok, UserProduct.t} | {:error, term}
  def get(user_product_id) when is_integer(user_product_id) do
    from(
      m in UserProduct,
      where: m.id == ^user_product_id,
      preload: ^@preload
    )
    |> Repo.one()
    |> case do
      nil ->
        {:error, :not_found}

      user_product ->
        {:ok, user_product}
    end
  end

  @doc """
  Retrieve all user products
  """
  @spec retrieve_all() :: {:ok, list(UserProduct.t)} | {:error, term}
  def retrieve_all() do
    from(
      m in UserProduct,
      preload: ^@preload,
      order_by: [desc: m.created_at]
    )
    |> Repo.all()
    |> case do
      [] ->
        {:error, :not_found}

      user_products ->
        {:ok, user_products}
    end
  end

  @doc """
  Retrieve all user products from user 
  """
  @spec retrieve_all_from_user(user_id :: pos_integer()) :: {:ok, list(UserProduct.t)} | {:error, term}
  def retrieve_all_from_user(user_id) when is_integer(user_id) do
    from(
      m in UserProduct,
      where: m.user_id == ^user_id,
      preload: ^@preload,
      order_by: [desc: m.created_at]
    )
    |> Repo.all()
    |> case do
      [] ->
        {:error, :not_found}

      user_products ->
        {:ok, user_products}
    end
  end

  @doc """
  Create new user product
  """
  @spec create(attrs :: map()) :: {:ok, UserProduct.t} | {:error, term}
  def create(attrs) when is_map(attrs) do
    %UserProduct{}
    |> UserProduct.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, user_product} ->
        user_product =
          user_product
          |> Repo.preload(@preload)

        {:ok, user_product}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Update existent user product
  """
  @spec update(attrs :: map()) :: {:ok, UserProduct.t} | {:error, term}
  def update(%{"user_product_id" => user_product_id} = attrs) when is_integer(user_product_id) and is_map(attrs) do
    with {:ok, user_product} <- get(user_product_id) do
      user_product
      |> UserProduct.changeset(attrs)
      |> Repo.update()
      |> case do
        {:ok, user_product} ->
          user_product =
            user_product
            |> Repo.preload(@preload)

          {:ok, user_product}

        {:error, reason} ->
          {:error, reason}
      end
    end
  end
end
