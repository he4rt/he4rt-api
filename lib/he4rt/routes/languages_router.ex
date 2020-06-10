defmodule He4rt.Routes.LanguagesRouter do
  @moduledoc false
  use Plug.Router
  import He4rt.Controllers.LanguagesController
  import He4rt.Views.ErrorView

  plug :match
  plug He4rt.Plugs.Params
  plug He4rt.Plugs.Authentications
  plug :dispatch

  get "/",
    do: index(conn, conn.assigns.params)

  get "/:language_id",
    do: show(conn, conn.assigns.params)

  match _ do
    conn
    |> route_not_found()
  end
end
