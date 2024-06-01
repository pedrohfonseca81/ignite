defmodule Ignite.Server.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tags" do
    field :name, :string
    belongs_to :deployment, Ignite.Server.Deployments.Deployment

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(tags, attrs) do
    tags
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
