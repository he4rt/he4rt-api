defmodule He4rt.Controllers.StoreController do
  @moduledoc """
  Handle store 
  """
  use Plug.Builder
  import He4rt.Views.{JsonView, ErrorView}

  alias He4rt.Modules.{Users, Products, UserProducts}

  @doc """
  Buy a product for discord user 
  """
  @spec buy(Plug.Conn.t, map()) :: Plug.Conn.t
  def buy(%Plug.Conn{} = conn, %{"product_id" => product_id, "discord_id" => discord_id}) do
    case Users.get_from_discord_id(discord_id) do
      {:ok, user} ->
        case Products.get(product_id) do
          {:ok, product} ->
            money = user.money
            price = product.price

            money
            |> Decimal.sub(price)
            |> Decimal.positive?()
            |> if do
              case UserProducts.create(%{product_id: product.id, user_id: user.id}) do
                {:ok, _user_product} ->
                  new_money = Decimal.sub(money, price)
                  case Users.update(%{"discord_id" => discord_id, "money" => new_money}) do
                    {:ok, user} ->
                      conn |> send_resp(201, %{user: user, product: product} |> handle_response())
                    
                    {:error, reason} ->
                      conn |> send_error({:error, reason})
                  end

                {:error, reason} ->
                  conn |> send_error({:error, reason})
              end  
            else
              conn |> send_error({:error, "Insufficient funds"})
            end

            case UserProducts.create(%{product_id: product.id, user_id: user.id}) do
              {:ok, _user_product} ->
                conn |> send_resp(201, %{user: user, product: product} |> handle_response())

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
