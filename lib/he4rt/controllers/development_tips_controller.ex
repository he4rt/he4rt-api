defmodule He4rt.Controllers.DevelopmentTipsController do
  @moduledoc """
  Handle categories 
  """
  use Plug.Builder
  import He4rt.Views.{JsonView, ErrorView}

  alias He4rt.Modules.DevelopmentTips

  @doc """
  Retrieve all development tips 
  """
  @spec index(Plug.Conn.t, map()) :: Plug.Conn.t
  def index(%Plug.Conn{} = conn, _params) do
    case DevelopmentTips.retrieve_all() do
      {:ok, development_tips} ->
        conn |> send_resp(200, development_tips |> handle_response())

      {:error, reason} ->
        conn |> send_error({:error, reason})
    end
  end

  @doc """
  Create new development tip 
  """
  @spec create(Plug.Conn.t, map()) :: Plug.Conn.t
  def create(%Plug.Conn{} = conn, params) do
    case DevelopmentTips.create(params) do
      {:ok, development_tip} ->
        conn |> send_resp(201, development_tip |> handle_response())

      {:error, reason} ->
        conn |> send_error({:error, reason})
    end
  end

  @doc """
  Remove one development tip by ID 
  """
  @spec remove(Plug.Conn.t, map()) :: Plug.Conn.t
  def remove(%Plug.Conn{} = conn, %{"development_tip_id" => development_tip_id}) do
    case DevelopmentTips.remove(development_tip_id) do
      {:ok, _development_tip} ->
        conn |> send_resp(204, "")

      {:error, reason} ->
        conn |> send_error({:error, reason})
    end
  end
end
