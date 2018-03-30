defmodule SummaryFormatter.Server do
  @moduledoc """
  """

  alias ExUnit.Test
  use GenServer

  # Client

  @doc """
  """
  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @doc """
  """
  def add_tests(tests) when is_list(tests) do
    GenServer.cast(__MODULE__, {:add_tests, tests})
  end

  # Server

  @doc false
  def init(_) do
    Process.flag(:trap_exit, true)
    {:ok, %{}}
  end

  @doc """
  """
  def handle_cast({:add_tests, tests}, state) when is_list(tests) do
    new_state = Map.put(state, get_tests_module_name(tests), tests)
    {:noreply, new_state}
  end

  @doc """
  """
  def terminate(_, state) do
    Enum.each(state, &print_test_module_results/1)
  end

  defp get_tests_module_name([%Test{} = ex_unit_test | _]) do
    ex_unit_test.case
  end

  defp print_test_module_results({module_name, tests}) when is_list(tests) do
    tests_results = tests |> Enum.map(&get_test_message/1) |> Enum.join("\n")
    IO.puts("===== FAILED TESTS SUMMARY ======")
    IO.puts("===== #{module_name} ======")
    IO.puts("#{tests_results}")
  end

  defp get_test_message(%Test{} = ex_unit_test) do
    {file, line} = get_test_file_and_line(ex_unit_test)
    message = file
      |> Exception.format_file_line(line, nil)
      |> String.trim_trailing(":")
    "mix test #{message}"
  end

  defp get_test_file_and_line(%Test{} = ex_unit_test) do
    %{state: {
      :failed,
      [{_, _, [{_, _, _, [file: file, line: line]}]}]}
    } = ex_unit_test
    {file, line}
  end
end
