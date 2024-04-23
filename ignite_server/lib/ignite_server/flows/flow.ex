defmodule Ignite.Server.Flows.Flow do
  use Ecto.Schema
  import Ecto.Changeset

  @params [:name, :module]

  schema "flows" do
    field :name, :string
    field :module, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(deployment, attrs) do
    deployment
    |> cast(attrs, @params)
    |> validate_required(@params)
  end
end
