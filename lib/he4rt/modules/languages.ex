defmodule He4rt.Modules.Languages do
  @moduledoc """
  The Languages context.

  Handle languages from Database
  """
  import Ecto.Query

  alias He4rt.Repo
  alias He4rt.Schemas.Language

  @preload []

  @doc """
  Retrieve one language by ID
  """
  @spec get(language_id :: pos_integer()) :: {:ok, Language.t} | {:error, term}
  def get(language_id) when is_integer(language_id) do
    from(
      m in Language,
      where: m.id == ^language_id,
      preload: ^@preload
    )
    |> Repo.one()
    |> case do
      nil ->
        {:error, :not_found}

      language ->
        {:ok, language}
    end
  end

  @doc """
  Retrieve one language by name
  """
  @spec get_from_name(name :: String.t) :: {:ok, Language.t} | {:error, term}
  def get_from_name(name) when is_binary(name) do
    from(
      m in Language,
      where: m.name == ^name,
      preload: ^@preload
    )
    |> Repo.one()
    |> case do
      nil ->
        {:error, :not_found}

      language ->
        {:ok, language}
    end
  end

  @doc """
  Retrieve all languages
  """
  @spec retrieve_all() :: {:ok, list(Language.t)} | {:error, term}
  def retrieve_all() do
    from(
      m in Language,
      preload: ^@preload,
      order_by: [desc: m.created_at]
    )
    |> Repo.all()
    |> case do
      [] ->
        {:error, :not_found}

      languages ->
        {:ok, languages}
    end
  end

  @doc """
  Create new language
  """
  @spec create(attrs :: map()) :: {:ok, Language.t} | {:error, term}
  def create(attrs) when is_map(attrs) do
    %Language{}
    |> Language.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, language} ->
        language =
          language
          |> Repo.preload(@preload)

        {:ok, language}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Update existent language
  """
  @spec update(attrs :: map()) :: {:ok, Language.t} | {:error, term}
  def update(%{"language_id" => language_id} = attrs) when is_integer(language_id) and is_map(attrs) do
    with {:ok, language} <- get(language_id) do
      language
      |> Language.changeset(attrs)
      |> Repo.update()
      |> case do
        {:ok, language} ->
          language =
            language
            |> Repo.preload(@preload)

          {:ok, language}

        {:error, reason} ->
          {:error, reason}
      end
    end
  end
end
