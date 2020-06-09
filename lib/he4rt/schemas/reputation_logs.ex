defmodule He4rt.Schemas.ReputationLog do
  @moduledoc """
  Schema definition for `reputation_logs` table
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias He4rt.Schemas.User

  @typedoc """
  Reputation Log type
  """
  @type t :: %__MODULE__{
    id: pos_integer(), 
    user: User.t,
    user_id: pos_integer(),
    receiver: User.t,
    receiver_id: pos_integer(),
    created_at: DateTime.t,
    updated_at: DateTime.t
  }

  @fields ~w(
    id
    user
    receiver
    created_at
    updated_at
  )a

  @primary_key {:id, :id, autogenerate: true}
  @derive {Poison.Encoder, only: @fields}

  schema "reputation_logs" do
    belongs_to :user, User
    belongs_to :receiver, User

    timestamps(inserted_at: :created_at)
  end

  @doc false
  def changeset(%__MODULE__{} = schema, attrs) when is_map(attrs) do
    schema
    |> cast(attrs, ~w(user_id received_id)a)
    |> foreign_key_constraint(:type_id)
    |> foreign_key_constraint(:user_id)
  end
end
