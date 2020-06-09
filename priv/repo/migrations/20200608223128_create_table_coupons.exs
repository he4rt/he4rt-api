defmodule He4rt.Repo.Migrations.CreateTableCoupons do
  use Ecto.Migration

  def up do
    create_if_not_exists table(:coupons) do
      add :name, :string, null: false
      add :value, :integer, null: false
      add :used, :boolean, default: false
      add :type_id, references(:coupon_types), null: false
      add :user_id, references(:users)

      timestamps(inserted_at: :created_at)
    end
  end

  def down do
    drop_if_exists table(:coupons)
  end
end
