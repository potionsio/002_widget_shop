defmodule WidgetShopWeb.StoreLiveTest do
  use WidgetShopWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias WidgetShop.Inventory.Widget
  alias WidgetShop.Repo

  defp insert_widget(attrs) do
    defaults = %{
      name: "Test Widget",
      price: Decimal.new("10.00"),
      listed_on: Date.utc_today(),
      price_reduced: false
    }

    Repo.insert!(struct!(Widget, Map.merge(defaults, attrs)))
  end

  test "lists the widgets for sale", %{conn: conn} do
    flange = insert_widget(%{name: "Brass Flange", price: Decimal.new("18.50")})
    sprocket = insert_widget(%{name: "Reversible Sprocket"})

    {:ok, view, _html} = live(conn, ~p"/")

    assert has_element?(view, "#widgets")
    assert has_element?(view, "#widgets-#{flange.id}", "Brass Flange")
    assert has_element?(view, "#widgets-#{flange.id}", "$18.50")
    assert has_element?(view, "#widgets-#{sprocket.id}", "Reversible Sprocket")
  end

  test "shows the price reduced badge only on reduced widgets", %{conn: conn} do
    reduced = insert_widget(%{name: "Chrome Doohickey", price_reduced: true})
    regular = insert_widget(%{name: "Deluxe Doodad"})

    {:ok, view, _html} = live(conn, ~p"/")

    assert has_element?(view, "#widgets-#{reduced.id} .badge", "Price reduced")
    refute has_element?(view, "#widgets-#{regular.id} .badge")
  end

  test "shows an empty state when there are no widgets", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/")

    assert has_element?(view, "#widgets-empty")
  end
end
