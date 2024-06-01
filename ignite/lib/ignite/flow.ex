defmodule Ignite.Flow do
  alias Ignite.{Task, Flow}
  alias Ignite.Api.Telemetry
  import Ignite.Worker

  @callback ignite() :: %Ignite.Response{} | any()

  @optional_callbacks ignite: 0

  defstruct [
    :name,
    :module,
    :tasks,
    :dict
  ]

  defimpl Jason.Encoder do
    def encode(value, opts) do
      Jason.Encode.map(Map.from_struct(value), opts)
    end
  end

  defmacro __using__(_options) do
    quote do
      @behaviour unquote(__MODULE__)
      import unquote(__MODULE__)
      alias Ignite.Response

      register(:default, %{})

      Module.register_attribute(__MODULE__, :tasks, accumulate: true)
      Module.register_attribute(__MODULE__, :tasks_dict, accumulate: true)
      Module.register_attribute(__MODULE__, :name, [])

      @name __MODULE__ |> Module.split() |> List.last()

      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def spec(),
        do: %Flow{
          name: @name,
          module: __MODULE__,
          tasks: @tasks,
          dict: @tasks_dict
        }
    end
  end

  @doc """
  Defines the task in the task dictionary.

  ## Examples

      task :authentication, as: "Api authenticator"

      deftask authentication() do
          :ok
      end
  """
  defmacro task(call, as: name) do
    apply_task_meaning(call, name)
  end

  @doc """
  Defines a public task function in a flow. This is important because will
  record the task metadata in database and send telemetry to local server.

  ## Examples
      defmodule MyFlow do
        deftask authentication() do
            :ok
        end

        def ignite() do
          :ok = authentication()
        end
      end
  """
  defmacro deftask(call, do: block) do
    define_task(:def, call, block)
  end

  @doc """
  Defines a private task function in a flow.

  ## Examples
      defmodule MyFlow do
        deftaskp authentication() do
            :ok
        end

        def ignite() do
          :ok = authentication()
        end
      end

      iex> Myflow.authentication()
      ** (UndefinedFunctionError) function MyFlow.authentication/0 is undefined or private.
  """
  defmacro deftaskp(call, do: block) do
    define_task(:defp, call, block)
  end

  defp define_task(kind, call, block) do
    {name, position, args} = call

    arity = args |> length

    quote do
      unquote(__MODULE__).__define__(__MODULE__, :tasks, %Task{
        name: to_string(unquote(name)),
        position: unquote(position),
        arity: unquote(arity),
        as: unquote(name),
        kind: unquote(kind)
      })

      unquote(kind)(unquote(call)) do
        task = %Task{
          name: to_string(unquote(name)),
          position: unquote(position),
          arity: unquote(arity),
          as: unquote(name),
          kind: unquote(kind)
        }

        Telemetry.send_start_task(task)

        unquote(block)
      end
    end
  end

  defp apply_task_meaning(call, name) do
    quote do
      unquote(__MODULE__).__define__(
        __MODULE__,
        :tasks_dict,
        {unquote(call), unquote(name)}
      )
    end
  end

  def __define__(module, attribute, value) do
    Module.put_attribute(module, attribute, value)
  end
end
