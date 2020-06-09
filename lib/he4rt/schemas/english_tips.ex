defmodule He4rt.Schemas.EnglishTip do
  @moduledoc """
  Schema definition for `english_tips` table
  """
  use Ecto.Schema
  import Ecto.Changeset


  @typedoc """
  English Tip type
  """
  @type t :: %__MODULE__{
    id: pos_integer(), 
    tip: String.t,
    used: boolean(),
    created_at: DateTime.t,
    updated_at: DateTime.t
  }

  @fields ~w(
    id
    tip
    used
    created_at
    updated_at
  )a

  @primary_key {:id, :id, autogenerate: true}
  @derive {Poison.Encoder, only: @fields}

  schema "english_tips" do
    field :tip, :string
    field :used, :boolean, default: false

    timestamps(inserted_at: :created_at)
  end

  @doc false
  def changeset(%__MODULE__{} = schema, attrs) when is_map(attrs) do
    schema
    |> cast(attrs, ~w(tip used)a)
  end
end
