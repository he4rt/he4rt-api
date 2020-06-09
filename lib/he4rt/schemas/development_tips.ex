defmodule He4rt.Schemas.DevelopmentTip do
  @moduledoc """
  Schema definition for `development_tips` table
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias He4rt.Schemas.Language

  @typedoc """
  Development Tip type
  """
  @type t :: %__MODULE__{
    id: pos_integer(), 
    language: Language.t,
    language_id: pos_integer(),
    tip: String.t,
    used: boolean(),
    created_at: DateTime.t,
    updated_at: DateTime.t
  }

  @fields ~w(
    id
    language
    tip
    used
    created_at
    updated_at
  )a

  @primary_key {:id, :id, autogenerate: true}
  @derive {Poison.Encoder, only: @fields}

  schema "development_tips" do
    field :tip, :string
    field :used, :boolean, default: false

    belongs_to :language, Language

    timestamps(inserted_at: :created_at)
  end

  @doc false
  def changeset(%__MODULE__{} = schema, attrs) when is_map(attrs) do
    schema
    |> cast(attrs, ~w(language_id tip used)a)
  end
end
