defmodule Kinemat.Mixfile do
  use Mix.Project

  @description """
  Forward and reverse kinematics for robotics and simulations.
  """
  @version "0.1.0"

  def project do
    [
      app: :kinemat,
      version: @version,
      elixir: "~> 1.5",
      start_permanent: Mix.env() == :prod,
      package: package(),
      deps: deps(),
      description: @description,
      elixirc_paths: elixirc_paths(Mix.env())
    ]
  end

  def package do
    [
      maintainers: ["James Harton <james@automat.nz>"],
      licenses: ["MIT"],
      links: %{
        "Source" => "https://gitlab.com/jimsy/kinemat"
      }
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:angle, ">= 0.2.1"},
      {:ex_doc, ">= 0.0.0", only: ~w(dev test)a},
      {:earmark, ">= 0.0.0", only: ~w(dev test)a},
      {:credo, "~> 1.4", only: ~w(dev test)a, runtime: false},
      {:graphmath, "~> 2.0"},
      {:uuid, "~> 1.1"}
    ]
  end
end
