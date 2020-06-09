defmodule He4rt.Repo.Migrations.CreateTableCoupounTypes do
  use Ecto.Migration

  def up do
    create_if_not_exists table(:coupon_types) do
      add :name, :string

      timestamps(inserted_at: :created_at)
    end
  end

  def down do
    drop_if_exists table(:coupon_types)
  end
end
