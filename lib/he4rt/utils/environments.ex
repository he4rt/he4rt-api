defmodule He4rt.Utils.Environments do
  @moduledoc """
  Handle environment variables from config based on pattern matching
  # Examples
  ```
  iex> Environments.get_env({:system, "ENV_VAR"})
  "42 is the answer"

  iex> Environments.get_json_env({:system, "ENV_VAR2"})
  %{"answer" => "42 is the answer"}
  ```
  """

  @doc """
  Return environment variable from config based on pattern matching
  """
  @spec get_env(any) :: any
  def get_env(env_var) when is_integer(env_var), do: env_var
  def get_env(env_var) when is_binary(env_var), do: env_var
  def get_env({:system, env_var}), do: get_env(System.get_env(env_var))
  def get_env({:system, env_var, :number}), do: get_env(System.get_env(env_var)) |> String.to_integer()
  def get_env({:system, env_var, :atom}), do: get_env(System.get_env(env_var)) |> String.to_atom()
  def get_env(env_var), do: env_var

  @doc """
  Return environment variable as JSON from config based on pattern matching
  """
  @spec get_json_env(any) :: false | nil | true | binary | [any] | number | map
  def get_json_env(env_var) when is_integer(env_var), do: %{}
  def get_json_env(env_var) when is_binary(env_var), do: Poison.decode!(env_var)
  def get_json_env({:system, env_var}), do: Poison.decode!(get_env(System.get_env(env_var)))
  def get_json_env(_env_var), do: %{}
end
