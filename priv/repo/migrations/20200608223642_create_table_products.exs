defmodule He4rt.Repo.Migrations.CreateTableProducts do
  use Ecto.Migration

  def up do
    create_if_not_exists table(:products) do
      add :name, :string
      add :description, :text
      add :price, :decimal, precision: 8, scale: 2
      add :category_id, references(:categories)

      timestamps(inserted_at: :created_at)
    end
  end

  def down do
    drop_if_exists table(:products)
  end
end
