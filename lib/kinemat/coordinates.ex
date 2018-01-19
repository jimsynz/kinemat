defmodule Kinemat.Coordinates do
  @moduledoc """
  Container module for Kinemat's coodinate representations.

  `use` this module to automatically alias all coordinate modules.
  """

  defmacro __using__(_opts) do
    quote do
      alias Kinemat.Coordinates.{Cartesian, Cylindrical, Spherical}
    end
  end
end
