defmodule Ignite.Server.DeploymentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ignite.Server.Deployments` context.
  """

  @doc """
  Generate a deployment.
  """
  def deployment_fixture(attrs \\ %{}) do
    {:ok, deployment} =
      attrs
      |> Enum.into(%{

      })
      |> Ignite.Server.Deployments.create_deployment()

    deployment
  end
end
