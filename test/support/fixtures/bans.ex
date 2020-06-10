defmodule He4rt.Support.Fixtures.Bans do
  @moduledoc false

  alias He4rt.Schemas.Ban
  alias He4rt.Modules.Bans

  @doc """
  Create ban parameters
  """
  @spec params() :: map 
  def params(),
    do: %{
      admin_id: Faker.random_between(1_000_000, 9_999_999) |> to_string(),
      victim_id: Faker.random_between(1_000_000, 9_999_999) |> to_string(),
      type: Faker.Lorem.word() |> String.downcase(),
      reason: Faker.Lorem.Shakespeare.as_you_like_it(),
      time: DateTime.utc_now(),
      revoked: false
    }

  @doc """
  Insert new ban
  """
  @spec insert() :: Ban.t 
  def insert() do
    {:ok, resource} = Bans.create params() 

    resource
  end
end
