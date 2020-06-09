defmodule He4rt.Schemas.Language do
  @moduledoc """
  Schema definition for `languages` table
  """
  use Ecto.Schema
  import Ecto.Changeset

  @typedoc """
  Language type
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

  schema "languages" do
    field :name, :string

    timestamps(inserted_at: :created_at)
  end

  @doc false
  def changeset(%__MODULE__{} = schema, attrs) when is_map(attrs) do
    schema
    |> cast(attrs, [:name])
  end
end
