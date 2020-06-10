defmodule He4rt.Routes.HealthRouter do
  @moduledoc false
  use Plug.Router
  import He4rt.Views.ErrorView
  import He4rt.Controllers.HealthController

  plug :match
  plug :dispatch

  get "/",
    do: check(conn, conn.assigns.params)

  match _ do
    conn
    |> route_not_found()
  end
end
