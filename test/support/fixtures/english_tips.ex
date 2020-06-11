defmodule He4rt.Support.Fixtures.EnglishTips do
  @moduledoc false

  alias He4rt.Schemas.EnglishTip
  alias He4rt.Modules.EnglishTips

  @doc """
  Create english tip parameters
  """
  @spec params() :: map 
  def params(),
    do: %{
      tip: Faker.Lorem.Shakespeare.romeo_and_juliet(),
    }

  @doc """
  Insert new english tip
  """
  @spec insert() :: EnglishTip.t 
  def insert() do
    {:ok, resource} = EnglishTips.create params() 

    resource
  end
end
