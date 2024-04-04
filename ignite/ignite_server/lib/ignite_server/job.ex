defmodule Ignite.Server.Job do
  use Ecto.Schema
  import Ecto.Changeset

  schema "jobs" do
    field :status, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [:status])
    |> validate_required([:status])
  end
end
