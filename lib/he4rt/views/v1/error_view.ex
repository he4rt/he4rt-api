defmodule He4rt.Views.V1.ErrorView do
  @moduledoc """
  View dedicated to handle error responses as JSON
  """
  use Plug.Builder
  import He4rt.Views.V1.JsonView

  @error_regex ~r/\{(.*?)\}/

  @doc """
  Return error as 404 based on pattern matching {:error, reason} when `reason` is `:not_found`
  """
  @spec send_error(Plug.Conn.t(), {:error, any} | {:error, atom, String.t}) :: Plug.Conn.t()
  def send_error(%Plug.Conn{} = conn, {:error, :not_found}), do:
    conn
    |> send_resp(404, handle_response(%{errors: %{detail: "Resource not found"}}))
    |> halt()

  @doc """
  Return error as 404 based on pattern matching {:error, reason} when `reason` is `:machine_not_found`
  """
  def send_error(%Plug.Conn{} = conn, {:error, :machine_not_found}), do:
    conn
    |> send_resp(401, handle_response(%{errors: %{detail: "Unauthorized"}}))
    |> halt()

  @doc """
  Return error as 409 based on pattern matching {:error, reason} when `reason` is `:conflict`
  """
  def send_error(%Plug.Conn{} = conn, {:error, :conflict}), do:
    conn
    |> send_resp(409, handle_response(%{errors: %{detail: "Resource conflicted"}}))
    |> halt()

  @doc """
  Return error as 400 based on pattern matching {:error, reason} when `reason` is `:bad_request`
  """
  def send_error(%Plug.Conn{} = conn, {:error, :bad_request}), do:
    conn
    |> send_resp(400, handle_response(%{errors: %{detail: "Bad request"}}))
    |> halt()

  @doc """
  Return error as 500 based on pattern matching {:error, reason} when `reason` is `:internal_server_error`
  """
  def send_error(%Plug.Conn{} = conn, {:error, :internal_server_error}), do:
    conn
    |> send_resp(500, handle_response(%{errors: %{detail: "Internal server error"}}))
    |> halt()

  @doc """
  Return error as 501 based on pattern matching {:error, reason} when `reason` is `:not_implemented`
  """
  def send_error(%Plug.Conn{} = conn, {:error, :not_implemented}), do:
    conn
    |> send_resp(501, handle_response(%{errors: %{detail: "Functionality not implemented"}}))
    |> halt()

  @doc """
  Return error as 401 based on pattern matching {:error, reason} when `reason` is `:token_not_found`
  """
  def send_error(%Plug.Conn{} = conn, {:error, :token_not_found}), do:
    conn
    |> send_resp(401, handle_response(%{errors: %{detail: "Unauthorized"}}))
    |> halt()

  @doc """
  Return error as 408 based on pattern matching {:error, reason} when `reason` is `:timeout`
  """
  def send_error(%Plug.Conn{} = conn, {:error, :timeout}), do:
    conn
    |> send_resp(408, handle_response(%{errors: %{detail: "Timeout"}}))
    |> halt()

  @doc """
  Return error as 408 based on pattern matching {:error, reason} when `reason` is `:etimedout`
  """
  def send_error(%Plug.Conn{} = conn, {:error, :etimedout}), do:
    conn
    |> send_resp(408, handle_response(%{errors: %{detail: "Timeout"}}))
    |> halt()

  @doc """
  Return error as 408 based on pattern matching {:error, reason} when `reason` is `:closed`
  """
  def send_error(%Plug.Conn{} = conn, {:error, :closed}), do:
    conn
    |> send_resp(406, handle_response(%{errors: %{detail: "Acquirer closed our connection"}}))
    |> halt()

  @doc """
  Return error as 401 based on pattern matching {:error, reason} when `reason` is `:unauthorized`
  """
  def send_error(%Plug.Conn{} = conn, {:error, :unauthorized}), do:
    conn
    |> send_resp(401, handle_response(%{errors: %{detail: "Unauthorized"}}))
    |> halt()

  @doc """
  Return error as 400 based on pattern matching {:error, reason} when `reason` is a Ecto Changeset
  """
  def send_error(%Plug.Conn{} = conn, {:error, %Ecto.Changeset{} = changeset}), do:
    conn
    |> send_resp(422, handle_response(%{errors: %{detail: "Invalid parameters", fields: get_changeset_errors(changeset)}}))
    |> halt()

  @doc """
  Return error as 400 based on pattern matching {:error, reason} when `reason` is anything
  """
  def send_error(%Plug.Conn{} = conn, {:error, reason}), do:
    conn
    |> send_resp(400, handle_response(%{errors: %{detail: reason}}))
    |> halt()

  @doc """
  Return error as 404 when route wasn't found on all Router modules
  """
  @spec route_not_found(Plug.Conn.t()) :: Plug.Conn.t()
  def route_not_found(%Plug.Conn{} = conn), do:
    conn
    |> send_resp(404, handle_response(%{errors: %{detail: "Route not found"}}))
    |> halt()

@doc """
  Humanize errors from changeset
  """
  @spec get_changeset_errors(Ecto.Changeset.t()) :: map
  def get_changeset_errors(%Ecto.Changeset{errors: errors}) do
    errors
    |> Enum.reduce(%{}, fn {field, {reason, data}}, errors ->
      case Regex.scan(@error_regex, reason) do
        [] ->
          reason

        _fields ->
          data
          |> Enum.into(%{})
          |> Enum.reduce(reason, fn {key, value}, acc ->
            acc
            |> String.replace("%{#{key}}", to_string(value))
          end)
      end
      |> case do
        reason ->
          if Map.has_key?(errors, field) do
            reason =
              errors
              |> Map.get(field)
              |> Kernel.<>(";#{reason}")

            errors
            |> Map.put(field, reason)
          else
            errors
            |> Map.put(field, reason)
          end
      end
    end)
  end
end  
