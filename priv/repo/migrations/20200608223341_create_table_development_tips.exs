defmodule He4rt.Repo.Migrations.CreateTableDevelopmentTips do
  use Ecto.Migration

  def up do
    create_if_not_exists table(:development_tips) do
      add :language_id, references(:languages)
      add :tip, :text
      add :used, :boolean, default: false

      timestamps(inserted_at: :created_at)
    end
  end

  def down do
    drop_if_exists table(:development_tips)
  end
end
