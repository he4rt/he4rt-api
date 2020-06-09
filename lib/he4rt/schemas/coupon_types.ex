defmodule He4rt.Schemas.CouponType do
  @moduledoc """
  Schema definition for `coupoun_types` table
  """
  use Ecto.Schema
  import Ecto.Changeset

  @typedoc """
  Coupoun Type type
  """
  @type t :: %__MODULE__{
    id: pos_integer(), 
    name: String.t,
    created_at: DateTime.t,
    updated_at: DateTime.t
  }

  @fields ~w(
    id
    name
    created_at
    updated_at
  )a

  @primary_key {:id, :id, autogenerate: true}
  @derive {Poison.Encoder, only: @fields}

  schema "coupoun_types" do
    field :name, :string

    timestamps(inserted_at: :created_at)
  end

  @doc false
  def changeset(%__MODULE__{} = schema, attrs) when is_map(attrs) do
    schema
    |> cast(attrs, [:name])
  end
end
