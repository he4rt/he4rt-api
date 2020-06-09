defmodule He4rt.Plugs.Params do
  @moduledoc """
  Middleware responsible to generate params map with all request data (body, path, query string)
  """
  import Plug.Conn

  @spec init(List.t()) :: List.t()
  def init(opts) do
    opts
  end

  @spec call(Plug.Conn.t(), List.t()) :: Plug.Conn.t()
  def call(conn, _opts) do
    conn_params = if Map.has_key?(conn.assigns, :params), do: conn.assigns.params, else: %{}

    params =
      case get_params(conn) do
        %{params: params} ->
          params

        params ->
          params
      end
      |> Map.merge(conn_params)

    conn
    |> put_resp_content_type("application/json")
    |> assign(:params, params)
  end

  @spec get_params(Plug.Conn.t()) :: Map.t()
  def get_params(%Plug.Conn{assigns: %{params: params}, path_params: %{"glob" => _glob} = path_params}) do
    params
    |> Map.merge(path_params)
    |> Map.delete("glob")
  end
  def get_params(%Plug.Conn{path_params: _path_params} = conn) do
    case read_body(conn) do
      {:ok, body, conn} ->
        case body do
          "" ->
            params =
              conn
              |> fetch_query_params()

            params.query_params

          body ->
            Poison.decode!(body)
        end

      _body ->
        %{}
    end
  end
end
