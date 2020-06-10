defmodule He4rt.Support.Fixtures.Coupons do
  @moduledoc false

  alias He4rt.Schemas.{Coupon, CouponType}
  alias He4rt.Modules.{Coupons, CouponTypes}
  alias He4rt.Support.Fixtures.Users

  @doc """
  Create coupon parameters
  """
  @spec params() :: map 
  def params(),
    do: %{
      name: Faker.Commerce.product_name_product(),
      value: Faker.random_between(1, 9_999_999),
      used: false,
      type_id: insert(:type) |> Map.get(:id),
      user_id: Users.insert() |> Map.get(:id)
    }

  @doc """
  Create coupon type parameters
  """
  @spec params(:type) :: map 
  def params(:type),
    do: %{
      name: Faker.Commerce.department()
    }

  @doc """
  Insert new coupon
  """
  @spec insert() :: Coupon.t 
  def insert() do
    {:ok, resource} = Coupons.create params() 

    resource
  end

  @doc """
  Insert new coupon type
  """
  @spec insert(:type) :: CouponType.t 
  def insert(:type) do
    {:ok, resource} = CouponTypes.create params(:type) 

    resource
  end
end
