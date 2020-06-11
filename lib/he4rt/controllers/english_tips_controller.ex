defmodule He4rt.Controllers.EnglishTipsController do
  @moduledoc """
  Handle categories 
  """
  use Plug.Builder
  import He4rt.Views.{JsonView, ErrorView}

  alias He4rt.Modules.EnglishTips

  @doc """
  Retrieve all english tips 
  """
  @spec index(Plug.Conn.t, map()) :: Plug.Conn.t
  def index(%Plug.Conn{} = conn, _params) do
    case EnglishTips.retrieve_all() do
      {:ok, english_tips} ->
        conn |> send_resp(200, english_tips |> handle_response())

      {:error, reason} ->
        conn |> send_error({:error, reason})
    end
  end

  @doc """
  Create new english tip 
  """
  @spec create(Plug.Conn.t, map()) :: Plug.Conn.t
  def create(%Plug.Conn{} = conn, params) do
    case EnglishTips.create(params) do
      {:ok, english_tip} ->
        conn |> send_resp(201, english_tip |> handle_response())

      {:error, reason} ->
        conn |> send_error({:error, reason})
    end
  end

  @doc """
  Remove one english tip by ID 
  """
  @spec remove(Plug.Conn.t, map()) :: Plug.Conn.t
  def remove(%Plug.Conn{} = conn, %{"english_tip_id" => english_tip_id}) do
    case EnglishTips.remove(english_tip_id) do
      {:ok, _english_tip} ->
        conn |> send_resp(204, "")

      {:error, reason} ->
        conn |> send_error({:error, reason})
    end
  end
end
