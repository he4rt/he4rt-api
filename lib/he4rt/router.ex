defmodule He4rt.Router do
  use Plug.Router
  import He4rt.Views.V1.ErrorView

  plug :match
  plug :dispatch

  match _ do
    conn
    |> route_not_found()
  end
end
