defmodule He4rt.Test.Schemas.Ban do
  use ExUnit.Case, async: false

  @moduletag :bans

  alias He4rt.Schemas.Ban, as: Schema

  setup_all do
    %{
      params: %{
        admin_id: Faker.random_between(1_000_000, 9_999_999) |> to_string(),
        victim_id: Faker.random_between(1_000_000, 9_999_999) |> to_string(),
        type: Faker.Lorem.word(),
        reason: Faker.Lorem.Shakespeare.king_richard_iii(),
        time: DateTime.utc_now(),
        revoked: [true, false] |> Enum.random()
      }
    }
  end

  describe "Sent attributes to changeset so" do
    @tag :changeset_error_required
    test "with invalid language, shouldn't return a valid changeset", %{} do
      changeset =
        %Schema{}
        |> Schema.changeset(%{})

      assert(
        not changeset.valid?
        and changeset.errors === [
          admin_id: {"can't be blank", [validation: :required]},
          victim_id: {"can't be blank", [validation: :required]},
          type: {"can't be blank", [validation: :required]},
          reason: {"can't be blank", [validation: :required]}
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
