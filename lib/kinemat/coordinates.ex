defmodule Kinemat.Coordinates do
  @moduledoc """
  Container module for Kinemat's coodinate representations.
  """

  defmacro __using__(_opts) do
    quote do
      alias Kinemat.Coordinates.{Cartesian, Cylindrical, Spherical}
    end
  end
end
