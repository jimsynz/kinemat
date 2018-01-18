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
      description: @description
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

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:earmark, ">= 0.0.0", only: :dev},
      {:credo, "~> 0.6", only: ~w(dev test)a, runtime: false},
      {:inch_ex, "~> 0.5", only: ~w(dev test)a, runtime: false},
      {:dialyxir, "~> 0.5", only: ~w(dev test)a, runtime: false},
      {:graphmath, "~> 1.0"},
      {:angle, ">= 0.2.1"}
    ]
  end
end
