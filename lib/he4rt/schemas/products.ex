defmodule He4rt.Schemas.Product do
  @moduledoc """
  Schema definition for `products` table
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias He4rt.Schemas.Category

  @typedoc """
  Product type
  """
  @type t :: %__MODULE__{
    id: pos_integer(), 
    name: String.t,
    description: String.t,
    price: Decimal.t,
    category: Category.t,
    category_id: pos_integer(),
    created_at: DateTime.t,
    updated_at: DateTime.t
  }

  @fields ~w(
    id
    name
    description
    price
    category
    created_at
    updated_at
  )a

  @primary_key {:id, :id, autogenerate: true}
  @derive {Poison.Encoder, only: @fields}

  schema "products" do
    field :name, :string
    field :description, :string
    field :price, :decimal

    belongs_to :category, Category

    timestamps(inserted_at: :created_at)
  end

  @doc false
  def changeset(%__MODULE__{} = schema, attrs) when is_map(attrs) do
    schema
    |> cast(attrs, ~w(name description price category_id)a)
    |> foreign_key_constraint(:category_id)
  end
end
