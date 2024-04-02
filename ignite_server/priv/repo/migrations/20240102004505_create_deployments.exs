defmodule Ignite.Server.Repo.Migrations.CreateDeployments do
  use Ecto.Migration

  def change do
    create table(:deployments) do
      add :status, :string

      timestamps(type: :utc_datetime)
    end
  end
end
