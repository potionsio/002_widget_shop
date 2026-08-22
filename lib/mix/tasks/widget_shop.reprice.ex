defmodule Mix.Tasks.WidgetShop.Reprice do
  @shortdoc "Reprices widgets that have been listed for 30+ days"
  use Mix.Task

  @requirements ["app.start"]

  @impl Mix.Task
  def run(_args) do
    WidgetShop.Inventory.reprice_stale()
  end
end
