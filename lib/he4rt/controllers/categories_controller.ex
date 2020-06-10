defmodule He4rt.Controllers.CategoriesController do
  @moduledoc """
  Handle categories 
  """
  use Plug.Builder
  import He4rt.Views.{JsonView, ErrorView}

  alias He4rt.Modules.Categories

  @doc """
  Retrieve all categories 
  """
  @spec index(Plug.Conn.t, map()) :: Plug.Conn.t
  def index(%Plug.Conn{} = conn, _params) do
    case Categories.retrieve_all() do
      {:ok, categories} ->
        conn |> send_resp(200, categories |> handle_response())

      {:error, reason} ->
        conn |> send_error({:error, reason})
    end
  end

  @doc """
  Retrieve one category by ID 
  """
  @spec show(Plug.Conn.t, map()) :: Plug.Conn.t
  def show(%Plug.Conn{} = conn, %{"category_id" => category_id}) do
    case Categories.get(category_id) do
      {:ok, category} ->
        conn |> send_resp(200, category |> handle_response())

      {:error, reason} ->
        conn |> send_error({:error, reason})
    end
  end

  @doc """
  Create new category 
  """
  @spec create(Plug.Conn.t, map()) :: Plug.Conn.t
  def create(%Plug.Conn{} = conn, params) do
    case Categories.create(params) do
      {:ok, category} ->
        conn |> send_resp(201, category |> handle_response())

      {:error, reason} ->
        conn |> send_error({:error, reason})
    end
  end

  @doc """
  Update one category by ID 
  """
  @spec update(Plug.Conn.t, map()) :: Plug.Conn.t
  def update(%Plug.Conn{} = conn, %{"category_id" => _category_id} = params) do
    case Categories.update(params) do
      {:ok, category} ->
        conn |> send_resp(200, category |> handle_response())

      {:error, reason} ->
        conn |> send_error({:error, reason})
    end
  end

  @doc """
  Remove one category by ID 
  """
  @spec remove(Plug.Conn.t, map()) :: Plug.Conn.t
  def remove(%Plug.Conn{} = conn, %{"category_id" => category_id}) do
    case Categories.remove(category_id) do
      {:ok, _category} ->
        conn |> send_resp(204, "")

      {:error, reason} ->
        conn |> send_error({:error, reason})
    end
  end
end
