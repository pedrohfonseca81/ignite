defmodule Ignite.Deployment do
  alias Ignite.Api.Deploy

  defstruct [
    :name,
    :schedule,
    :cron,
    :tags,
    :flow,
    :worker
  ]

  defmacro __using__(_options) do
    quote do
      Module.register_attribute(__MODULE__, :deployments, accumulate: true)

      import unquote(__MODULE__)

      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def spec(), do: @deployments

      def create_deployment(), do: Deploy.new(@deployments)
    end
  end

  defmacro deploy(flow, options) do
    do_deploy(flow, options)
  end

  defp do_deploy(flow, options) do
    quote do
      unquote(__MODULE__).__define__(__MODULE__, :deployments, %Ignite.Deployment{
        flow: unquote(flow),
        name: unquote(options)[:name],
        schedule: unquote(options)[:schedule],
        cron: unquote(options)[:cron],
        tags: unquote(options)[:tags]
      })
    end
  end

  def __define__(module, attribute, value) do
    Module.put_attribute(module, attribute, value)
  end
end
