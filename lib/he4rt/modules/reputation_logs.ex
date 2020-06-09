defmodule He4rt.Modules.ReputationLogs do
  @moduledoc """
  The ReputationLogs context.

  Handle reputation logs from Database
  """
  import Ecto.Query

  alias He4rt.Repo
  alias He4rt.Schemas.ReputationLog

  @preload [:user, :receiver]

  @doc """
  Retrieve one reputation log by ID
  """
  @spec get(reputation_log_id :: pos_integer()) :: {:ok, ReputationLog.t} | {:error, term}
  def get(reputation_log_id) when is_integer(reputation_log_id) do
    from(
      m in ReputationLog,
      where: m.id == ^reputation_log_id,
      preload: ^@preload
    )
    |> Repo.one()
    |> case do
      nil ->
        {:error, :not_found}

      reputation_log ->
        {:ok, reputation_log}
    end
  end

  @doc """
  Retrieve all reputation logs
  """
  @spec retrieve_all() :: {:ok, list(ReputationLog.t)} | {:error, term}
  def retrieve_all() do
    from(
      m in ReputationLog,
      preload: ^@preload,
      order_by: [desc: m.created_at]
    )
    |> Repo.all()
    |> case do
      [] ->
        {:error, :not_found}

      reputation_logs ->
        {:ok, reputation_logs}
    end
  end

  @doc """
  Retrieve all reputation logs from user 
  """
  @spec retrieve_all_from_user(user_id :: pos_integer()) :: {:ok, list(ReputationLog.t)} | {:error, term}
  def retrieve_all_from_user(user_id) when is_integer(user_id) do
    from(
      m in ReputationLog,
      where: m.user_id == ^user_id,
      preload: ^@preload,
      order_by: [desc: m.created_at]
    )
    |> Repo.all()
    |> case do
      [] ->
        {:error, :not_found}

      reputation_logs ->
        {:ok, reputation_logs}
    end
  end

  @doc """
  Retrieve all user products from receiver 
  """
  @spec retrieve_all_from_receiver(receiver_id :: pos_integer()) :: {:ok, list(ReputationLog.t)} | {:error, term}
  def retrieve_all_from_receiver(receiver_id) when is_integer(receiver_id) do
    from(
      m in ReputationLog,
      where: m.receiver_id == ^receiver_id,
      preload: ^@preload,
      order_by: [desc: m.created_at]
    )
    |> Repo.all()
    |> case do
      [] ->
        {:error, :not_found}

      reputation_logs ->
        {:ok, reputation_logs}
    end
  end

  @doc """
  Create new reputation log
  """
  @spec create(attrs :: map()) :: {:ok, ReputationLog.t} | {:error, term}
  def create(attrs) when is_map(attrs) do
    %ReputationLog{}
    |> ReputationLog.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, reputation_log} ->
        reputation_log =
          reputation_log
          |> Repo.preload(@preload)

        {:ok, reputation_log}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Update existent reputation log
  """
  @spec update(attrs :: map()) :: {:ok, ReputationLog.t} | {:error, term}
  def update(%{"reputation_log_id" => reputation_log_id} = attrs) when is_integer(reputation_log_id) and is_map(attrs) do
    with {:ok, reputation_log} <- get(reputation_log_id) do
      reputation_log
      |> ReputationLog.changeset(attrs)
      |> Repo.update()
      |> case do
        {:ok, reputation_log} ->
          reputation_log =
            reputation_log
            |> Repo.preload(@preload)

          {:ok, reputation_log}

        {:error, reason} ->
          {:error, reason}
      end
    end
  end
end
