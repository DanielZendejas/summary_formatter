defmodule SummaryFormatterTest do
  use ExUnit.Case
  doctest SummaryFormatter

  test "greets the world" do
    assert SummaryFormatter.hello() == :world
  end
end
