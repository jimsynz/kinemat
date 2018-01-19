defmodule Kinemat.Orientations do
  @moduledoc """
  Container module for Kinemat's orientation representations.

  `use` this module to automatically alias all orientation modules.
  """

  defmacro __using__(_opts) do
    quote do
      alias Kinemat.Orientations.{Euler, Quaternion, RotationMatrix}
    end
  end
end
