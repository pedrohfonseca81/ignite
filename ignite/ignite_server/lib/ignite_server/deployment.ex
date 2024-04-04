defmodule Ignite.Server.Deployment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "deployments" do
    field :status, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(deployment, attrs) do
    deployment
    |> cast(attrs, [])
    |> validate_required([])
  end
end
