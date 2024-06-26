defmodule Ignite.Server.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :flow, references(:flows)

      timestamps(type: :utc_datetime)
    end
  end
end
