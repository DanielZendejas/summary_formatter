# SummaryFormatter
Simple ExUnit formatter that will print a summary of the failed tests when
finished. It supports umbrella apps, where each test suite is executed on its
own.

## Installation

The package can be installed by adding `summary_formatter` to your list of
dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:summary_formatter, "~> 0.1.0"}
  ]
end
```
