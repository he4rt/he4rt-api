defmodule He4rt.Repo.Migrations.CreateTableLevelup do
  use Ecto.Migration

  def up do
    create_if_not_exists table(:levelup) do
      add :name, :string
      add :required_exp, :integer
    end
  end

  def down do
    drop_if_exists table(:levelup)
  end
end
