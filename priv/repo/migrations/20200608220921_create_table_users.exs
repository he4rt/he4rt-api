defmodule He4rt.Repo.Migrations.CreateTableUsers do
  use Ecto.Migration

  def up do
    create_if_not_exists table(:users) do
      add :discord_id, :string
      add :name, :string
      add :nickname, :string
      add :twitch, :string
      add :git, :string
      add :about, :text
      add :language, :string
      add :level, :integer, default: 1
      add :current_exp, :integer, default: 0
      add :money, :decimal, precision: 8, scale: 2
      add :daily, :naive_datetime
      add :reputation, :integer

      timestamps(inserted_at: :created_at)
    end
  end

  def down do
    drop_if_exists table(:users)
  end
end
