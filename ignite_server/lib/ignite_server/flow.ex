defmodule Ignite.Server.Flow do
  use Ecto.Schema
  import Ecto.Changeset

  schema "flows" do


    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(flow, attrs) do
    flow
    |> cast(attrs, [])
    |> validate_required([])
  end
end
