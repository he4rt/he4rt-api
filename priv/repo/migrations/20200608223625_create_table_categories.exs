defmodule He4rt.Repo.Migrations.CreateTableCategories do
  use Ecto.Migration

  def up do
    create_if_not_exists table(:categories) do
      add :name, :string

      timestamps(inserted_at: :created_at)
    end
  end

  def down do
    drop_if_exists table(:categories)
  end
end
