defmodule Ignite.Server.Deployments.Deployment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "deployments" do


    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(deployment, attrs) do
    deployment
    |> cast(attrs, [])
    |> validate_required([])
  end
end
