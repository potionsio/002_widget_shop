# WidgetShop

Fine widgets, competitively priced.

WidgetShop is the demo app for the [Potions](https://potions.io) screencast on running one-off and scheduled tasks in Elixir releases. It's a small store that lists widgets with prices and listing dates - the screencast adds a recurring task that reprices any widget listed for more than 30 days.

To start your Phoenix server:

* Run `mix setup` to install and setup dependencies. This also seeds the store with the demo inventory (three of the widgets are listed more than 30 days ago on purpose).
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

To restore the demo inventory at any time, run `mix run priv/repo/seeds.exs` in development, or on a deployed release:

    bin/widget_shop rpc "WidgetShop.Demo.reset!()"

## Learn more

* Official website: https://www.phoenixframework.org/
* Guides: https://phoenix.hexdocs.pm/overview.html
* Docs: https://phoenix.hexdocs.pm
* Forum: https://elixirforum.com/c/phoenix-forum
* Source: https://github.com/phoenixframework/phoenix
