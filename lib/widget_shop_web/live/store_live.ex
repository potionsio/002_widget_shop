defmodule WidgetShopWeb.StoreLive do
  use WidgetShopWeb, :live_view

  alias WidgetShop.Inventory

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Store")
     |> stream(:widgets, Inventory.list_widgets())}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <div class="mb-10 space-y-2 text-center">
        <h1 class="text-4xl font-bold">WidgetShop</h1>
        <p class="text-base-content/70">Fine widgets, competitively priced.</p>
      </div>

      <div id="widgets" phx-update="stream" class="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
        <div id="widgets-empty" class="hidden only:block text-center text-base-content/60">
          The shelves are empty.
        </div>
        <div :for={{id, widget} <- @streams.widgets} id={id} class="card bg-base-200">
          <div class="card-body gap-1 p-5">
            <h2 class="card-title text-base">{widget.name}</h2>
            <div class="flex items-center gap-2">
              <span class="text-xl font-semibold">{price(widget)}</span>
              <span :if={widget.price_reduced} class="badge badge-warning badge-sm font-medium">
                Price reduced
              </span>
            </div>
            <p class="text-sm text-base-content/60">{listed_label(widget)}</p>
          </div>
        </div>
      </div>
    </Layouts.app>
    """
  end

  defp price(widget), do: "$#{Decimal.to_string(widget.price)}"

  defp listed_label(widget) do
    case Date.diff(Date.utc_today(), widget.listed_on) do
      0 -> "Listed today"
      1 -> "Listed 1 day ago"
      days -> "Listed #{days} days ago"
    end
  end
end
