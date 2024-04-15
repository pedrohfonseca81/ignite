defmodule Ignite.ServerWeb.DeploymentsController do
  use Ignite.ServerWeb, :controller

  alias Ignite.Server.Accounts
  alias Ignite.ServerWeb.UserAuth

  def index(conn, _params) do
      json(conn, %{test: "123"})
  end
end