defmodule Ignite.ServerWeb.DeploymentsController do
  use Ignite.ServerWeb, :controller

  alias Ignite.Server.Accounts
  alias Ignite.ServerWeb.UserAuth
  alias Ignite.Server.Deployments

  def index(conn, _params) do
    deployments = Deployments.list_deployments()

    json(conn, deployments)
  end

  def create(conn, params) do
    IO.inspect(params)
    case Deployments.create_deployment(params) do
      {:ok, deployment} ->
        json(conn, %{"deployment" => deployment.id})

      {:error, changeset} ->
        conn
        |> put_status(400)
        |> json(%{"errors" => parse_error(changeset)})
    end
  end

  defp parse_error(changeset) do
    Enum.reduce(changeset.errors, %{}, fn {key, value}, acc ->
      {message, _validation} = value

      Map.put(acc, key, message)
    end)
  end
end
