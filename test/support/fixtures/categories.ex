defmodule He4rt.Support.Fixtures.Categories do
  @moduledoc false

  alias He4rt.Schemas.Category
  alias He4rt.Modules.Categories

  @doc """
  Create category parameters
  """
  @spec params() :: map 
  def params(),
    do: %{
      name: Faker.Commerce.department()
    }

  @doc """
  Insert new category
  """
  @spec insert() :: Category.t 
  def insert() do
    {:ok, resource} = Categories.create params() 

    resource
  end
end
