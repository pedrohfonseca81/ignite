defmodule Ignite.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Task.Supervisor, name: Ignite.TaskSupervisor}
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
