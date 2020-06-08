defmodule He4rt.Utils.JSON do
  @moduledoc """
  A JSON serializer to return to Cowboy API
  # Examples
  When returning an `Ecto Schema`:
  iex(1)> schema = Repo.get(User, id: 12345)
  iex(2)> JSON.serialize(schema)
  %{"test" => 123}
  """

  @exceptions [NaiveDateTime, DateTime, Date]

  @doc """
  Serialize structs, maps or list as JSON
  If the type isn't map, list or struct, it will return itself
  """
  @spec serialize(map | struct | list | any) :: any | list | map
  def serialize(map) when is_map(map) do
    map
    |> data_serialization()
    |> Poison.encode!()
  end
  def serialize(list) when is_list(list) do
    list
    |> Enum.map(&data_serialization/1)
    |> Poison.encode!()
  end
  def serialize(data), do: data

  @spec data_serialization(Map.t()) :: Map.t()
  defp data_serialization(%{__meta__: _meta} = schema) do
    schema
    |> Poison.encode!()
    |> Poison.decode!()
  end
  defp data_serialization({key, %{__struct__: struct} = val}) when struct in @exceptions, do: {key, val |> to_string()}
  defp data_serialization({key, val}) when is_map(val) or is_list(val), do: {key, serialize(val)}
  defp data_serialization(map), do: map
end
