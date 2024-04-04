defmodule Ignite.Worker do
  @spec register(atom(), any()) :: nil
  defmacro register(name, options) when is_atom(name) do
    do_register(name, options)
  end

  defp do_register(name, options) do
  end

  def healthy?(name) when is_atom(name) do
  end
end
