defmodule Ignite.Api.Deploy do
  @create_deployment "/deployments"

  alias Crontab.CronExpression.Composer

  def new(server, deployments) do
    deployments_as_json = deployments |> parse_deployment()

    Req.post!(server, url: @create_deployment, json: deployments_as_json)
  end

  def parse_deployment(deployments) do
    deployments |> Enum.map(&expand_deployment/1)
  end

  def expand_deployment(deployment) do
    flow = deployment.flow.spec()

    tags =
      if(is_list(deployment.tags)) do
        Enum.map(deployment.tags, fn tag -> %{name: tag} end)
      else
        []
      end

    %{
      name: deployment.name,
      schedule: deployment.schedule,
      worker: deployment.worker,
      cron:
        if(is_atom(deployment.cron),
          do: to_string(deployment.cron),
          else: Composer.compose(deployment.cron)
        ),
      tags: tags,
      flow: %{
        name: flow.name,
        module: to_string(flow.module),
        tasks:
          flow.tasks
          |> Enum.map(&Map.from_struct/1)
          |> Enum.map(fn task ->
            %{
              name: task.name,
              as: to_string(task.as),
              kind: to_string(task.kind),
              arity: task.arity,
              position: %{
                line: Keyword.get(task.position, :line),
                column: Keyword.get(task.position, :column)
              }
            }
          end),
        dict: flow.dict
      }
    }
  end
end
