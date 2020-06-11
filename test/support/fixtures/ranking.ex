defmodule He4rt.Support.Fixtures.Ranking do
  @moduledoc false

  alias He4rt.Schemas.User
  alias He4rt.Modules.Users

  @doc """
  Create user parameters
  """
  @spec params() :: map 
  def params(),
    do: %{
      discord_id: Faker.random_between(1_000_000, 9_999_999) |> to_string(),
      name: Faker.Name.name(),
      nickname: Faker.Internet.user_name(),
      twich: Faker.Internet.user_name(),
      git: Faker.Internet.url(),
      about: Faker.Lorem.Shakespeare.romeo_and_juliet(),
      language: ~w(pt_BR en_US) |> Enum.random(),
      level: Faker.random_between(1, 999),
      current_exp: Faker.random_between(0, 99_999_999),
      money: Faker.Commerce.price(),
      daily: DateTime.utc_now(),
      reputation: Faker.random_between(0, 99_999_999)
    }

  @doc """
  Insert new user
  """
  @spec insert() :: User.t 
  def insert() do
    {:ok, resource} = Users.create params() 

    resource
  end
end
