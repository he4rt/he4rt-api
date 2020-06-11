defmodule He4rt.Controllers.RankingController do
  @moduledoc """
  Handle rankings 
  """
  use Plug.Builder
  import He4rt.Views.{JsonView, ErrorView}

  alias He4rt.Modules.Users

  @doc """
  Retrieve all rankings 
  """
  @spec index(Plug.Conn.t, map()) :: Plug.Conn.t
  def index(%Plug.Conn{} = conn, %{"reputation" => "true"}) do
    case Users.retrieve_ranking_by_reputation() do
      {:ok, rankings} ->
        conn |> send_resp(200, rankings |> handle_response())

      {:error, reason} ->
        conn |> send_error({:error, reason})
    end
  end
  def index(%Plug.Conn{} = conn, _params) do
    case Users.retrieve_ranking_by_level() do
      {:ok, rankings} ->
        conn |> send_resp(200, rankings |> handle_response())

      {:error, reason} ->
        conn |> send_error({:error, reason})
    end
  end
end
