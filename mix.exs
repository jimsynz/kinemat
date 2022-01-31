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
      maintainers: ["James Harton <james@harton.nz>"],
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
      {:angle, ">= 0.3.0"},
      {:credo, "~> 1.6", only: ~w(dev test)a, runtime: false},
      {:ex_doc, ">= 0.26.0", only: ~w(dev test)a},
      {:earmark, ">= 1.4.20", only: ~w(dev test)a},
      {:git_ops, "~> 2.4", only: ~w[dev test]a, runtime: false},
      {:graphmath, "~> 2.5"}
    ]
  end
end
