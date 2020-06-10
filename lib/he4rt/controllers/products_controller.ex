defmodule He4rt.Controllers.ProductsController do
  @moduledoc """
  Handle products 
  """
  use Plug.Builder
  import He4rt.Views.{JsonView, ErrorView}

  alias He4rt.Modules.Products

  @doc """
  Retrieve all products 
  """
  @spec index(Plug.Conn.t, map()) :: Plug.Conn.t
  def index(%Plug.Conn{} = conn, _params) do
    case Products.retrieve_all() do
      {:ok, products} ->
        conn |> send_resp(200, products |> handle_response())

      {:error, reason} ->
        conn |> send_error({:error, reason})
    end
  end

  @doc """
  Retrieve one product by ID 
  """
  @spec show(Plug.Conn.t, map()) :: Plug.Conn.t
  def show(%Plug.Conn{} = conn, %{"product_id" => product_id}) do
    case Products.get(product_id) do
      {:ok, product} ->
        conn |> send_resp(200, product |> handle_response())

      {:error, reason} ->
        conn |> send_error({:error, reason})
    end
  end

  @doc """
  Create new product 
  """
  @spec create(Plug.Conn.t, map()) :: Plug.Conn.t
  def create(%Plug.Conn{} = conn, params) do
    case Products.create(params) do
      {:ok, product} ->
        conn |> send_resp(201, product |> handle_response())

      {:error, reason} ->
        conn |> send_error({:error, reason})
    end
  end

  @doc """
  Update one product by ID 
  """
  @spec update(Plug.Conn.t, map()) :: Plug.Conn.t
  def update(%Plug.Conn{} = conn, %{"product_id" => _product_id} = params) do
    case Products.update(params) do
      {:ok, product} ->
        conn |> send_resp(200, product |> handle_response())

      {:error, reason} ->
        conn |> send_error({:error, reason})
    end
  end

  @doc """
  Remove one product by ID 
  """
  @spec remove(Plug.Conn.t, map()) :: Plug.Conn.t
  def remove(%Plug.Conn{} = conn, %{"product_id" => product_id}) do
    case Products.remove(product_id) do
      {:ok, _product} ->
        conn |> send_resp(204, "")

      {:error, reason} ->
        conn |> send_error({:error, reason})
    end
  end
end
