defmodule Ignite.Server.DeploymentsTest do
  use Ignite.Server.DataCase

  alias Ignite.Server.Deployments

  describe "deployments" do
    alias Ignite.Server.Deployments.Deployment

    import Ignite.Server.DeploymentsFixtures

    @invalid_attrs %{}

    test "list_deployments/0 returns all deployments" do
      deployment = deployment_fixture()
      assert Deployments.list_deployments() == [deployment]
    end

    test "get_deployment!/1 returns the deployment with given id" do
      deployment = deployment_fixture()
      assert Deployments.get_deployment!(deployment.id) == deployment
    end

    test "create_deployment/1 with valid data creates a deployment" do
      valid_attrs = %{}

      assert {:ok, %Deployment{} = deployment} = Deployments.create_deployment(valid_attrs)
    end

    test "create_deployment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Deployments.create_deployment(@invalid_attrs)
    end

    test "update_deployment/2 with valid data updates the deployment" do
      deployment = deployment_fixture()
      update_attrs = %{}

      assert {:ok, %Deployment{} = deployment} = Deployments.update_deployment(deployment, update_attrs)
    end

    test "update_deployment/2 with invalid data returns error changeset" do
      deployment = deployment_fixture()
      assert {:error, %Ecto.Changeset{}} = Deployments.update_deployment(deployment, @invalid_attrs)
      assert deployment == Deployments.get_deployment!(deployment.id)
    end

    test "delete_deployment/1 deletes the deployment" do
      deployment = deployment_fixture()
      assert {:ok, %Deployment{}} = Deployments.delete_deployment(deployment)
      assert_raise Ecto.NoResultsError, fn -> Deployments.get_deployment!(deployment.id) end
    end

    test "change_deployment/1 returns a deployment changeset" do
      deployment = deployment_fixture()
      assert %Ecto.Changeset{} = Deployments.change_deployment(deployment)
    end
  end
end
