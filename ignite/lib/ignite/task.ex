defmodule Ignite.Task do
  defstruct [
    :name,
    :as,
    :kind,
    :arity,
    :position
  ]

  defimpl Jason.Encoder do
    def encode(value, opts) do
      Jason.Encode.map(Map.from_struct(value), opts)
    end
  end
end
