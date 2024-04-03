defmodule Ignite.Server.Account do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ignite.Server.Repo

  schema "accounts" do
    field(:username, :string)
    field(:password, :string)

    timestamps(type: :utc_datetime)
  end

  def create_account(username, password) do
    registration_changeset(%__MODULE__{}, %{"username" => username, "password" => password})
    |> Repo.insert()
  end

  defp registration_changeset(account, attrs) do
    account
    |> cast(attrs, [:username, :password])
    |> put_password_hash()
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, password: Bcrypt.hash_pwd_salt(password))
  end

  defp put_password_hash(changeset), do: changeset
end
