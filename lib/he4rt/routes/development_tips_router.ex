defmodule He4rt.Routes.DevelopmentTipsRouter do
  @moduledoc false
  use Plug.Router
  import He4rt.Controllers.DevelopmentTipsController
  import He4rt.Views.ErrorView

  plug :match
  plug He4rt.Plugs.Params
  plug He4rt.Plugs.Authentications
  plug :dispatch

  get "/",
    do: index(conn, conn.assigns.params)

  post "/",
    do: create(conn, conn.assigns.params)

  delete "/:development_tip_id",
    do: remove(conn, conn.assigns.params)

  match _ do
    conn
    |> route_not_found()
  end
end
