defmodule Scratch.MixProject do
  use Mix.Project

  def project do
    [
      app: :scratch,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Scratch.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:bloom_filter, "~> 1.0.0"},
      {:benchee, "~> 1.0", only: :dev},
      {:stream_data, "~> 0.5"},
      {:bloomex, "~> 1.0"}
    ]
  end
end
