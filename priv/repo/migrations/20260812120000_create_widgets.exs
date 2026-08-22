defmodule WidgetShop.Repo.Migrations.CreateWidgets do
  use Ecto.Migration

  def change do
    create table(:widgets) do
      add :name, :string, null: false
      add :price, :decimal, precision: 8, scale: 2, null: false
      add :listed_on, :date, null: false
      add :price_reduced, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
