defmodule He4rt.Controllers.CouponsController do
  @moduledoc """
  Handle coupons 
  """
  use Plug.Builder
  import He4rt.Views.{JsonView, ErrorView}

  alias He4rt.Modules.Coupons

  @doc """
  Create new coupon 
  """
  @spec create(Plug.Conn.t, map()) :: Plug.Conn.t
  def create(%Plug.Conn{} = conn, params) do
    case Coupons.create(params) do
      {:ok, coupon} ->
        conn |> send_resp(201, coupon |> handle_response())

      {:error, reason} ->
        conn |> send_error({:error, reason})
    end
  end
end
