defmodule He4rt.Modules.DevelopmentTips do
  @moduledoc """
  The Development Tips context.

  Handle development tips from Database
  """
  import Ecto.Query

  alias He4rt.Repo
  alias He4rt.Schemas.DevelopmentTip

  @preload [:language]

  @doc """
  Retrieve one development tip by ID
  """
  @spec get(development_tip_id :: pos_integer()) :: {:ok, DevelopmentTip.t} | {:error, term}
  def get(development_tip_id) when is_integer(development_tip_id) do
    from(
      m in DevelopmentTip,
      where: m.id == ^development_tip_id,
      preload: ^@preload
    )
    |> Repo.one()
    |> case do
      nil ->
        {:error, :not_found}

      development_tip ->
        {:ok, development_tip}
    end
  end

  @doc """
  Retrieve one development tip by language id
  """
  @spec get_from_language_id(language_id :: pos_integer()) :: {:ok, DevelopmentTip.t} | {:error, term}
  def get_from_language_id(language_id) when is_integer(language_id) do
    from(
      m in DevelopmentTip,
      where: m.language_id == ^language_id,
      preload: ^@preload
    )
    |> Repo.one()
    |> case do
      nil ->
        {:error, :not_found}

      development_tip ->
        {:ok, development_tip}
    end
  end

  @doc """
  Retrieve all development tips
  """
  @spec retrieve_all() :: {:ok, list(DevelopmentTip.t)} | {:error, term}
  def retrieve_all() do
    from(
      m in DevelopmentTip,
      preload: ^@preload,
      order_by: [desc: m.created_at]
    )
    |> Repo.all()
    |> case do
      [] ->
        {:error, :not_found}

      development_tips ->
        {:ok, development_tips}
    end
  end

  @doc """
  Create new development tip
  """
  @spec create(attrs :: map()) :: {:ok, DevelopmentTip.t} | {:error, term}
  def create(attrs) when is_map(attrs) do
    %DevelopmentTip{}
    |> DevelopmentTip.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, development_tip} ->
        development_tip =
          development_tip
          |> Repo.preload(@preload)

        {:ok, development_tip}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Update existent development tip
  """
  @spec update(attrs :: map()) :: {:ok, DevelopmentTip.t} | {:error, term}
  def update(%{"development_tip_id" => development_tip_id} = attrs) when is_integer(development_tip_id) and is_map(attrs) do
    with {:ok, development_tip} <- get(development_tip_id) do
      development_tip
      |> DevelopmentTip.changeset(attrs)
      |> Repo.update()
      |> case do
        {:ok, development_tip} ->
          development_tip =
            development_tip
            |> Repo.preload(@preload)

          {:ok, development_tip}

        {:error, reason} ->
          {:error, reason}
      end
    end
  end

  @doc """
  Remove existent development tip
  """
  @spec remove(development_tip_id :: pos_integer()) :: {:ok, DevelopmentTip.t} | {:error, term}
  def remove(development_tip_id) when is_integer(development_tip_id) do
    with {:ok, development_tip} <- get(development_tip_id) do
      development_tip
      |> Repo.delete()
    end
  end
end
