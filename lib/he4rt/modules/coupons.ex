defmodule He4rt.Modules.Coupons do
  @moduledoc """
  The Coupons context.

  Handle coupons from Database
  """
  import Ecto.Query

  alias He4rt.Repo
  alias He4rt.Schemas.Coupon

  @preload [:type]

  @doc """
  Retrieve one coupon by ID
  """
  @spec get(coupon_id :: pos_integer()) :: {:ok, Coupon.t} | {:error, term}
  def get(coupon_id) when is_integer(coupon_id) do
    from(
      m in Coupon,
      where: m.id == ^coupon_id,
      preload: ^@preload
    )
    |> Repo.one()
    |> case do
      nil ->
        {:error, :not_found}

      coupon ->
        {:ok, coupon}
    end
  end

  @doc """
  Retrieve one coupon by name
  """
  @spec get_from_name(name :: String.t) :: {:ok, Coupon.t} | {:error, term}
  def get_from_name(name) when is_binary(name) do
    from(
      m in Coupon,
      where: m.name == ^name,
      preload: ^@preload
    )
    |> Repo.one()
    |> case do
      nil ->
        {:error, :not_found}

      coupon ->
        {:ok, coupon}
    end
  end

  @doc """
  Retrieve all coupons
  """
  @spec retrieve_all() :: {:ok, list(Coupon.t)} | {:error, term}
  def retrieve_all() do
    from(
      m in Coupon,
      preload: ^@preload,
      order_by: [desc: m.created_at]
    )
    |> Repo.all()
    |> case do
      [] ->
        {:error, :not_found}

      coupons ->
        {:ok, coupons}
    end
  end

  @doc """
  Create new coupon
  """
  @spec create(attrs :: map()) :: {:ok, Coupon.t} | {:error, term}
  def create(attrs) when is_map(attrs) do
    %Coupon{}
    |> Coupon.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, coupon} ->
        coupon =
          coupon
          |> Repo.preload(@preload)

        {:ok, coupon}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Update existent coupon
  """
  @spec update(attrs :: map()) :: {:ok, Coupon.t} | {:error, term}
  def update(%{"coupon_id" => coupon_id} = attrs) when is_integer(coupon_id) and is_map(attrs) do
    with {:ok, coupon} <- get(coupon_id) do
      coupon
      |> Coupon.changeset(attrs)
      |> Repo.update()
      |> case do
        {:ok, coupon} ->
          coupon =
            coupon
            |> Repo.preload(@preload)

          {:ok, coupon}

        {:error, reason} ->
          {:error, reason}
      end
    end
  end
end
