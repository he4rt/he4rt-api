defmodule He4rt.Schemas.Ban do
  @moduledoc """
  Schema definition for `bans` table
  """
  use Ecto.Schema
  import Ecto.Changeset

  @typedoc """
  Ban type
  """
  @type t :: %__MODULE__{
    id: pos_integer(), 
    admin_id: String.t,
    victim_id: String.t,
    type: String.t,
    reason: String.t,
    time: DateTime.t,
    revoked: boolean(),
    created_at: DateTime.t,
    updated_at: DateTime.t
  }

  @fields ~w(
    id
    admin_id
    victim_id
    type
    reason
    time
    revoked
    created_at
    updated_at
  )a

  @primary_key {:id, :id, autogenerate: true}
  @derive {Poison.Encoder, only: @fields}

  schema "bans" do
    field :admin_id, :string
    field :victim_id, :string
    field :type, :string
    field :reason, :string
    field :time, :naive_datetime
    field :revoked, :boolean, default: false

    timestamps(inserted_at: :created_at)
  end

  @doc false
  def changeset(%__MODULE__{} = schema, attrs) when is_map(attrs) do
    schema
    |> cast(attrs, ~w(admin_id victim_id type reason time revoked)a)
    |> validate_required(~w(admin_id victim_id type reason)a)
  end
end
