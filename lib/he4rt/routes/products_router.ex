defmodule He4rt.Routes.ProductsRouter do
  @moduledoc false
  use Plug.Router
  import He4rt.Controllers.ProductsController
  import He4rt.Views.ErrorView

  plug :match
  plug He4rt.Plugs.Params
  plug He4rt.Plugs.Authentications
  plug :dispatch

  get "/",
    do: index(conn, conn.assigns.params)

  get "/:product_id",
    do: show(conn, conn.assigns.params)

  post "/",
    do: create(conn, conn.assigns.params)

  put "/:product_id",
    do: update(conn, conn.assigns.params)

  delete "/:product_id",
    do: remove(conn, conn.assigns.params)

  match _ do
    conn
    |> route_not_found()
  end
end
