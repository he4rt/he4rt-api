defmodule He4rt.Test.Schemas.User do
  use ExUnit.Case, async: false

  @moduletag :users

  alias He4rt.Schemas.User, as: Schema

  setup_all do
    %{
      params: %{
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
    }
  end

  describe "Sent attributes to changeset so" do
    @tag :changeset_error_invalid_language
    test "with invalid language, shouldn't return a valid changeset", %{params: params} do
      params =
        params
        |> Map.put(:language, "foobar")

      changeset =
        %Schema{}
        |> Schema.changeset(params)

      assert(
        not changeset.valid?
        and changeset.errors === [
          language: {"is invalid", [validation: :inclusion, enum: ~w(pt_BR en_US)]}
        ]
      )
    end

    @tag :changeset_ok
    test "with valid parameters, should return a valid changeset", %{params: params} do
      changeset =
        %Schema{}
        |> Schema.changeset(params)

      assert changeset.valid?
    end
  end
end
