defmodule He4rt.Controllers.HealthController do
  @moduledoc """
  Check if application still alive for monitoring his % of disponibility
  """
  use Plug.Builder
  import He4rt.Views.JsonView

  @doc """
  Return status 200 with empty JSON
  """
  @spec check(Plug.Conn.t, map()) :: Plug.Conn.t
  def check(%Plug.Conn{} = conn, _params) do
    conn |> send_resp(200, handle_response(%{}))
  end
end
