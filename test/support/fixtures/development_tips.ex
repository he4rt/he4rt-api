defmodule He4rt.Support.Fixtures.DevelopmentTips do
  @moduledoc false

  alias He4rt.Schemas.DevelopmentTip
  alias He4rt.Modules.DevelopmentTips
  alias He4rt.Support.Fixtures.Languages

  @doc """
  Create english tip parameters without langauge
  """
  @spec params(:language) :: map 
  def params(:language),
    do: %{
      tip: Faker.Lorem.Shakespeare.romeo_and_juliet(),
    }

  @doc """
  Create english tip parameters with langauge
  """
  @spec params() :: map 
  def params(),
    do: %{
      tip: Faker.Lorem.Shakespeare.romeo_and_juliet(),
      language_id: Languages.insert() |> Map.get(:id)
    }

  @doc """
  Insert new english tip
  """
  @spec insert() :: DevelopmentTip.t 
  def insert() do
    {:ok, resource} = DevelopmentTips.create params() 

    resource
  end
end
