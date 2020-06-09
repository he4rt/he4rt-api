defmodule He4rt.Schemas.LevelUp do
  @moduledoc """
  Schema definition for `levelup` table
  """
  use Ecto.Schema
  import Ecto.Changeset

  @typedoc """
  LevelUp type
  """
  @type t :: %__MODULE__{
    id: pos_integer(), 
    name: String.t,
    required_exp: pos_integer(),
    created_at: DateTime.t,
    updated_at: DateTime.t
  }

  @fields ~w(
    id
    name
    required_exp
    created_at
    updated_at
  )a

  @primary_key {:id, :id, autogenerate: true}
  @derive {Poison.Encoder, only: @fields}

  schema "levelup" do
    field :name, :string
    field :required_exp, :integer

    timestamps(inserted_at: :created_at)
  end

  @doc false
  def changeset(%__MODULE__{} = schema, attrs) when is_map(attrs) do
    schema
    |> cast(attrs, ~w(name required_exp)a)
  end
end
