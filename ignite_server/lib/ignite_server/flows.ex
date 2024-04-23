defmodule Ignite.Server.Flows do
  @moduledoc """
  The Flows context.
  """

  import Ecto.Query, warn: false
  alias Ignite.Server.Repo

  alias Ignite.Server.Flows.Flow

  @doc """
  Returns the list of Flows.

  ## Examples

      iex> list_Flows()
      [%Flow{}, ...]

  """
  def list_Flows do
    Repo.all(Flow)
  end

  @doc """
  Gets a single Flow.

  Raises `Ecto.NoResultsError` if the Flow does not exist.

  ## Examples

      iex> get_Flow!(123)
      %Flow{}

      iex> get_Flow!(456)
      ** (Ecto.NoResultsError)

  """
  def get_flow!(id), do: Repo.get!(Flow, id)

  @doc """
  Creates a Flow.

  ## Examples

      iex> create_Flow(%{field: value})
      {:ok, %Flow{}}

      iex> create_Flow(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_flow(attrs \\ %{}) do
    %Flow{}
    |> Flow.changeset(attrs)
    |> Repo.insert()
    |> IO.inspect()
  end

  @doc """
  Updates a Flow.

  ## Examples

      iex> update_Flow(Flow, %{field: new_value})
      {:ok, %Flow{}}

      iex> update_Flow(Flow, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_flow(%Flow{} = Flow, attrs) do
    Flow
    |> Flow.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Flow.

  ## Examples

      iex> delete_Flow(Flow)
      {:ok, %Flow{}}

      iex> delete_Flow(Flow)
      {:error, %Ecto.Changeset{}}

  """
  def delete_flow(%Flow{} = Flow) do
    Repo.delete(Flow)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking Flow changes.

  ## Examples

      iex> change_Flow(Flow)
      %Ecto.Changeset{data: %Flow{}}

  """
  def change_flow(%Flow{} = Flow, attrs \\ %{}) do
    Flow.changeset(Flow, attrs)
  end
end
