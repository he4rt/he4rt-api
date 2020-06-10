defmodule He4rt.Support.Fixtures.Languages do
  @moduledoc false

  alias He4rt.Schemas.Language
  alias He4rt.Modules.Languages

  @doc """
  Create language parameters
  """
  @spec params() :: map 
  def params(),
    do: %{
      name: Faker.Cannabis.strain()
    }

  @doc """
  Insert new language
  """
  @spec insert() :: Language.t 
  def insert() do
    {:ok, resource} = Languages.create params() 

    resource
  end
end
