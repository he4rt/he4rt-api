defmodule He4rt.Controllers.CouponsController do
  @moduledoc """
  Handle coupons 
  """
  use Plug.Builder
  import He4rt.Views.{JsonView, ErrorView}

  alias He4rt.Modules.{Coupons, Users}

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

  @doc """
  Update new coupon to use with an user
  """
  @spec used(Plug.Conn.t, map()) :: Plug.Conn.t
  def used(%Plug.Conn{} = conn, %{"discord_id" => discord_id, "coupon" => coupon}) do
    case Users.get_from_discord_id(discord_id) do
      {:ok, user} ->
        case Coupons.get_from_name(coupon) do
          {:ok, coupon} ->
            case Coupons.update(%{"coupon_id" => coupon.id, "used" => true, "user_id" => user.id}) do
              {:ok, coupon} ->
                conn |> send_resp(200, coupon |> handle_response())

              {:error, reason} ->
                conn |> send_error({:error, reason})
            end

          {:error, reason} ->
            conn |> send_error({:error, reason})
        end

      {:error, reason} ->
        conn |> send_error({:error, reason})
    end
  end
end
