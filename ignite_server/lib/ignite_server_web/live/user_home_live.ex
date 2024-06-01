defmodule Ignite.ServerWeb.UserHomeLive do
  alias Ignite.Server.Deployments
  use Ignite.ServerWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="">
      <%!-- <.header class="text-center">
        Deployments
      </.header> --%>
      <div>
        <%= for deployment <- Deployments.list_deployments() do %>
          <div class="shadow-sm p-4 my-2 rounded border-l-4 border-red-700">
              <div>
                <div class="flex justify-between">
                  <p><%= deployment.name %></p>
                  <.button phx-click="run_deployment" phx-value-id={deployment.id}>
                    Run
                    <.icon name="hero-chevron-right-mini" class="mt-0.5 h-5 w-5 flex-none" />
                  </.button>
                </div>
                <div>
                  <span><%= deployment.inserted_at %></span>
                </div>
              </div>
          </div>
        <% end %>
      </div>
    </div>
    """
  end

  def handle_event("run_deployment", %{"id" => id}, socket) do
    # TO DO

    {:noreply, socket}
  end


  def mount(_params, _session, socket) do
    app_name = Application.fetch_env!(:ignite, :app_name)

    {:ok, assign(socket, page_title: app_name)}
  end
end
