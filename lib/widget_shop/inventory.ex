defmodule WidgetShop.Inventory do
  @moduledoc """
  The Inventory context: the widgets we have for sale.
  """

  import Ecto.Query

  alias WidgetShop.Inventory.Widget
  alias WidgetShop.Repo

  @discount Decimal.new("0.90")

  def stale_count do
    Repo.aggregate(stale_query(), :count)
  end

  def reprice_stale do
    {repriced_count, _} =
      stale_query()
      |> update([w],
        set: [
          price: fragment("round(? * ?, 2)", w.price, ^@discount),
          price_reduced: true,
          updated_at: ^DateTime.utc_now()
        ]
      )
      |> Repo.update_all([])

    IO.puts("Reduced #{repriced_count} stale widgets")
  end

  defp stale_query do
    cutoff = Date.add(Date.utc_today(), -30)

    from w in Widget,
      where: w.listed_on <= ^cutoff and w.price_reduced == false
  end

  @doc """
  Returns all widgets, newest listings first.
  """
  def list_widgets do
    Repo.all(from w in Widget, order_by: [desc: w.listed_on, asc: w.name])
  end
end
