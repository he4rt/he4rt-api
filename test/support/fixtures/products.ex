defmodule He4rt.Support.Fixtures.Products do
  @moduledoc false

  alias He4rt.Schemas.Product
  alias He4rt.Modules.Products
  alias He4rt.Support.Fixtures.Categories

  @doc """
  Create product parameters without category
  """
  @spec params() :: map 
  def params(),
    do: %{
      name: Faker.Commerce.product_name(),
      description: Faker.Lorem.Shakespeare.romeo_and_juliet(),
      price: Faker.Commerce.price()
    }

  @doc """
  Create product parameters with category
  """
  @spec params(:category) :: map 
  def params(:category),
    do: %{
      name: Faker.Commerce.product_name(),
      description: Faker.Lorem.Shakespeare.romeo_and_juliet(),
      price: Faker.Commerce.price(),
      category_id: Categories.insert() |> Map.get(:id)
    }

  @doc """
  Insert new product
  """
  @spec insert() :: Product.t 
  def insert() do
    {:ok, resource} = Products.create params() 

    resource
  end
end
