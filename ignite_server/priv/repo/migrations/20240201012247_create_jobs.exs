defmodule Ignite.Server.Repo.Migrations.CreateJobs do
  use Ecto.Migration

  def change do
    create table(:jobs) do
      add :status, :string
      add :deployment, references(:deployments)
      add :flow, references(:flows)

      timestamps(type: :utc_datetime)
    end
  end
end
