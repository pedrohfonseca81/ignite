defmodule Ignite.Server.Repo.Migrations.CreateDeployments do
  use Ecto.Migration

  def change do
    create table(:deployments) do
      add(:name, :string)
      add(:schedule, :timestamp)
      add(:cron, :string)
      add(:flow_id, references(:flows))
      add(:worker, :string)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:deployments, [:name])
  end
end
