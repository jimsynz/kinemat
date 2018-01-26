defmodule Kinemat.Joints do
  @moduledoc """
  Container module for Kinemat's join representations.

  `use` this module to automatically alias all joint modules.
  """

  defmacro __using__(_opts) do
    quote do
      alias Kinemat.Joints.{Revolute, Prismatic, Cylindrical}
    end
  end
end
