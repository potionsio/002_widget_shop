defmodule WidgetShop.DemoTest do
  use WidgetShop.DataCase, async: true

  import ExUnit.CaptureIO

  alias WidgetShop.Demo
  alias WidgetShop.Inventory.Widget

  test "reset!/0 restores the canonical demo inventory" do
    Repo.insert!(%Widget{
      name: "Stray Widget",
      price: Decimal.new("1.00"),
      listed_on: Date.utc_today(),
      price_reduced: true
    })

    output = capture_io(fn -> Demo.reset!() end)
    assert output =~ "Seeded 8 widgets"

    widgets = Repo.all(Widget)
    assert length(widgets) == 8
    refute Enum.any?(widgets, & &1.price_reduced)

    # Three widgets must be listed more than 30 days ago so the
    # screencast's repricing task always has work to do after a reset.
    cutoff = Date.add(Date.utc_today(), -30)
    stale = Enum.filter(widgets, &(Date.compare(&1.listed_on, cutoff) != :gt))
    assert length(stale) == 3
  end
end
