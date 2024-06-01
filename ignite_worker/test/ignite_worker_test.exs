defmodule IgniteWorkerTest do
  use ExUnit.Case
  doctest IgniteWorker

  test "greets the world" do
    assert IgniteWorker.hello() == :world
  end
end
