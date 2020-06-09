defmodule He4rt.Schemas.UserProduct do
  @moduledoc """
  Schema definition for `user_products` table
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias He4rt.Schemas.{User, Product}

  @typedoc """
  User Product type
  """
  @type t :: %__MODULE__{
    id: pos_integer(), 
    user: User.t,
    user_id: pos_integer(),
    product: Product.t,
    product_id: pos_integer(),
    created_at: DateTime.t,
    updated_at: DateTime.t
  }

  @fields ~w(
    id
    user
    product
    created_at
    updated_at
  )a

  @primary_key {:id, :id, autogenerate: true}
  @derive {Poison.Encoder, only: @fields}

  schema "user_products" do
    belongs_to :user, User
    belongs_to :product, Product

    timestamps(inserted_at: :created_at)
  end

  @doc false
  def changeset(%__MODULE__{} = schema, attrs) when is_map(attrs) do
    schema
    |> cast(attrs, ~w(user_id product_id)a)
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:product_id)
  end
end
