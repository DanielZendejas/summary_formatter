defmodule SummaryFormatter do
  @moduledoc """
  """

  alias ExUnit.Test
  alias SummaryFormatter.Server
  require IEx
  use GenServer

  ## Callbacks

  def init(opts) do
    start_accumulator_process()
    config = %{
      seed: opts[:seed],
      trace: opts[:trace],
      colors: Keyword.put_new(opts[:colors], :enabled, IO.ANSI.enabled?()),
      width: get_terminal_width(),
      slowest: opts[:slowest],
      test_counter: %{},
      test_timings: [],
      failure_counter: 0,
      failed_tests: [],
      skipped_counter: 0,
      invalid_counter: 0,
    }
    {:ok, config}
  end

  def handle_cast({:test_finished, %Test{state: {:failed, _}} = test}, state) do
    new_failed_tests = state.failed_tests ++ [test]
    new_state = %{state | failed_tests: new_failed_tests}
    {:noreply, new_state}
  end

  def handle_cast({:suite_finished, _, _}, state) do
    Server.add_tests(state.failed_tests)
    {:noreply, state}
  end

  def handle_cast(event, state) do
    ExUnit.CLIFormatter.handle_cast(event, state)
  end

  defp get_terminal_width do
    case :io.columns() do
      {:ok, width} -> max(40, width)
      _ -> 80
    end
  end

  defp start_accumulator_process() do
    SummaryFormatter.Server.start_link([])
  end
end
