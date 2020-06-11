defmodule He4rt.Routes.RankingRouter do
  @moduledoc false
  use Plug.Router
  import He4rt.Controllers.RankingController
  import He4rt.Views.ErrorView

  plug :match
  plug He4rt.Plugs.Params
  plug He4rt.Plugs.Authentications
  plug :dispatch

  get "/",
    do: index(conn, conn.assigns.params)

  match _ do
    conn
    |> route_not_found()
  end
end
