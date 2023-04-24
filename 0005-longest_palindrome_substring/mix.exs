defmodule LongestPalindromeSubstring.MixProject do
  use Mix.Project

  def project do
    [
      app: :longest_palindrome_substring,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:mix_test_watch, "~> 1.0", only: [:dev, :test], runtime: false},
      {:benchee, "~> 1.0", only: :dev}
    ]
  end
end