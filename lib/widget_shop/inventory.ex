defmodule WidgetShop.Inventory do
  @moduledoc """
  The Inventory context: the widgets we have for sale.
  """

  import Ecto.Query

  alias WidgetShop.Inventory.Widget
  alias WidgetShop.Repo

  @doc """
  Returns all widgets, newest listings first.
  """
  def list_widgets do
    Repo.all(from w in Widget, order_by: [desc: w.listed_on, asc: w.name])
  end
end
