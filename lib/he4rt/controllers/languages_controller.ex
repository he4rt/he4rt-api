defmodule He4rt.Controllers.LanguagesController do
  @moduledoc """
  Handle languages 
  """
  use Plug.Builder
  import He4rt.Views.{JsonView, ErrorView}

  alias He4rt.Modules.Languages

  @doc """
  Retrieve all languages 
  """
  @spec index(Plug.Conn.t, map()) :: Plug.Conn.t
  def index(%Plug.Conn{} = conn, _params) do
    case Languages.retrieve_all() do
      {:ok, languages} ->
        conn |> send_resp(200, languages |> handle_response())

      {:error, reason} ->
        conn |> send_error({:error, reason})
    end
  end

  @doc """
  Retrieve one language by ID 
  """
  @spec show(Plug.Conn.t, map()) :: Plug.Conn.t
  def show(%Plug.Conn{} = conn, %{"language_id" => language_id}) do
    case Languages.get(language_id) do
      {:ok, language} ->
        conn |> send_resp(200, language |> handle_response())

      {:error, reason} ->
        conn |> send_error({:error, reason})
    end
  end
end
