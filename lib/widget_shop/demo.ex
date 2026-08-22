defmodule WidgetShop.Demo do
  @moduledoc """
  Demo data for the store.

  `reset!/0` restores the inventory to its canonical seed state and is
  safe to run repeatedly. `priv/repo/seeds.exs` calls it in development,
  and on a deployed release (where Mix isn't available) it can be run
  with:

      bin/widget_shop rpc "WidgetShop.Demo.reset!()"

  Listing dates are computed relative to today, so a fresh reset always
  yields three widgets listed more than 30 days ago and five recent ones.
  """

  alias WidgetShop.Inventory.Widget
  alias WidgetShop.Repo

  @widgets [
    {"Self-Sealing Stem Bolt", "24.00", 52},
    {"Brass Flange", "18.50", 45},
    {"Reversible Sprocket", "32.00", 38},
    {"Chrome Doohickey", "12.75", 13},
    {"Ambidextrous Grommet", "9.25", 10},
    {"Precision Thingamajig", "45.00", 7},
    {"Industrial Whatsit", "27.50", 3},
    {"Deluxe Doodad", "54.00", 1}
  ]

  def reset! do
    Repo.delete_all(Widget)

    for {name, price, days_ago} <- @widgets do
      Repo.insert!(%Widget{
        name: name,
        price: Decimal.new(price),
        listed_on: Date.add(Date.utc_today(), -days_ago),
        price_reduced: false
      })
    end

    IO.puts("Seeded #{length(@widgets)} widgets")
    :ok
  end
end
