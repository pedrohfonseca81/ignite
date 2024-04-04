defmodule Ignite.Worker.Task do
  def run_async(flow) do
    Task.Supervisor.async(Ignite.TaskSupervisor, &flow.module.ignite/0)
  end

  def count do
    Supervisor.count_children(Ignite.TaskSupervisor)
  end
end
