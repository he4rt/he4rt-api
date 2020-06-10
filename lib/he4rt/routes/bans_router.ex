defmodule He4rt.Routes.BansRouter do
  @moduledoc false
  use Plug.Router
  import He4rt.Controllers.BansController
  import He4rt.Views.ErrorView

  plug :match
  plug He4rt.Plugs.Params
  plug He4rt.Plugs.Authentications
  plug :dispatch

  get "/",
    do: index(conn, conn.assigns.params)

  post "/",
    do: create(conn, conn.assigns.params)

  put "/:ban_id/revoke",
    do: revoke(conn, conn.assigns.params)

  match _ do
    conn
    |> route_not_found()
  end
end
