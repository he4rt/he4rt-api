defmodule He4rt.Repo.Migrations.CreateTableUserProducts do
  use Ecto.Migration

  def up do
    create_if_not_exists table(:user_products) do
      add :user_id, references(:users)
      add :product_id, references(:products)

      timestamps(inserted_at: :created_at)
    end
  end

  def down do
    drop_if_exists table(:user_products)
  end
end
