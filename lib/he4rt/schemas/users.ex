defmodule He4rt.Schemas.User do
  @moduledoc """
  Schema definition for `users` table
  """
  use Ecto.Schema
  import Ecto.Changeset

  @typedoc """
  User type
  """
  @type t :: %__MODULE__{
    id: pos_integer(), 
    discord_id: String.t,
    name: String.t,
    nickname: String.t,
    twitch: String.t,
    git: String.t,
    about: String.t,
    language: String.t,
    level: pos_integer(),
    current_exp: pos_integer(),
    money: Decimal.t,
    daily: DateTime.t,
    reputation: pos_integer(),
    created_at: DateTime.t,
    updated_at: DateTime.t
  }

  @fields ~w(
    id
    discord_id
    name
    nickname
    twitch
    git
    about
    language
    level
    current_exp
    money
    daily
    reputation
    created_at
    updated_at
  )a

  @primary_key {:id, :id, autogenerate: true}
  @derive {Poison.Encoder, only: @fields}
  @languages ~w(pt_BR en_US)

  schema "users" do
    field :discord_id, :string 
    field :name, :string
    field :nickname, :string
    field :twitch, :string
    field :git, :string
    field :about, :string
    field :language, :string, default: "pt_BR"
    field :level, :integer, default: 1
    field :current_exp, :integer, default: 0
    field :money, :decimal
    field :daily, :naive_datetime
    field :reputation, :integer

    timestamps(inserted_at: :created_at)
  end

  @doc false
  def changeset(%__MODULE__{} = schema, attrs) when is_map(attrs) do
    schema
    |> cast(attrs, ~w(
      discord_id name nickname twitch git about
      language level current_exp money daily current_exp
    )a)
    |> validate_inclusion(:language, @languages)
    |> validate_number(:level, greater_than_or_equal_to: 1)
    |> validate_number(:current_exp, greater_than_or_equal_to: 0)
    |> validate_number(:money, greater_than_or_equal_to: 0)
    |> validate_number(:reputation, greater_than_or_equal_to: 0)
  end
end
