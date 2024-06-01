defmodule Ignite.Deployment do
  alias Crontab.CronExpression.Parser
  alias Ignite.Api.Deploy

  defstruct [
    :name,
    :schedule,
    :cron,
    :tags,
    :flow,
    worker: :local
  ]

  defimpl Jason.Encoder do
    def encode(value, opts) do
      Jason.Encode.map(Map.from_struct(value), opts)
    end
  end

  defmacro __using__(_options) do
    quote do
      use GenServer
      import unquote(__MODULE__)

      Module.register_attribute(__MODULE__, :deployments, accumulate: true)

      def start_link(hostname) when is_binary(hostname) do
        create_deployment(hostname)

        GenServer.start_link(__MODULE__, hostname, name: __MODULE__)
      end

      def start_link(_) do
        hostname = "http://localhost:4000"

        create_deployment(hostname)

        GenServer.start_link(__MODULE__, hostname, name: __MODULE__)
      end

      def init(state) do
        {:ok, state}
      end

      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def spec(), do: @deployments

      def create_deployment(server), do: Deploy.new(Req.new(base_url: server), @deployments)
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
