defmodule He4rt.Schemas.Coupon do
  @moduledoc """
  Schema definition for `coupouns` table
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias He4rt.Schemas.{User, CouponType}

  @typedoc """
  Coupon type
  """
  @type t :: %__MODULE__{
    id: pos_integer(), 
    name: String.t,
    used: boolean(),
    type: CouponType.t,
    type_id: pos_integer(),
    user: User.t,
    user_id: pos_integer(),
    created_at: DateTime.t,
    updated_at: DateTime.t
  }

  @fields ~w(
    id
    name
    value
    type
    user
    created_at
    updated_at
  )a

  @primary_key {:id, :id, autogenerate: true}
  @derive {Poison.Encoder, only: @fields}

  schema "coupons" do
    field :name, :string
    field :value, :integer
    field :used, :boolean

    belongs_to :type, CouponType
    belongs_to :user, User

    timestamps(inserted_at: :created_at)
  end

  @doc false
  def changeset(%__MODULE__{} = schema, attrs) when is_map(attrs) do
    schema
    |> cast(attrs, ~w(name value used type_id user_id)a)
    |> validate_required(~w(name value))
    |> foreign_key_constraint(:type_id)
    |> foreign_key_constraint(:user_id)
  end
end
