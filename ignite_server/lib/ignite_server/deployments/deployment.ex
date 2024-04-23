defmodule Ignite.Server.Deployments.Deployment do
  use Ecto.Schema
  import Ecto.Changeset

  @params [:name, :schedule, :cron, :worker]
  @validate @params ++ [:flow]

  schema "deployments" do
    field :name, :string
    field :schedule, :utc_datetime
    field :cron, :string
    belongs_to :flow, Ignite.Server.Flows.Flow
    field :worker, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(deployment, attrs) do
    deployment
    |> cast(attrs, @params)
    |> cast_assoc(:flow)
    |> validate_required(@validate)
  end
end
