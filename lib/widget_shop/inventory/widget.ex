defmodule WidgetShop.Inventory.Widget do
  use Ecto.Schema
  import Ecto.Changeset

  schema "widgets" do
    field :name, :string
    field :price, :decimal
    field :listed_on, :date
    field :price_reduced, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(widget, attrs) do
    widget
    |> cast(attrs, [:name, :price, :listed_on, :price_reduced])
    |> validate_required([:name, :price, :listed_on])
    |> validate_number(:price, greater_than: 0)
  end
end
