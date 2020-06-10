defmodule He4rt.Router do
  @moduledoc false
  use Plug.Router
  import He4rt.Views.ErrorView

  plug :match
  plug :dispatch

  match _ do
    conn
    |> route_not_found()
  end
end
