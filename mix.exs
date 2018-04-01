defmodule SummaryFormatter.Mixfile do
  use Mix.Project

  def project do
    [
      app: :summary_formatter,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: []
    ]
  end

  @doc false
  def application, do: []

  @doc false
  def description() do
    """
    Simple ExUnit formatter that will print a summary of the failed tests when
    finished. It supports umbrella apps, where each test suite is executed on
    its own.
    """
  end

  def package() do
    github_link = "https://github.com/danielzendejas/summary_formatter"
    [
      files: ["lib", "mix.exs", "README*", "readme*", "LICENSE*", "license*"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => github_link},
      maintainers: ["Daniel Zendejas"],
      name: "summary_formatter",
      source_url: github_link
    ]
  end
end
