defmodule He4rt.Views.JsonView do
  @moduledoc """
  View dedicated to handle responses as JSON
  """
  alias He4rt.Utils.JSON

  @doc """
  Based on response type, return it as JSON to API
  """
  @spec handle_response(map | struct | list | any) :: map | list
  def handle_response(response) when is_list(response), do: JSON.serialize(response)
  def handle_response(response) when is_map(response), do: JSON.serialize(response)
  def handle_response(response), do: JSON.serialize(%{"response" => response})
end
