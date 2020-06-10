defmodule He4rt.Endpoint do
  @moduledoc false
  use Plug.Builder

  plug Plug.RequestId

  plug Plug.Logger
  plug Plug.MethodOverride
  plug Plug.Head

  plug He4rt.Plugs.Params
  plug He4rt.Router

  plug  Plug.Parsers, parsers: [:urlencoded, :multipart, :json], pass: ["*/*"], json_decoder: Poison
end
