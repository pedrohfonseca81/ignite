defmodule Ignite.DeploymentTest do
  defmodule Flow do
    use Ignite.Flow

    deftask sum(a, b) do
      a + b
    end
  end

  defmodule Deployment do
    use Ignite.Deployment

    deploy(Flow, %{name: "Flow deployment", cron: "* * * * *", worker: :local, tags: ["Development"]})
    deploy(Flow, %{name: "Invalid cron", cron: "anything", worker: :local})
  end

  use ExUnit.Case
  require Ignite.Deployment

  test "the deployment flow has a valid cron" do
    flow =
      Deployment.spec() |> Enum.find(fn deployment -> deployment.name === "Flow deployment" end)

    assert flow.cron != :invalid_cron
  end

  test "the flow deployment has a invalid cron" do
    flow =
      Deployment.spec() |> Enum.find(fn deployment -> deployment.name === "Invalid cron" end)

    assert flow.cron == :invalid_cron
  end

  test "the flow deployment has the worker :local" do
    flow =
      Deployment.spec() |> Enum.find(fn deployment -> deployment.name === "Flow deployment" end)

    assert flow.worker == :local
  end

  test "the flow deployment has a tag" do
    flow =
      Deployment.spec() |> Enum.find(fn deployment -> deployment.name === "Flow deployment" end)

    [tag] = flow.tags

    assert tag == "Development"
  end

  test "deploy flows supervised" do
    assert match?({:ok, _}, start_supervised({Deployment, "http://localhost:4000"}))
  end
end
