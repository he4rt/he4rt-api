defmodule He4rt.Support.Fixtures.Store do
  @moduledoc false

  alias He4rt.Support.Fixtures.{Users, Products}

  @doc """
  Create store parameters with invalid foreign key
  """
  @spec params(atom()) :: map
  def params(:invalid_product_id),
    do: %{
      discord_id: Users.insert() |> Map.get(:discord_id) |> to_string(),
      product_id: DateTime.utc_now() |> DateTime.to_unix()
    }

  def params(:invalid_discord_id),
    do: %{
      discord_id: DateTime.utc_now() |> DateTime.to_unix(),
      product_id: Products.insert() |> Map.get(:id)
    }

  @doc """
  Create store parameters with valid data
  """
  @spec params() :: map
  def params(),
    do: %{
      discord_id: Users.insert() |> Map.get(:discord_id) |> to_string(),
      product_id: Products.insert() |> Map.get(:id)
    }
end
