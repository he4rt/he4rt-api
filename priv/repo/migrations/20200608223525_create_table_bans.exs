defmodule He4rt.Repo.Migrations.CreateTableBans do
  use Ecto.Migration

  def up do
    create_if_not_exists table(:bans) do
      add :admin_id, :string, null: false
      add :victim_id, :string, null: false
      add :type, :string, null: false
      add :reason, :string, null: false
      add :time, :naive_datetime
      add :revoked, :boolean, default: false

      timestamps(inserted_at: :created_at)
    end
  end

  def down do
    drop_if_exists table(:bans)
  end
end
