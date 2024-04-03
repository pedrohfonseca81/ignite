defmodule Ignite.FlowTest do
  defmodule Flow do
    use Ignite.Flow

    deftask extract() do
      :ok
    end

    deftask extract(a, b, c) do
      {a, b, c}
    end

    deftaskp private_function() do
      :shhh
    end

    deftask using_private() do
      :shhh = private_function()
    end
  end

  use ExUnit.Case

  test "deftask without arguments returns ok" do
    assert Flow.extract() == :ok
  end

  test "deftask extract/3 returns a tuple" do
    assert Flow.extract(1, 2, 3) == {1, 2, 3}
  end

  test "deftaskp isn't visibile" do
    assert function_exported?(Flow, :private_function, 0) == false
  end

  test "using deftaskp from deftask works" do
    assert Flow.using_private() == :shhh
  end

  test "spec is ok" do
    assert Flow.spec().module == Flow
    assert Flow.spec().name == Flow |> Module.split() |> List.last()
  end
end
