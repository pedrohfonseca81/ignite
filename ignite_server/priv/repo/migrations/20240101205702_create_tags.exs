defmodule Ignite.Server.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :name, :string
      add :deployment_id, references(:deployments)

      timestamps(type: :utc_datetime)
    end
  end
end
