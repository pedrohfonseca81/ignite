defmodule Ignite.Server.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Ignite.ServerWeb.Telemetry,
      Ignite.Server.Repo,
      {DNSCluster, query: Application.get_env(:ignite_server, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Ignite.Server.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Ignite.Server.Finch},
      # Start a worker by calling: Ignite.Server.Worker.start_link(arg)
      # {Ignite.Server.Worker, arg},
      # Start to serve requests, typically the last entry
      Ignite.ServerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Ignite.Server.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Ignite.ServerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
