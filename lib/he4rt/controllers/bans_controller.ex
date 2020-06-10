defmodule He4rt.Controllers.BansController do
  @moduledoc """
  Handle bans 
  """
  use Plug.Builder
  import He4rt.Views.{JsonView, ErrorView}

  alias He4rt.Modules.Bans

  @doc """
  Retrieve all bans 
  """
  @spec index(Plug.Conn.t, map()) :: Plug.Conn.t
  def index(%Plug.Conn{} = conn, _params) do
    case Bans.retrieve_all() do
      {:ok, bans} ->
        conn |> send_resp(200, bans |> handle_response())

      {:error, reason} ->
        conn |> send_error({:error, reason})
    end
  end

  @doc """
  Create new ban 
  """
  @spec create(Plug.Conn.t, map()) :: Plug.Conn.t
  def create(%Plug.Conn{} = conn, params) do
    case Bans.create(params) do
      {:ok, ban} ->
        conn |> send_resp(201, ban |> handle_response())

      {:error, reason} ->
        conn |> send_error({:error, reason})
    end
  end

  @doc """
  Revoke ban by ID 
  """
  @spec revoke(Plug.Conn.t, map()) :: Plug.Conn.t
  def revoke(%Plug.Conn{} = conn, %{"ban_id" => ban_id}) do
    %{
      "ban_id" => ban_id,
      "revoked" => true
    }
    |> Bans.update()
    |> case do
      {:ok, ban} ->
        conn |> send_resp(200, ban |> handle_response())

      {:error, reason} ->
        conn |> send_error({:error, reason})
    end
  end
end
