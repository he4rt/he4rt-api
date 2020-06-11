defmodule He4rt.Modules.EnglishTips do
  @moduledoc """
  The English Tips context.

  Handle english tips from Database
  """
  import Ecto.Query

  alias He4rt.Repo
  alias He4rt.Schemas.EnglishTip

  @preload []

  @doc """
  Retrieve one english tip by ID
  """
  @spec get(english_tip_id :: pos_integer()) :: {:ok, EnglishTip.t} | {:error, term}
  def get(english_tip_id) when is_integer(english_tip_id) do
    from(
      m in EnglishTip,
      where: m.id == ^english_tip_id,
      preload: ^@preload
    )
    |> Repo.one()
    |> case do
      nil ->
        {:error, :not_found}

      english_tip ->
        {:ok, english_tip}
    end
  end

  @doc """
  Retrieve one english tip by language id
  """
  @spec get_from_language_id(language_id :: pos_integer()) :: {:ok, EnglishTip.t} | {:error, term}
  def get_from_language_id(language_id) when is_integer(language_id) do
    from(
      m in EnglishTip,
      where: m.language_id == ^language_id,
      preload: ^@preload
    )
    |> Repo.one()
    |> case do
      nil ->
        {:error, :not_found}

      english_tip ->
        {:ok, english_tip}
    end
  end

  @doc """
  Retrieve all english tips
  """
  @spec retrieve_all() :: {:ok, list(EnglishTip.t)} | {:error, term}
  def retrieve_all() do
    from(
      m in EnglishTip,
      preload: ^@preload,
      order_by: [desc: m.created_at]
    )
    |> Repo.all()
    |> case do
      [] ->
        {:error, :not_found}

      english_tips ->
        {:ok, english_tips}
    end
  end

  @doc """
  Create new english tip
  """
  @spec create(attrs :: map()) :: {:ok, EnglishTip.t} | {:error, term}
  def create(attrs) when is_map(attrs) do
    %EnglishTip{}
    |> EnglishTip.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, english_tip} ->
        english_tip =
          english_tip
          |> Repo.preload(@preload)

        {:ok, english_tip}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Update existent english tip
  """
  @spec update(attrs :: map()) :: {:ok, EnglishTip.t} | {:error, term}
  def update(%{"english_tip_id" => english_tip_id} = attrs) when is_integer(english_tip_id) and is_map(attrs) do
    with {:ok, english_tip} <- get(english_tip_id) do
      english_tip
      |> EnglishTip.changeset(attrs)
      |> Repo.update()
      |> case do
        {:ok, english_tip} ->
          english_tip =
            english_tip
            |> Repo.preload(@preload)

          {:ok, english_tip}

        {:error, reason} ->
          {:error, reason}
      end
    end
  end

  @doc """
  Remove existent english tip
  """
  @spec remove(english_tip_id :: pos_integer()) :: {:ok, EnglishTip.t} | {:error, term}
  def remove(english_tip_id) when is_integer(english_tip_id) do
    with {:ok, english_tip} <- get(english_tip_id) do
      english_tip
      |> Repo.delete()
    end
  end
end
