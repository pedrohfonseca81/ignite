defmodule Ignite.Server.Worker do
  def run(%{name: "local", deployment: deployment}) do
      IO.inspect(deployment)
  end

  def run(%{name: _name}) do
  end
end
