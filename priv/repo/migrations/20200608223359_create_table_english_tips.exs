defmodule He4rt.Repo.Migrations.CreateTableEnglishTips do
  use Ecto.Migration

  def up do
    create_if_not_exists table(:english_tips) do
      add :tip, :text
      add :used, :boolean, default: false

      timestamps(inserted_at: :created_at)
    end
  end

  def down do
    drop_if_exists table(:english_tips)
  end
end
