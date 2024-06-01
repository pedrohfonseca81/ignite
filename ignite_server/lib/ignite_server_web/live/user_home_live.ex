defmodule Ignite.ServerWeb.UserHomeLive do
  alias Ignite.Server.Deployments
  alias Ignite.Server.Repo
  alias Ignite.Server.Worker
  use Ignite.ServerWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="">
      <%!-- <.header class="text-center">
        Deployments
      </.header> --%>
      <div>
        <%= for deployment <- Repo.preload(Deployments.list_deployments(), [:tags]) do %>
          <div class="shadow-sm p-4 my-2 rounded border-l-4 border-red-700">
              <div>
                <div class="flex justify-between">
                  <p><%= deployment.name %></p>
                  <.button phx-click="run_deployment" phx-value-id={deployment.id} phx-value-worker={deployment.worker}>
                    Run
                    <.icon name="hero-chevron-right-mini" class="mt-0.5 h-5 w-5 flex-none" />
                  </.button>
                </div>
                <div>
                  <span><%= deployment.inserted_at %></span>
                  <div>
                    <%= for tag <- deployment.tags do %>
                      <span class="bg-red-700 text-pink-800 text-xs font-medium me-2 px-2.5 py-0.5 rounded dark:bg-red-700 dark:text-white">
                      <%= tag.name %>
                      </span>
                    <% end %>
                  </div>
                </div>
              </div>
          </div>
        <% end %>
      </div>
    </div>
    """
  end

  def handle_event("run_deployment", %{"id" => id, "worker" => worker}, socket) do
    Worker.run(%{name: worker, deployment: id})

    {:noreply, socket}
  end


  def mount(_params, _session, socket) do
    app_name = Application.fetch_env!(:ignite, :app_name)

    {:ok, assign(socket, page_title: app_name)}
  end
end
