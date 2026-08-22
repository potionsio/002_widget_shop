defmodule WidgetShop.Repo do
  use Ecto.Repo,
    otp_app: :widget_shop,
    adapter: Ecto.Adapters.Postgres
end
