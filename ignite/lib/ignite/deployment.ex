defmodule Ignite.Deployment do
  import Crontab.CronExpression
  alias Crontab.CronExpression.Parser
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

  defmacro deploy(flow, call) do
    do_deploy(flow, call)
  end

  defp do_deploy(flow, call) do
    {_, _, options} = call

    cron = Macro.escape(parse_cron(options[:cron]))

    quote do
      unquote(__MODULE__).__define__(__MODULE__, :deployments, %Ignite.Deployment{
        flow: unquote(flow),
        name: unquote(options)[:name],
        schedule: unquote(options)[:schedule],
        cron: unquote(cron),
        tags: unquote(options)[:tags],
        worker: unquote(options)[:worker]
      })
    end
  end

  defp parse_cron(cron) do
    case Parser.parse(cron) do
      {:ok, cron} -> cron
      {:error, message} -> :invalid_cron
    end
  end

  def __define__(module, attribute, value) do
    Module.put_attribute(module, attribute, value)
  end
end
