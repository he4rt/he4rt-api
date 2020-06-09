defmodule He4rt.Modules.CouponTypes do
  @moduledoc """
  The Coupon Types context.

  Handle coupon types from Database
  """
  import Ecto.Query

  alias He4rt.Repo
  alias He4rt.Schemas.CouponType

  @preload []

  @doc """
  Retrieve one coupon type by ID
  """
  @spec get(coupon_type_id :: pos_integer()) :: {:ok, CouponType.t} | {:error, term}
  def get(coupon_type_id) when is_integer(coupon_type_id) do
    from(
      m in CouponType,
      where: m.id == ^coupon_type_id,
      preload: ^@preload
    )
    |> Repo.one()
    |> case do
      nil ->
        {:error, :not_found}

      coupon_type ->
        {:ok, coupon_type}
    end
  end

  @doc """
  Retrieve one coupon type by name
  """
  @spec get_from_name(name :: String.t) :: {:ok, CouponType.t} | {:error, term}
  def get_from_name(name) when is_binary(name) do
    from(
      m in CouponType,
      where: m.name == ^name,
      preload: ^@preload
    )
    |> Repo.one()
    |> case do
      nil ->
        {:error, :not_found}

      coupon_type ->
        {:ok, coupon_type}
    end
  end

  @doc """
  Retrieve all coupon types
  """
  @spec retrieve_all() :: {:ok, list(CouponType.t)} | {:error, term}
  def retrieve_all() do
    from(
      m in CouponType,
      preload: ^@preload,
      order_by: [desc: m.created_at]
    )
    |> Repo.all()
    |> case do
      [] ->
        {:error, :not_found}

      coupon_types ->
        {:ok, coupon_types}
    end
  end

  @doc """
  Create new coupon type
  """
  @spec create(attrs :: map()) :: {:ok, CouponType.t} | {:error, term}
  def create(attrs) when is_map(attrs) do
    %CouponType{}
    |> CouponType.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, coupon_type} ->
        coupon_type =
          coupon_type
          |> Repo.preload(@preload)

        {:ok, coupon_type}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Update existent coupon type
  """
  @spec update(attrs :: map()) :: {:ok, CouponType.t} | {:error, term}
  def update(%{"coupon_type_id" => coupon_type_id} = attrs) when is_integer(coupon_type_id) and is_map(attrs) do
    with {:ok, coupon_type} <- get(coupon_type_id) do
      coupon_type
      |> CouponType.changeset(attrs)
      |> Repo.update()
      |> case do
        {:ok, coupon_type} ->
          coupon_type =
            coupon_type
            |> Repo.preload(@preload)

          {:ok, coupon_type}

        {:error, reason} ->
          {:error, reason}
      end
    end
  end
end
