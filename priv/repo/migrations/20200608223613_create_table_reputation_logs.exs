defmodule He4rt.Repo.Migrations.CreateTableReputationLogs do
  use Ecto.Migration

  def up do
    create_if_not_exists table(:reputation_logs) do
      add :user_id, references(:users)
      add :receiver_id, references(:users)

      timestamps(inserted_at: :created_at)
    end
  end

  def down do
    drop_if_exists table(:reputation_logs)
  end
end
