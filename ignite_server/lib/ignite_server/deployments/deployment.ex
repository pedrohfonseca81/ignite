defmodule Ignite.Server.Deployments.Deployment do
  use Ecto.Schema
  import Ecto.Changeset

  @params [:name, :cron, :worker]
  @validate @params ++ [:flow, :tags]

  schema "deployments" do
    field :name, :string
    field :schedule, :utc_datetime
    field :cron, :string
    field :worker, :string
    belongs_to :flow, Ignite.Server.Flows.Flow
    has_many :tags, Ignite.Server.Tag

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(deployment, attrs) do
    deployment
    |> cast(attrs, @params)
    |> unique_constraint([:name])
    |> cast_assoc(:flow)
    |> cast_assoc(:tags)
    |> validate_required(@validate)
  end
end
