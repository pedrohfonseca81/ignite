defmodule Ignite.Api.Telemetry do
  def send_start_task(task) do
    IO.inspect(task)

    task
  end

  def send_end_task(result, _task) do
    result
  end
end
