defmodule He4rt.Support.ConnCase do
  @moduledoc """
  Request using self-API for test environment
  """
  defmacro __using__(opts) do
    quote do
      use Plug.Test

      @doc """
      Sends `GET` request
      """
      @spec get(url :: String.t()) :: Plug.Conn.t()
      def get(url) when is_binary(url), do: conn(:get, url)

      @doc """
      Sends `POST` request
      """
      @spec post(url :: String.t(), body :: Map.t()) :: Plug.Conn.t()
      def post(url, body \\ %{}) when is_binary(url) and is_map(body), do: conn(:post, url, Poison.encode!(body))

      @doc """
      Sends `PUT` request
      """
      @spec put(url :: String.t(), body :: Map.t()) :: Plug.Conn.t()
      def put(url, body \\ %{}) when is_binary(url) and is_map(body), do: conn(:put, url, Poison.encode!(body))

      @doc """
      Sends `DELETE` request
      """
      @spec delete(url :: String.t()) :: Plug.Conn.t()
      def delete(url) when is_binary(url), do: conn(:delete, url)

      @doc """
      Sends `PATCH` request
      """
      @spec patch(url :: String.t()) :: Plug.Conn.t()
      def patch(url) when is_binary(url), do: conn(:patch, url)

      @doc """
      Request for self-API and handle response
      """
      @spec json_response(conn :: Plug.Conn.t(), status_code :: number) :: String.t() | nil | Exception
      def json_response(%Plug.Conn{} = conn, status_code) when is_number(status_code) do
        endpoint = unquote(opts[:endpoint])
        endpoint_opts = endpoint.init([])

        conn
        |> endpoint.call(endpoint_opts)
        |> case do
          %Plug.Conn{status: status, resp_body: body} when is_number(status) and is_binary(body) ->
            case Poison.decode(body) do
              {:ok, body} ->
                if status == status_code do
                  body
                else
                  raise "Expected status #{inspect status_code} but got #{inspect status}. Response: #{inspect body}"
                end

              _ ->
                if status == status_code do
                  nil
                else
                  raise "Expected status #{inspect status_code} but got #{inspect status}"
                end
            end
        end
      end

      @doc """
      Retrieve api key from environment
      """
      @spec get_api_key() :: String.t
      def get_api_key(),
        do: Application.fetch_env!(:he4rt, He4rt.Plugs.Authentications)
            |> Keyword.get(:api_key)
            |> He4rt.Utils.Environments.get_env() 
    end
  end
end
