defmodule Ignite.Server.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [])
    |> validate_required([])
  end
end
