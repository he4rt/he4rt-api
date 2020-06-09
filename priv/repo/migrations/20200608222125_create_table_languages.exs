defmodule He4rt.Repo.Migrations.CreateTableLanguages do
  use Ecto.Migration

  def up do
    create_if_not_exists table(:languages) do
      add :name, :string

      timestamps(inserted_at: :created_at)
    end
  end

  def down do
    drop_if_exists table(:languages)
  end
end
