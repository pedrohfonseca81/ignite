defmodule Ignite.ServerWeb.UserHomeLive do
  use Ignite.ServerWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-sm">
      <.header class="text-center">
        Sign in to account
      </.header>

      <div>

      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "e")}
  end
end
