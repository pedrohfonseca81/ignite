defmodule Ignite.Server.Repo do
  use Ecto.Repo,
    otp_app: :ignite_server,
    adapter: Ecto.Adapters.Postgres
end
