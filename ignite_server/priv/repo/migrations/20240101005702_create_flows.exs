defmodule Ignite.Server.Repo.Migrations.CreateFlows do
  use Ecto.Migration

  def change do
    create table(:flows) do
      add(:name, :string)
      add(:module, :string)

      timestamps(type: :utc_datetime)
    end
  end
end
