defmodule He4rt.Routes.UsersRouter do
  @moduledoc false
  use Plug.Router
  import He4rt.Controllers.UsersController
  import He4rt.Views.ErrorView

  plug :match
  plug He4rt.Plugs.Params
  plug He4rt.Plugs.Authentications
  plug :dispatch

  get "/",
    do: index(conn, conn.assigns.params)

  get "/:discord_id",
    do: show(conn, conn.assigns.params)

  put "/:discord_id",
    do: update(conn, conn.assigns.params)

  post "/",
    do: create(conn, conn.assigns.params)

  delete "/:discord_id",
    do: remove(conn, conn.assigns.params)

  post "/:discord_id/levelup",
    do: levelup(conn, conn.assigns.params)


  match _ do
    conn
    |> route_not_found()
  end
end
