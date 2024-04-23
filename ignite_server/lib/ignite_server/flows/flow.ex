defmodule Ignite.Server.Flows.Flow do
  use Ecto.Schema
  import Ecto.Changeset

  @params []

  schema "flows" do

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(deployment, attrs) do
    deployment
    |> cast(attrs, @params)
    |> validate_required(@params)
  end
end
