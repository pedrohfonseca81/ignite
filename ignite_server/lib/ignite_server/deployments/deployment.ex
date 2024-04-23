defmodule Ignite.Server.Deployments.Deployment do
  use Ecto.Schema
  import Ecto.Changeset

  @params [:name, :schedule, :cron, :worker, :flow]

  schema "deployments" do
    field :name, :string
    field :schedule, :utc_datetime
    field :cron, :string
    field :flow, :integer
    field :worker, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(deployment, attrs) do
    deployment
    |> cast(attrs, @params)
    |> constraint(:flow)
    |> validate_required(@params)
  end
end
