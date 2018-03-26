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
  def handle_cast({:add_tests, tests}, state) do
    new_state = Map.put(state, get_tests_module_name(tests), tests)
    {:noreply, new_state}
  end

  @doc """
  """
  def terminate(reason, state) do
  end

  defp get_tests_module_name([%Test{} = ex_unit_test | _]) do
    ex_unit_test.case
  end
end
