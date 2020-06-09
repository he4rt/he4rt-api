defmodule He4rt.Test.Schemas.Coupon do
  use ExUnit.Case, async: false

  @moduletag :users

  alias He4rt.Schemas.Coupon, as: Schema

  setup_all do
    %{
      params: %{
        name: Faker.Name.name(),
        value: Faker.random_between(1, 9_999),
        used: [true, false] |> Enum.random(),
        type_id: Faker.random_between(1, 9_999),
        user_id: Faker.random_between(1, 9_999)
      }
    }
  end

  describe "Sent attributes to changeset so" do
    @tag :changeset_error_required
    test "with invalid parameters, shouldn't return a valid changeset", %{} do
      changeset =
        %Schema{}
        |> Schema.changeset(%{})

      assert(
        not changeset.valid?
        and changeset.errors === [
          name: {"can't be blank", [validation: :required]},
          value: {"can't be blank", [validation: :required]}
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
