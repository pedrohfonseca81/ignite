defmodule Ignite.Response do
  defstruct [
    :type,
    :message
  ]

  def ok(message \\ nil) do
    %__MODULE__{
      type: :ok,
      message: message
    }
  end

  def err(message \\ nil) do
    %__MODULE__{
      type: :err,
      message: message
    }
  end
end
