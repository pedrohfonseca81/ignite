defmodule Ignite.Api.Deploy do
  def new(deployments) do
    deployments_as_json = deployments |> parse_deployment()

    deployments_as_json
  end

  def parse_deployment(deployments) do
    deployments |> Enum.map(&expand_deployment/1)
  end

  def expand_deployment(deployment) do
    %{
      name: deployment.name,
      schedule: deployment.schedule,
      cron: deployment.cron,
      tags: deployment.tags,
      flow: deployment.flow.spec()
    }
  end
end
